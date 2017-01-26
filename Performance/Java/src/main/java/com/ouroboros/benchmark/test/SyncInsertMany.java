package com.ouroboros.benchmark.test;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SyncInsertMany implements Benchmark {
    @Override
    public String getName() {
        return "sync insert batch";
    }

    @Override
    public void test(Runnable done) {
        try (MongoClient client = new MongoClient()) {
            MongoDatabase db = client.getDatabase("compare");
            MongoCollection<Document> users = db.getCollection("users");

            List<Document> batch1 = new ArrayList<>();
            List<Document> batch2 = new ArrayList<>();

            for (int i = 0; i < 10000; i++) {
                batch1.add(new Document()
                        .append("name_first", "Joannis")
                        .append("name_last", "Orlandos")
                        .append("age", 20)
                        .append("programmer", true)
                        .append("likes", Arrays.asList("mongodb", "swift", "programming", "swimming")));
                batch2.add(new Document()
                        .append("name_first", "Harriebob")
                        .append("name_last", "Narwhal")
                        .append("age", 42)
                        .append("programmer", false)
                        .append("likes", Arrays.asList("facebook", "golfing", "cooking", "reading")));
            }

            users.insertMany(batch1);
            users.insertMany(batch2);

            int counter = 0;
            int counter2 = 0;

            for (Document ignored : users.find(new Document("age", new Document("$gt", 18)))) {
                counter++;
            }

            for (Document ignored : users.find(new Document("name_first", "Joannis"))) {
                counter2++;
            }

            users.deleteMany(new Document());

            System.out.println("counter = " + counter);
            System.out.println("counter2 = " + counter2);
            done.run();
        }
    }
}

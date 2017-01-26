package com.ouroboros.benchmark.test;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.Arrays;

public class SyncInsert implements Benchmark {
    @Override
    public String getName() {
        return "sync insert single";
    }

    @Override
    public void test(Runnable done) {
        try (MongoClient client = new MongoClient()) {
            MongoDatabase db = client.getDatabase("compare");
            MongoCollection<Document> users = db.getCollection("users");

            for (int i = 0; i < 10000; i++) {
                users.insertOne(new Document("_id", ObjectId.get())
                        .append("name_first", "Joannis")
                        .append("name_last", "Orlandos")
                        .append("age", 20)
                        .append("programmer", true)
                        .append("likes", Arrays.asList("mongodb", "swift", "programming", "swimming")));
                users.insertOne(new Document("_id", ObjectId.get())
                        .append("name_first", "Harriebob")
                        .append("name_last", "Narwhal")
                        .append("age", 42)
                        .append("programmer", false)
                        .append("likes", Arrays.asList("facebook", "golfing", "cooking", "reading")));
            }

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

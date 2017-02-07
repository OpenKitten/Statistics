package com.ouroboros.benchmark;

import com.mongodb.MongoClient;
import com.ouroboros.benchmark.test.Benchmark;
import com.ouroboros.benchmark.test.SyncInsertMany;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Application {
    public static void main(String... args) {
        final int iterations = 100;
        final int window = 90;
        
        List<Long> results = new ArrayList<>();
        
        for (int i = 0; i < iterations; i++) {
            long start = System.nanoTime();
            try (MongoClient pool = new MongoClient()) {
            	new SyncInsertMany(pool).test();                
            }
            results.add(System.nanoTime() - start);
        }
        
        Collections.sort(results);
        double averageNano = results.stream()
                .skip((iterations - window) / 2)
                .limit(window)
                .mapToLong(i -> i)
                .average()
                .getAsDouble();
        
        System.out.printf("%f s", averageNano / 1_000_000_000);
    }
}

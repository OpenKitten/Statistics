package com.ouroboros.benchmark.test;

public interface Benchmark {
    String getName();

    void test(Runnable done);

    default void run() {
        long start = System.nanoTime();
        test(() -> {
            long elapsedNanos = System.nanoTime() - start;
            System.out.println(getName() + ": " + elapsedNanos / 1000000.0 + "ms");
        });
    }
}

package com.ouroboros.benchmark;

import com.ouroboros.benchmark.test.SyncInsert;
import com.ouroboros.benchmark.test.SyncInsertMany;

public class Application {
    public static void main(String... args) {
        new SyncInsert().run();
        new SyncInsertMany().run();
    }
}

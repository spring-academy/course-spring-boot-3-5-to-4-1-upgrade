Now that we've completely removed `assertj-core` from `pom.xml`, will our code still compile? Will the tests still pass?

1. **C**ompile the code.

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw clean compile
   ```

   ```shell
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   ```

   Good start.

1. **A**ssess with the dependency tree.

   Check the full dependency tree to confirm `assertj-core` is still around:

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw dependency:tree | grep assertj
   ```

   ```shell
   [INFO] |  |  +- org.assertj:assertj-core:jar:3.27.7:test
   ```

   It's still there! If you look at the surrounding lines of the full tree output, you'll see it's a transitive dependency of `spring-boot-starter-test`, which our `spring-boot-starter-webmvc-test` starter pulls in automatically:

   ```shell
   [INFO] +- org.springframework.boot:spring-boot-starter-webmvc-test:jar:4.1.0:test
   [INFO] |  +- org.springframework.boot:spring-boot-starter-jackson-test:jar:4.1.0:test
   [INFO] |  +- org.springframework.boot:spring-boot-starter-test:jar:4.1.0:test
   [INFO] |  |  +- org.springframework.boot:spring-boot-test-autoconfigure:jar:4.1.0:test
   [INFO] |  |  +- com.jayway.jsonpath:json-path:jar:2.10.0:test
   [INFO] |  |  +- ...
   [INFO] |  |  +- org.assertj:assertj-core:jar:3.27.7:test
   ```

   Notice the version even moved *up* slightly, from `3.26.0` to `3.27.7` — Spring Boot's version management is simply newer than the pin someone left behind.

1. **A**ssess by running the tests.

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw clean test
   ```

   ```shell
   [INFO] Results:
   [INFO]
   [INFO] Tests run: 19, Failures: 0, Errors: 0, Skipped: 0
   [INFO]
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   ```

   All 19 tests still pass. We never needed to declare `assertj-core` ourselves at all — it was always along for the ride.

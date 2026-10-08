Now that we've commented-out the hard-coded Spring dependency version in our `pom.xml`, let's continue with **SCAR**.

1. **C**ompile the code.

   We've made our small change, but does it compile?

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw clean compile
   ...
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  1.557 s
   [INFO] Finished at: 2026-08-14T18:17:21-06:00
   [INFO] ------------------------------------------------------------------------
   ...
   ```

   It does!

   Let's **A**ssess the change in more detail.

1. **A**ssess the `<version>` change.

   Run the `dependency:tree` goal again and note how the output changed.

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw dependency:tree | grep spring-data-jdbc
   ```

   You'll see output that looks like this:

   ```shell
   [INFO] +- org.springframework.data:spring-data-jdbc:jar:4.1.0:compile
   ```

   That's better! The version is now `4.1.0` instead of `3.4.5`.

   The Spring Boot Parent is now managing that dependency for us, and it should remain up to date with whatever version the parent deems necessary to include that dependency.

   Thanks, Spring Boot Parent!

   **_A note of caution:_** a clean compile is reassuring, but it isn't the whole story. Compiling only checks that the code *builds* -- it says nothing about whether the application actually *runs* correctly. We'll have more to say about `spring-data-jdbc` specifically once we start running tests again later in this course.

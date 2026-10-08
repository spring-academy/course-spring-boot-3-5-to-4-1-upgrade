Let's find out where we stand. Run the full test suite.

1. Run the tests.

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw clean test
   ```

1. Read the output carefully.

   Uh oh. This isn't a test *failure* — it's worse. The test *sources* don't even compile:

   ```shell
   [ERROR] COMPILATION ERROR :
   [ERROR] .../src/test/java/example/cashcard/CashCardApplicationTests.java:[9,48] package org.springframework.boot.test.web.client does not exist
   [ERROR] .../src/test/java/example/cashcard/CashCardApplicationTests.java:[23,5] cannot find symbol
     symbol:   class TestRestTemplate
     location: class example.cashcard.CashCardApplicationTests
   [INFO] -------------------------------------------------------------
   [INFO] BUILD FAILURE
   [INFO] -------------------------------------------------------------
   ```

   We were compiling cleanly a moment ago — but that was only ever `./mvnw clean compile`, which compiles `src/main/java`. The moment we ask Maven to also compile `src/test/java`, a class our test code has depended on for the entire lifetime of this project, `TestRestTemplate`, can no longer be found.

## What happened to `TestRestTemplate`?

Take a look at the failing import in `CashCardApplicationTests.java`:

```editor:select-matching-text
file: ~/exercises/src/test/java/example/cashcard/CashCardApplicationTests.java
text: "org.springframework.boot.test.web.client.TestRestTemplate"
```

```java
import org.springframework.boot.test.web.client.TestRestTemplate; // <=== No longer exists here!
```

In Spring Boot 3.x, `TestRestTemplate` lived in the `spring-boot-test` module, at `org.springframework.boot.test.web.client.TestRestTemplate`. In Spring Boot 4, it's been pulled out of `spring-boot-test` entirely and moved into a brand-new dedicated module: `spring-boot-resttestclient`. Its new home is `org.springframework.boot.resttestclient.TestRestTemplate`.

This is the same *modularization* story we've already seen play out for our main dependencies — Spring Boot 4 keeps breaking what used to be one big jar into smaller, more focused modules. This time it caught up with our tests instead of our main code.

Let's go fix it.

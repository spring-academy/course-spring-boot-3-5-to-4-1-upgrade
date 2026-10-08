1. Run the tests one more time.

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw clean test
   ```

   You should see a clean `BUILD SUCCESS`, with every test passing:

   ```shell
   [INFO] Results:
   [INFO]
   [INFO] Tests run: 19, Failures: 0, Errors: 0, Skipped: 0
   [INFO]
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   ```

   All 19 tests pass — the 15 in `CashCardApplicationTests` and the 4 in `CashCardJsonTest`. For the first time in this course, `./mvnw clean test` is green from top to bottom.

1. Update our notes.

   That was a two-part discovery, so let's capture the whole story in `upgrade-notes.md`, including the real error output we saw at each step, so future-us (or anyone else upgrading a similar app) knows exactly what to expect.

   ```editor:open-file
   file: ~/exercises/upgrade-notes.md
   ```

   ````markdown
   ## Test - Initial Test Execution

   - Ran `./mvnw clean test` for the first time since the version bump
   - Test *compilation* failed:
     ```
     [ERROR] .../src/test/java/example/cashcard/CashCardApplicationTests.java:[9,48] package org.springframework.boot.test.web.client does not exist
     [ERROR]   symbol:   class TestRestTemplate
     ```
     - Spring Boot 4 moved `TestRestTemplate` out of `spring-boot-test` entirely, into a new `spring-boot-resttestclient` module at `org.springframework.boot.resttestclient.TestRestTemplate`
     - Added `spring-boot-resttestclient` and `spring-boot-starter-restclient` (test scope), updated the import, and added `@AutoConfigureTestRestTemplate` to `CashCardApplicationTests` - Boot 4 no longer auto-registers a `TestRestTemplate` bean under `@SpringBootTest(RANDOM_PORT)` the way earlier versions did
   - With that fixed, tests *compiled* but 15 of them *failed at runtime*:
     ```
     Caused by: org.springframework.beans.factory.NoSuchBeanDefinitionException: No qualifying bean of type 'example.cashcard.CashCardRepository' available
     ```
     - This is the payoff of the Boot 4 auto-configuration modularization: the raw `org.springframework.data:spring-data-jdbc` artifact we've been carrying since `01-kgs` compiled cleanly the whole way through, but it never brought Spring Data JDBC's repository auto-configuration with it in Boot 4 - that now lives behind the `spring-boot-starter-data-jdbc` starter
     - Swapped `org.springframework.data:spring-data-jdbc` for `org.springframework.boot:spring-boot-starter-data-jdbc`
     - **Lesson: a clean compile tells you nothing about auto-configuration. Any raw, non-Boot-starter dependency is worth double-checking after a major Boot upgrade.**

   _Result:_ code compiles without errors or warnings and all tests pass
   ````

That's the big one. Everything from here on is comparatively minor housekeeping.

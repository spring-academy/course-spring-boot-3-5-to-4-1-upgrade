Ok, lets look at the skipped test.

1.  Find the skipped test(s).

    Search for `@Disabled` in the Editor and find the `skipped` test.

    ```editor:select-matching-text
    file: ~/exercises/src/test/java/example/cashcard/CashCardApplicationTests.java
    text: "@Disabled"
    ```

    This `skipped` test should look like this:

    ```java
    @Test
    @Disabled
    void shouldReturnACashCardWhenDataIsSaved() {
        ResponseEntity<String> response = restTemplate
                .withBasicAuth("sarah1", "abc123")
                .getForEntity("/cashcards/99", String.class);
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);

        DocumentContext documentContext = JsonPath.parse(response.getBody());
        Number id = documentContext.read("$.id");
        assertThat(id).isEqualTo(99);

        Double amount = documentContext.read("$.amount");
        assertThat(amount).isEqualTo(12.45);
    }
    ```

2.  Enable the test and rerun.

    Comment out the `@Disabled` annotation to enable the test.

    ```java
    @Test
    // @Disabled
    void shouldReturnACashCardWhenDataIsSaved() {
    ...
    }
    ```

    Rerun the test. Does it pass?

    **_Note:_** we're passing in `-Dtest` to specify the one test we want to run.

    Open the **Terminal** and run the tests:

    ```dashboard:open-dashboard
    name: Terminal
    ```

    ```shell
    [~/exercises] $ ./mvnw test -Dtest=CashCardApplicationTests#shouldReturnACashCardWhenDataIsSaved
    ```

    The output should look similar to the following:

    ```shell
    [ERROR] Tests run: 1, Failures: 1, Errors: 0, Skipped: 0, Time elapsed: 2.237 s <<< FAILURE! -- in example.cashcard.CashCardApplicationTests
    [ERROR] example.cashcard.CashCardApplicationTests.shouldReturnACashCardWhenDataIsSaved -- Time elapsed: 0.669 s <<< FAILURE!
    org.opentest4j.AssertionFailedError:

    expected: 12.45
     but was: 123.45
        at example.cashcard.CashCardApplicationTests.shouldReturnACashCardWhenDataIsSaved(CashCardApplicationTests.java:39)

    [INFO]
    [INFO] Results:
    [INFO]
    [ERROR] Failures:
    [ERROR]   CashCardApplicationTests.shouldReturnACashCardWhenDataIsSaved:39
    expected: 12.45
     but was: 123.45
    [INFO]
    [ERROR] Tests run: 1, Failures: 1, Errors: 0, Skipped: 0
    [INFO]
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD FAILURE
    [INFO] ------------------------------------------------------------------------
    ```

    We can see that an assertion failed. Let's fix it.

3.  Fix the test.

    We can see that an assertion failed.

    A bit of investigation will reveal that the correct expected value is `123.45` &mdash; it's the same amount used to seed this card's data, and it's the value the other tests in this class already expect.

    This is a simple enough change, so let's fix the expectation:

    ```java
    @Test
    // @Disabled
    void shouldReturnACashCardWhenDataIsSaved() {
        ...
        assertThat(amount).isEqualTo(123.45);
    }
    ```

4.  Now, run the test again to ensure that it passes.

    ```dashboard:open-dashboard
    name: Terminal
    ```

    ```shell
    [~/exercises] $ ./mvnw test -Dtest=CashCardApplicationTests#shouldReturnACashCardWhenDataIsSaved
    ```

    The output should look similar to the following:

    ```shell
    [INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 1.972 s -- in example.cashcard.CashCardApplicationTests
    ```

    Our test passes!

5.  Re-run all the tests.

    Let's rerun all tests to ensure everything is passing.

    ```dashboard:open-dashboard
    name: Terminal
    ```

    ```shell
    [~/exercises] $ ./mvnw clean test
    ```

    All the tests should now be passing with no `skipped tests`.

    ```shell
    [INFO] Tests run: 19, Failures: 0, Errors: 0, Skipped: 0
    [INFO]
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  8.263 s
    [INFO] Finished at: 2026-08-14T13:30:25+01:00
    [INFO] ------------------------------------------------------------------------
    ```

6. Remove the commented `@Disabled` annotation from the test source code

    ```java
    @Test
    void shouldReturnACashCardWhenDataIsSaved() {
    ...
    }
    ```

Now that everything is fixed it's time to baseline.

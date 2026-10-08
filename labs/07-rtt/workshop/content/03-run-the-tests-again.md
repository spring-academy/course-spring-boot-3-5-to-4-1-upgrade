Let's see if that was enough.

1. Run the tests again.

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw clean test
   ```

1. Read the output.

   Progress! The test *sources* compile cleanly now — no more `TestRestTemplate` errors. But look closer:

   ```shell
   ***************************
   APPLICATION FAILED TO START
   ***************************

   Description:

   Parameter 0 of constructor in example.cashcard.CashCardController required a bean of type 'example.cashcard.CashCardRepository' that could not be found.


   Action:

   Consider defining a bean of type 'example.cashcard.CashCardRepository' in your configuration.
   ```

   Scroll down further and you'll find the summary:

   ```shell
   [ERROR] Tests run: 19, Failures: 0, Errors: 15, Skipped: 0
   [INFO]
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD FAILURE
   [INFO] ------------------------------------------------------------------------
   ```

   Every single one of the 15 tests in `CashCardApplicationTests` fails. (The other 4 tests, in `CashCardJsonTest`, still pass — that test doesn't need a running application context.) They all fail for the exact same underlying reason, because they all share the same Spring application context, and that context can't even start.

This is a completely different failure from the one we just fixed, and it's the real payoff of this lab. Let's dig in.

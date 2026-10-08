As we explained in the previous lesson, the first thing we need to do is compile our code and run the tests.

1. Run the tests

   Open the **Terminal** and run the tests using Maven:

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw clean test
   ```

1. Look at your results.

   Let's evaluate the results and fix any issue in the following order:

   1. Did your code compile?
   1. Did your tests all pass?
   1. Are there any skipped tests?

   Our output should end with a **[WARNING]** like this:

   ```shell
   [WARNING] Tests run: 19, Failures: 0, Errors: 0, Skipped: 1
   ```

   So, our code compiles and 19 tests were executed, 0 failed, 0 errors, **_but 1 was skipped._**

   Let's look at the skipped test and assess if it should be deleted or fixed.

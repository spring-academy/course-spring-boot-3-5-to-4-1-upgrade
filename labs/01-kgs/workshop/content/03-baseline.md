Now that the code compiles, there are no skipped tests, and all tests pass we have a _Known Good State_. This is the ideal state to begin with for any upgrade or migration.

Let's document our baseline, so we can refer back to it and track out progress.

1. Create an upgrade notes file.

   Open the Editor and create a new file called `upgrade-notes.md` in the root of the repository.

   We're using a `.md` file because they render nicely in many editors.

2. Document the current Known Good State.

   Add a heading called `Initial baseline`

   ```markdown
   # 4.1 Upgrade Notes

   ## Initial baseline

   - Code compiled successfully
     - errors
     - Deprecation warnings
       -  src/main/java/example/cashcard/SecurityConfig.java uses or overrides a deprecated API.
   - found disabled/broken test - CashCardApplicationTests#shouldReturnACashCardWhenDataIsSaved
       - fixed broken test and re-enabled

   _Result:_ code compiles without errors or warnings and all tests pass
   ```

3. Commit all changes, including the new `upgrade-notes.md` file.

   Well, actually, we won't be committing to the repository today in this online, hands-on lab environment.

   Instead, we'll create this file on your behalf and update it after each lab in this course. You'll be able to review it as needed.

   However, we do recommend a process like the following in your own environment. We understand that you'll have to do whatever is appropriate for your SDLC, but we're confident that you get the idea, here.

   1. Create a branch called _"boot4.1-upgrade"_

      ```shell
      git switch -c "boot4.1-upgrade"
      ```

   2. Add new and modified files

      ```shell
      git add .
      ```

   3. Commit your changes to your _"upgrade"_ branch with a clear, unambiguous commit message.

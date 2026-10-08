As with a previous lab, our only **r**eaction is to document the current state of the application and the actions we've taken so far.

1. Clean up the unneeded `<version>`.

   We've proven that Spring is managing the `spring-data-jdbc` dependency.

   Let's delete the commented-out `<version>` tag.

   ```xml
   <dependency>
      <groupId>org.springframework.data</groupId>
      <artifactId>spring-data-jdbc</artifactId>
   </dependency>
   ```

1. Update our notes.

   Add a new heading `Remove hard-coded Spring/Spring Boot Dependencies` section to our `upgrade-notes.md` file:

   ```editor:open-file
   file: ~/exercises/upgrade-notes.md
   ```

   ```markdown
   ## Remove hard-coded Spring/Spring Boot Dependencies

   - remove hardcoded `spring-data-jdbc` version, letting `spring-boot-starter-parent` manage it
   - `./mvnw dependency:tree | grep spring-data-jdbc` now shows `4.1.0` (parent-managed) instead of the hardcoded `3.4.5`
   - Code Compiles, No Errors or Warnings
   ```

   With that, we're done fixing hard-coded Spring managed dependency versions -- for now.

   **_Keep this in mind:_** we've only removed the hard-coded *version* here. There's a bit more to the `spring-data-jdbc` story -- it's worth a second look once we're running tests again, later in this course.

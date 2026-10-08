Spring Boot 4 didn't just bump version numbers - it modularized the framework itself. The old, monolithic `spring-boot-autoconfigure` jar has been split into many smaller, per-technology modules, and Spring Initializr now generates dependency coordinates that match this new modular structure.

## What changed

Two of our dependencies have modern replacement names under Spring Boot 4:

- `spring-boot-starter-web` -> `spring-boot-starter-webmvc`
- `spring-boot-starter-test` -> `spring-boot-starter-webmvc-test`

The classic names still exist in Spring Boot 4 as migration aids, and they'll continue to compile just fine. This isn't a "fix a break" lesson like some of our earlier modules - it's about keeping your dependency coordinates current with what a fresh Spring Initializr project would generate today.

## Update

Update the two starter coordinates in your `pom.xml` and compile. This should be a clean, low-drama change.

Remember to make changes one at a time, compiling in-between. Follow the **SCAR** technique!

@@@alert
{
"text": "We came into this module with application source code that was compiling successfully, and it is important that we leave this module the same way!",
"type": "warning"
}
@@@

@@@alert
{
"text": "#### Something to keep in mind \n We renamed the *test* starter here, but we haven't run the tests yet in this course - we've deliberately been skipping test execution to keep our feedback loop tight. Keep this rename in the back of your mind; it'll matter very soon.",
"type": "info"
}
@@@

## Test and Release

We'll perform these steps as part of the overall upgrade process.

## Establish A New Baseline

Document the current state in writing and in source control.

1. Take note of any errors, warnings, or issues in the `upgrade-notes.md` file.
   1. Append a new heading to the document titled - "Update Spring Boot Starter Names".
   2. Document any remaining warnings, or other known issues.
2. Issue a commit.

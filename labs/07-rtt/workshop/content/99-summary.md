Congratulations! In this lab you finally ran the full test suite against the upgraded application, and it took real work to get there.

Along the way you:

- Discovered that `TestRestTemplate` moved to a brand-new `spring-boot-resttestclient` module in Spring Boot 4, and that `@AutoConfigureTestRestTemplate` is now required to get a `TestRestTemplate` bean at all.
- Uncovered the central lesson of this whole upgrade: **a clean compile tells you nothing about auto-configuration.** Our raw `spring-data-jdbc` dependency compiled cleanly through every single lab in this course, but it silently stopped bringing Spring Data JDBC's repository auto-configuration along for the ride in Spring Boot 4 — that now requires the `spring-boot-starter-data-jdbc` starter.
- Finished with a small bit of test dependency housekeeping, removing an `assertj-core` version override that Spring Boot was already managing for us.

That second discovery is worth remembering well beyond this course: whenever you upgrade across a major Spring Boot version, any dependency that *isn't* a Spring Boot starter deserves a second look — even, maybe especially, the ones that have been compiling cleanly the whole time.

With the tests fully green, we've reached a real milestone. Next, we'll use `spring-boot-properties-migrator` to check whether any of our application's configuration properties have been renamed or removed along the way.

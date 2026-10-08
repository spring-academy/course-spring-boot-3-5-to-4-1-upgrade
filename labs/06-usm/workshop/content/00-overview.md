More `pom.xml` housekeeping -- this time it's the names of our Spring Boot starters themselves.

Spring Boot 4 broke up the old monolithic `spring-boot-autoconfigure` jar into a set of smaller, per-technology modules. To match this new modular structure, Spring Initializr now generates different starter coordinates than it used to:

- `spring-boot-starter-web` is now `spring-boot-starter-webmvc`
- Each starter has a matching `-test` companion, so `spring-boot-starter-test` is now `spring-boot-starter-webmvc-test`

The good news: the classic names still exist in Spring Boot 4 as migration aids, and our application would keep compiling perfectly well without this change. This lab is about aligning with what a fresh Initializr project generates today, not fixing a break.

## Review our Upgrade Notes

Before we begin, remember that we're keeping detailed notes of the baseline state of our application as we upgrade it. Take a look at `upgrade-notes.md` to review where we are now.

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

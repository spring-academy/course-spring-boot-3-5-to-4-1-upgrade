Now is a good time to do some housekeeping in the `pom.xml`: updating Spring dependencies.

Each version of Spring Boot is very opinionated about the dependencies with which it's compatible.

In our Family Cash Card application, for some reason or another, a developer has hardcoded the `spring-data-jdbc` dependency version. This explicit version overrides the version that is managed by the Spring Boot Starter Parent. You need to remove this explicit version from the `pom.xml`.

## Review our Upgrade Notes

But, before we begin, remember that we're keeping detailed notes of the baseline state of our application as we upgrade it. Take a look at `upgrade-notes.md` to review where we are now.

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

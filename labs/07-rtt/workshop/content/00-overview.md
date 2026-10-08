We've been putting this off for a while, and for good reason: we wanted `./mvnw clean compile` to be rock solid before bringing the test suite back into the picture. Over the last several labs we upgraded the Spring Boot Starter Parent to `4.1.0`, fixed a broken import, cleaned up hard-coded dependency versions, and renamed our starters to match what Spring Initializr generates today. Through all of that, we deliberately ran `./mvnw clean compile` instead of `./mvnw clean test`.

That changes right now. In this lab we finally run `./mvnw clean test` again, for the first time since we started this upgrade. It's not going to be a single clean pass — we're going to hit **two** separate problems, one right after the other, and both of them are genuinely instructive about how Spring Boot 4 works differently from Spring Boot 3.

Once we're through both of those, we'll finish with a smaller bit of test dependency housekeeping, much like the `pom.xml` housekeeping we already did for our main dependencies.

## Review our Upgrade Notes

Before we begin, remember that we're keeping detailed notes of the baseline state of our application as we upgrade it. Take a look at `upgrade-notes.md` to review where we are now.

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

Notice that every `_Result:_` line so far ends with something like "tests not yet run." Let's finally change that.

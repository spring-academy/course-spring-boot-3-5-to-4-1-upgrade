The focus of this lab is understanding the potential increased impacts of a `major` release upgrade. In the case of the Spring Boot 3.5 to 4.1 upgrade, a great example of those impacts can be found in Spring Security.

Spring Boot 4.0 pairs with Spring Security 7.0. Spring Security 7.0 is a `major` version bump, and one of its most impactful changes is that it **removes** `AntPathRequestMatcher` and `MvcRequestMatcher` outright, in favor of `PathPatternRequestMatcher`.

Here's the good news: our current baseline, Spring Boot `3.5.16` (which pulls in Spring Security `6.5.11`), already shows us this change coming. It compiles fine today, but it flags `AntPathRequestMatcher` as deprecated. That means we can see and fix this problem *now*, before we ever attempt the jump to Spring Boot 4, rather than being surprised by a hard compile error later.

**NOTE:** At the time of this writing, the current Spring Boot 3.5.x version is `3.5.16`.

## Review our Upgrade Notes

Before we begin, remember that we're keeping detailed notes of the baseline state of our application as we upgrade it. Take a look at `upgrade-notes.md` to review where we are now.

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

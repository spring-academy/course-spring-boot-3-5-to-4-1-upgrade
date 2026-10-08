In the last lab we found a hard-coded `spring-data-jdbc` version and removed it, letting the `spring-boot-starter-parent` manage it for us. That's one flavor of `pom.xml` housekeeping. There's a second flavor worth understanding: hard-coded versions on dependencies that Spring doesn't manage at all.

### Remove Dependency Versions

Spring manages the dependency version for certain third-party libraries too -- not just Spring and Spring Boot projects themselves. If you notice an explicit version hard-coded for one of these libraries, it should be removed and left to the Spring Boot Starter Parent.

### Use Maven Properties

There are also third-party libraries that Spring has no governance over whatsoever. It's considered a _best practice_ to isolate these versions to Maven Properties rather than inline the version with the dependency.

This is a cleanliness task. It helps provide a visual reference for others as to the version of third-party libraries explicitly used in the application, all gathered in one place near the top of the `pom.xml`.

### But be Careful!

The one caveat here is around overriding Spring-managed third-party dependency versions explicitly.

You may, for instance, have become aware of a CVE affecting a Spring-managed third-party library. You may have also found that the maintainers of that library have issued a fix, but Spring has no knowledge of it yet.

In this case, it's acceptable to override the version managed by the Spring Boot Parent, but you should follow the same rule as outlined for independent third-party libraries -- namely, manage that version through a Maven Property, not an inline hard-coded version.

Let's get started and update our non-Spring dependencies!

## Review our Upgrade Notes

But, before we begin, remember that we're keeping detailed notes of the baseline state of our application as we upgrade it. Take a look at `upgrade-notes.md` to review where we are now.

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

Now that we've commented-out `lombok`'s hard-coded version in our `pom.xml`, let's continue with **SCAR**.

1. **C**ompile the code.

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw clean compile
   ...
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  1.578 s
   [INFO] Finished at: 2026-08-14T18:30:15-06:00
   [INFO] ------------------------------------------------------------------------
   ...
   ```

   Awesome! Our code still compiles...now let's assess what happened.

1. **A**ssess the version change.

   Run the `dependency:tree` goal again and note how the output changed.

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw dependency:tree | grep lombok
   ```

   You'll see output that looks like this:

   ```shell
   [INFO] +- org.projectlombok:lombok:jar:1.18.46:compile
   ```

   The version is now `1.18.46` rather than the hard-coded `1.18.30` -- the `spring-boot-starter-parent` really is managing `lombok` for us.

## A quick word about "newer"

Don't read too much into the version number here. Unlike `spring-data-jdbc` in the last lab, this jump isn't a side effect of the Spring Boot 4.1 upgrade itself.

`lombok` is managed at the exact same `1.18.46` by both our old `3.5.16` parent and our new `4.1.0` parent -- Spring Boot simply hasn't needed to move it between those two releases. Whoever hard-coded `1.18.30` in this `pom.xml` had just let it fall out of date over time, upgrade or no upgrade.

The lesson is the same either way, though: whenever the Spring Boot Parent manages a dependency, deferring to it is safer and less effort than tracking the version yourself.

Let's replace `AntPathRequestMatcher` with `PathPatternRequestMatcher`. For most matchers, this is a straightforward swap. But watch out - our `/h2-console/**` matcher has a wrinkle that makes it more interesting.

1. Fix the `/cashcards/**` matcher.

   Open `SecurityConfig.java` and replace the `/cashcards/**` matcher:

   ```editor:select-matching-text
   file: ~/exercises/src/main/java/example/cashcard/SecurityConfig.java
   text: "new AntPathRequestMatcher(\"/cashcards/**\")"
   ```

   ```java
   // Replace this:
   .requestMatchers(new AntPathRequestMatcher("/cashcards/**")).hasRole("CARD-OWNER")

   // with this:
   .requestMatchers(PathPatternRequestMatcher.withDefaults().matcher("/cashcards/**")).hasRole("CARD-OWNER")
   ```

   `PathPatternRequestMatcher.withDefaults()` gives you a builder, and `.matcher(...)` builds the actual `RequestMatcher` from your pattern - a direct, drop-in style replacement for `new AntPathRequestMatcher(...)`.

2. Fix the `/h2-console/**` matcher - and mind the wrinkle.

   You might expect the H2 console matcher to be just as simple a swap. It isn't, and here's why:

   Our application has **two servlets** mapped in the same container: Spring MVC's `DispatcherServlet`, mapped at `/`, and the H2 console's own servlet, mapped at `/h2-console/*`. `AntPathRequestMatcher` didn't care about this distinction - it just matched against the request's path, full stop.

   `PathPatternRequestMatcher`, however, matches paths *relative to a specific servlet's mapping*. Since more than one servlet is registered, it needs to be told which servlet's path the pattern belongs to. That's what `basePath(...)` is for.

   ```editor:select-matching-text
   file: ~/exercises/src/main/java/example/cashcard/SecurityConfig.java
   text: "new AntPathRequestMatcher(\"/h2-console/**\")"
   ```

   ```java
   // Replace this:
   .requestMatchers(new AntPathRequestMatcher("/h2-console/**")).permitAll())

   // with this:
   .requestMatchers(PathPatternRequestMatcher.withDefaults().basePath("/h2-console").matcher("/**")).permitAll())
   ```

   Notice the pattern itself changed too - it's now `"/**"`, not `"/h2-console/**"`. That's because `basePath("/h2-console")` already anchors the matcher to the H2 console servlet; the pattern that follows only needs to describe the path *within* that servlet's mapping.

   Without `basePath(...)`, `PathPatternRequestMatcher` can't tell whether `/h2-console/**` should be resolved against the `DispatcherServlet` or the H2 console's servlet, and it will raise an error rather than guess.

3. Update the import.

   Replace the old `AntPathRequestMatcher` import with the new one:

   ```editor:select-matching-text
   file: ~/exercises/src/main/java/example/cashcard/SecurityConfig.java
   text: "import org.springframework.security.web.util.matcher.AntPathRequestMatcher;"
   ```

   ```java
   // Delete this import
   import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

   // Add this import instead
   import org.springframework.security.web.servlet.util.matcher.PathPatternRequestMatcher;
   ```

4. **C**ompile the code.

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw clean compile
   ```

   The deprecation warning is gone:

   ```shell
   [INFO] BUILD SUCCESS
   ```

5. Run the tests and confirm you're still in a *Known Good State*.

   ```shell
   [~/exercises] $ ./mvnw clean test
   ```

   All tests should still pass, including the ones that exercise the H2 console path - proof that the `basePath(...)` wrinkle was handled correctly.

6. Update our notes.

   Add these lines to the `Major Release Considerations` section of `upgrade-notes.md`:

   ```editor:open-file
   file: ~/exercises/upgrade-notes.md
   ```

   ```markdown
   - Replace `AntPathRequestMatcher` with `PathPatternRequestMatcher.withDefaults().matcher(...)`
   - The H2 console registers its own servlet (`/h2-console/*`) alongside the app's `DispatcherServlet` (`/`). `PathPatternRequestMatcher` needs to know which servlet a pattern belongs to, so the H2 console matcher needs `PathPatternRequestMatcher.withDefaults().basePath("/h2-console").matcher("/**")` instead of a plain pattern - otherwise Spring Security can't tell which servlet's path the pattern is relative to

   _Result:_ code compiles without errors or warnings and all tests pass
   ```

Nice work! You've proactively cleared a deprecation that would otherwise have been a hard compile error on the jump to Spring Boot 4 and Spring Security 7.

Let's run through a **SCAR** pass to see - and understand - the deprecation for ourselves.

## **C**ompile the code

Compile the code and take a close look at the output.

```dashboard:open-dashboard
name: Terminal
```

```shell
[~/exercises] $ ./mvnw clean compile
```

The code _does_ still compile successfully, but you should see a **deprecation warning** for `SecurityConfig.java`:

```shell
[WARNING] .../src/main/java/example/cashcard/SecurityConfig.java: org.springframework.security.web.util.matcher.AntPathRequestMatcher in org.springframework.security.web.util.matcher has been deprecated and marked for removal
```

## **A**ssess the results

Open `SecurityConfig.java` and take a look at the `filterChain` bean. You'll find two places where `AntPathRequestMatcher` is being constructed directly:

```editor:select-matching-text
file: ~/exercises/src/main/java/example/cashcard/SecurityConfig.java
text: "AntPathRequestMatcher"
```

```java
.requestMatchers(new AntPathRequestMatcher("/cashcards/**")).hasRole("CARD-OWNER")
.requestMatchers(new AntPathRequestMatcher("/h2-console/**")).permitAll())
```

This is exactly the API the compiler warned us about. `AntPathRequestMatcher` (and its cousin `MvcRequestMatcher`) is deprecated in Spring Security 6.5, and Spring Security 7.0 - the version that ships with Spring Boot 4.0 - **removes it entirely**. If we upgraded to Spring Boot 4 without addressing this, our code simply wouldn't compile anymore.

The replacement is `PathPatternRequestMatcher`, which is built for Spring MVC's newer, more efficient `PathPattern`-based request matching.

Reference: https://docs.spring.io/spring-security/reference/6.5/migration-7/web.html#use-path-pattern

### Update our notes

Add a new section, `Major Release Considerations`, to our `upgrade-notes.md` file.

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

````markdown
## Major Release Considerations

- Spring Boot 4.0 pairs with Spring Security 7.0, which **removes** `AntPathRequestMatcher` and `MvcRequestMatcher` outright in favor of `PathPatternRequestMatcher`
- Our current Spring Boot 3.5.16 baseline (Spring Security 6.5.11) already flags this:
  ```
  [WARNING] .../src/main/java/example/cashcard/SecurityConfig.java: org.springframework.security.web.util.matcher.AntPathRequestMatcher in org.springframework.security.web.util.matcher has been deprecated and marked for removal
  ```
  - Reference: https://docs.spring.io/spring-security/reference/6.5/migration-7/web.html#use-path-pattern
- Since this is a deprecation we can already see and fix *before* the major version jump, we're doing it now rather than discovering a hard compile error later
````

## **R**eact to the error output

Now, let's go fix it.

Let's **R**eact to the compiler error using the **SCAR** method.

## Fix the imports

The fix is small: point the two imports at their new package, `org.springframework.boot.bootstrap`, instead of `org.springframework.boot`.

Open `CashCardApplication.java` and take a look at the imports:

```editor:select-matching-text
file: ~/exercises/src/main/java/example/cashcard/CashCardApplication.java
text: "org.springframework.boot.ConfigurableBootstrapContext"
before: 2
after: 2
```

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ConfigurableBootstrapContext; // <=== Update this!
import org.springframework.boot.DefaultBootstrapContext; // <=== Update this!
import org.springframework.boot.SpringApplication;
```

Update the two imports:

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.bootstrap.ConfigurableBootstrapContext; // <=== Updated!
import org.springframework.boot.bootstrap.DefaultBootstrapContext; // <=== Updated!
import org.springframework.boot.SpringApplication;
```

Nothing else in the file needs to change — `ConfigurableBootstrapContext` and `DefaultBootstrapContext` are used exactly as before, they just live in a new home.

## **C**ompile the code, again

Let's confirm the fix worked.

```dashboard:open-dashboard
name: Terminal
```

```shell
[~/exercises] $ ./mvnw clean compile
```

You should see a clean `BUILD SUCCESS`, with no compilation errors:

```shell
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

Remember, we're intentionally *not* running the tests yet — that's coming in a later lab. For now, we only need `./mvnw clean compile` to pass.

## Update our notes

Let's capture what we just did in `upgrade-notes.md`, including the real compiler error we saw, so future-us (or anyone else upgrading a similar app) knows exactly what to expect.

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

```markdown
## Upgrade Spring Boot Parent Version

- Updated `spring-boot-starter-parent` from `3.5.16` to `4.1.0`
- Code did **not** compile cleanly:
  ```
  [ERROR] .../src/main/java/example/cashcard/CashCardApplication.java:[5,32] cannot find symbol
    symbol:   class ConfigurableBootstrapContext
    location: package org.springframework.boot
  [ERROR] .../src/main/java/example/cashcard/CashCardApplication.java:[6,32] cannot find symbol
    symbol:   class DefaultBootstrapContext
    location: package org.springframework.boot
  ```
- Spring Boot 4 moved `ConfigurableBootstrapContext` and `DefaultBootstrapContext` from `org.springframework.boot` to `org.springframework.boot.bootstrap` as part of its broader package modularization
- Updated the two imports to the new package; no other code changes were needed
- We are intentionally skipping test execution for now (`./mvnw clean compile` only) - testing gets its own dedicated set of lessons and labs later in this course

_Result:_ code compiles without errors or warnings (tests not yet run)
```

That's it for now!

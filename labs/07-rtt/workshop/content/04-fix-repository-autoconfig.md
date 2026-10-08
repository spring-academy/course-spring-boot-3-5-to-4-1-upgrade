Remember the note we left ourselves a few labs back, when we removed the hard-coded version from our `spring-data-jdbc` dependency? We wrote: *"There's a bit more to the `spring-data-jdbc` story — it's worth a second look once we're running tests again."* This is that second look.

## Dig into the real cause

The friendly `APPLICATION FAILED TO START` message tells us `CashCardRepository` can't be found, but if you look further up in the console output, you'll find the actual root cause buried in the stack trace:

```shell
Caused by: org.springframework.beans.factory.NoSuchBeanDefinitionException: No qualifying bean of type 'example.cashcard.CashCardRepository' available
```

`CashCardRepository` is our own interface — we never wrote an implementation for it. We've always relied on Spring Data JDBC to generate one for us automatically, and it's done exactly that since the very first lab in this course. So why would that suddenly stop working now?

## The dependency that never really left

Open `pom.xml` and look at the dependency we're using for Spring Data JDBC support:

```editor:select-matching-text
file: ~/exercises/pom.xml
text: "spring-data-jdbc"
before: 2
after: 1
```

```xml
<dependency>
    <groupId>org.springframework.data</groupId>
    <artifactId>spring-data-jdbc</artifactId>
</dependency>
```

This is the raw `spring-data-jdbc` artifact — not a Spring Boot *starter*. We've been carrying it since the very first lab of this course (`01-kgs`), and it has compiled cleanly through every single change we've made since, including all of the dependency cleanup we did earlier in this course. A clean compile the whole way through gave us no reason to suspect anything was wrong with it.

Here's the catch: compiling only proves the *types* are on the classpath. It says nothing about *auto-configuration* — the machinery Spring Boot uses to automatically wire up beans like our repository implementation. In Spring Boot 3.x, the raw `spring-data-jdbc` artifact happened to bring that auto-configuration along for the ride. In Spring Boot 4, auto-configuration has been further modularized, and Spring Data JDBC's repository auto-configuration now lives specifically behind the `spring-boot-starter-data-jdbc` starter — not behind the raw `spring-data-jdbc` artifact we've been using all along.

Without that starter, `spring-data-jdbc` gives us the annotations and interfaces to *declare* a repository, but nothing ever actually implements `CashCardRepository` at runtime. Our test suite is the first thing in this whole upgrade to actually start the application context and notice.

### Learning Moment: A Clean Compile Tells You Nothing About Auto-Configuration

This is worth calling out explicitly, because it's easy to miss: **a clean compile only tells you that your code's types resolve. It tells you nothing about whether Spring Boot's auto-configuration is actually wiring up the beans your application needs at runtime.** Any raw, non-Boot-starter dependency — like our `org.springframework.data:spring-data-jdbc` — is worth a second look after any major Spring Boot upgrade, precisely because it can compile cleanly while quietly losing the auto-configuration it used to bring along.

## Make the fix

Swap the raw artifact for the Spring Boot starter:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jdbc</artifactId>
</dependency>
```

Let's find out if that was the missing piece.

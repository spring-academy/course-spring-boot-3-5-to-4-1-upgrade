We've made our **S**mall Change. Now let's **C**ompile and **A**ssess!

## **C**ompile the code

Now **C**ompile the code. As we discussed in the lesson, we're going to skip running the tests for now — testing gets its own dedicated set of lessons and labs later in this course. For this lab we only care whether the *main* sources compile.

Open the **Terminal** and compile, skipping the tests:

```dashboard:open-dashboard
name: Terminal
```

```shell
[~/exercises] $ ./mvnw clean compile
```

So, what happened?

## **A**ssess the results

Now we can answer the same question we've been asking all along:

> Did our code compile?

**_NO!_**

Even though we did our Spring Security prep work in the last lab, this small one-line version bump breaks the build. Here's the compiler output you should see:

```shell
[INFO] -------------------------------------------------------------
[ERROR] COMPILATION ERROR :
[INFO] -------------------------------------------------------------
[ERROR] .../src/main/java/example/cashcard/CashCardApplication.java:[5,32] cannot find symbol
  symbol:   class ConfigurableBootstrapContext
  location: package org.springframework.boot
[ERROR] .../src/main/java/example/cashcard/CashCardApplication.java:[6,32] cannot find symbol
  symbol:   class DefaultBootstrapContext
  location: package org.springframework.boot
[INFO] 2 errors
[INFO] -------------------------------------------------------------
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
```

This is a genuinely new error, and it has nothing to do with Spring Security — that work is already done and paid off. Instead, `ConfigurableBootstrapContext` and `DefaultBootstrapContext` have moved from the `org.springframework.boot` package to `org.springframework.boot.bootstrap`, as part of Spring Boot 4's broader package modularization. Our small demo `ApplicationListener` in `CashCardApplication.java` imports both classes from their old location, so the compiler can no longer find them there.

This is exactly the situation the **SCAR** method exists for: you make a small, deliberate change, you compile immediately, and when something breaks you find out *right away*, with a small, isolated diff to explain it — instead of discovering it buried under a pile of unrelated changes. Let's go **R**eact to it.

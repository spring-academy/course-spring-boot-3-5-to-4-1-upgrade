In this lab you'll finally get your hands dirty and start upgrading our sample application.

But what is the application we'll upgrade?

## The Family Cash Card application

It helps to have a real-world style project work on. Throughout this course you'll be upgrading a fictional _Family Cash Card_ application. The application is a REST API built with Spring Boot that lets customers manage "cash cards", which are like debit cards that customers can use to make purchases.

![Family Cash Card application](https://raw.githubusercontent.com/spring-academy/spring-academy-assets/main/courses/course-spring-brasb-build-a-rest-api/NEWcardUI.png "Family Cash Card application")

Take a moment to get familiar with the codebase and application. Click the "click action" below to open the Editor and poke around a bit.

```dashboard:open-dashboard
name: Editor
```

In the `src/main/java/example/cashcard` directory you'll find classes typical for a Spring Boot REST API: a Controller, Repository, Application, domain object, and a security configuration.

```editor:open-file
file: ~/exercises/src/main/java/example/cashcard/CashCardApplication.java
```

You'll also find tests in `src/test/java/example/cashcard`

```editor:open-file
file: ~/exercises/src/test/java/example/cashcard/CashCardApplicationTests.java
```

The application currently runs on Spring Boot 3.5, and by the end of this course you'll have upgraded it to Spring Boot 4.1. We won't be changing the Java version along the way &mdash; we're on Java 17 now, and we'll stay on Java 17 throughout.

When you're ready, let's start upgrading!

All tests pass — that's the milestone we were after. Before we close out this lab, let's do one more small round of `pom.xml` housekeeping, this time for a *test* dependency.

## Find the hard-coded test dependency

Open `pom.xml` and find the `assertj-core` dependency:

```editor:select-matching-text
file: ~/exercises/pom.xml
text: "assertj-core"
before: 2
after: 3
```

```xml
<dependency>
    <groupId>org.assertj</groupId>
    <artifactId>assertj-core</artifactId>
    <version>3.26.0</version>
    <scope>test</scope>
</dependency>
```

Just like `lombok` and `itextpdf` earlier in this course, someone explicitly pinned a version here. Let's check what version is actually in effect with the Maven Dependency Tree plugin:

```dashboard:open-dashboard
name: Terminal
```

```shell
[~/exercises] $ ./mvnw dependency:tree | grep assertj-core
```

You should see:

```shell
[INFO] +- org.assertj:assertj-core:jar:3.26.0:test
```

We already know from earlier labs that `spring-boot-starter-test` (which our `spring-boot-starter-webmvc-test` starter pulls in transitively) manages a version of `assertj-core` on its own. Let's find out whether we even need this explicit dependency at all.

## Make a **S**mall Change

Delete the entire `assertj-core` dependency — not just its version, the whole block:

```editor:select-matching-text
file: ~/exercises/pom.xml
text: "assertj-core"
before: 2
after: 3
```

```xml
<!-- DELETE this entire dependency! -->
<!-- <dependency> -->
    <!-- <groupId>org.assertj</groupId> -->
    <!-- <artifactId>assertj-core</artifactId> -->
    <!-- <version>3.26.0</version> -->
    <!-- <scope>test</scope> -->
<!-- </dependency> -->
```

Let's compile and assess.

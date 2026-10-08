Let's use **SCAR** one more time -- although this is such a small, self-contained change that we can move through all four steps quickly.

## Make a **S**mall Change

1. Locate the `spring-boot-starter-web` dependency.

   Open `pom.xml` and find the Spring Boot dependencies section.

   ```editor:select-matching-text
   file: ~/exercises/pom.xml
   text: "spring-boot-starter-web"
   before: 2
   after: 1
   ```

   ```xml
   <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
   </dependency>
   ```

2. Rename it to `spring-boot-starter-webmvc`.

   ```xml
   <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-webmvc</artifactId>
   </dependency>
   ```

3. Do the same for `spring-boot-starter-test`.

   ```editor:select-matching-text
   file: ~/exercises/pom.xml
   text: "spring-boot-starter-test"
   before: 2
   after: 2
   ```

   ```xml
   <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-test</artifactId>
      <scope>test</scope>
   </dependency>
   ```

   Rename it to `spring-boot-starter-webmvc-test`:

   ```xml
   <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-webmvc-test</artifactId>
      <scope>test</scope>
   </dependency>
   ```

That's both starters renamed. Time to **C**ompile and **A**ssess.

## **C**ompile the code

```dashboard:open-dashboard
name: Terminal
```

```shell
[~/exercises] $ ./mvnw clean compile
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
...
```

Still compiles, exactly as expected -- the old names were never going away, so this was never going to break anything.

## **A**ssess the change

There's not much to assess here. We didn't change a version, a scope, or a transitive dependency -- we only changed which artifact ID resolves to the exact same set of classes. The `dependency:tree` output shows the same modules being pulled in either way; only the top-level artifact name in your `pom.xml` is different.

Since we're only compiling for now (no test execution yet), there's nothing else to observe at this stage. Keep the renamed `spring-boot-starter-webmvc-test` starter in mind, though -- it'll be relevant again once we start running our tests.

## **R**eact

Let's document what we did.

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

```markdown
## Update Spring Boot Starter Names

- Spring Boot 4 modularized the old monolithic `spring-boot-autoconfigure` jar into per-technology modules, and Spring Initializr now generates dependency coordinates that match: `spring-boot-starter-web` -> `spring-boot-starter-webmvc`, `spring-boot-starter-test` -> `spring-boot-starter-webmvc-test`
- The classic names (`spring-boot-starter-web`, `spring-boot-starter-test`) still exist in Boot 4 as migration aids and would keep compiling, but we're updating to match what a fresh Spring Initializr project would generate today
- Code Compiles, No Errors or Warnings
```

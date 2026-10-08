Now that the Spring related dependencies are under control, it's time to look at all of our other non-test-related project dependencies.

Our focus will be on three specific things:

- Discovering dependencies that have explicit versioning that can, and should, be managed by Spring Dependency management, to ensure compatibility.
- Finding overlapping dependencies, and deciding what should manage the dependency. Should it be managed by the Project POM or another dependency?
- Looking for dependencies that aren't following the best practice of using `properties` for version specification.

## Using SCAR to update non-Spring dependencies

The following steps should be performed iteratively for the dependencies, using the **SCAR** method:

1. Find any dependency with an explicitly set version.

   For example, note this `lombok` dependency:

   ```xml
   <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <!-- Here is an explicitly set version! -->
      <version>1.18.30</version>
   </dependency>
   ```

2. Determine if this dependency version is managed by Spring, or another dependency.

   1. **S**mall Change - Comment out the explicit versioning in our POM.

      ```xml
      <dependency>
         <groupId>org.projectlombok</groupId>
         <artifactId>lombok</artifactId>
         <!-- Comment out the explicitly set version -->
         <!-- <version>1.18.30</version> -- >
      </dependency>
      ```

   2. **C**ompile - Attempt to compile.

      ```shell
      $ ./mvnw clean compile
      ```

   3. **A**ssess - Does maven complain about a missing version for the dependency?

      1. **R**eact - If **YES**, create a property for the version and add it to the properties section of your POM if it's not already present there.

         Then, reference this property in the dependency.

         ```xml
         <properties>
            <!-- ... existing properties ... -->
            <lombok.version>1.18.30</lombok.version>
         </properties>
         ```

         ```xml
         <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <!-- reference the property defined above -->
            <version>${lombok.version}</version>
         </dependency>
         ```

         Move on to the next dependency with explicit versioning.

      2. **R**eact - If **NO**, the version is being managed by something else.

## Viewing the dependency tree

We've talked quite a bit about how dependency versions should usually be managed by Parent POM(s) or transitive dependencies.

However, what if we want - or need - to know specifically what's managing the dependency? This is where viewing the **dependency tree** is very helpful.

**Note:** We'll use Maven as an example. If you're using Gradle, the command is `./gradlew app:dependencies`.

Maven provides a `dependency:tree` command that allows you to see what version is being loaded for your Maven project. See [Dependency Tree Documentation](https://maven.apache.org/plugins/maven-dependency-plugin/tree-mojo.html) for details on the `mojo`.

```shell
$ ./mvnw dependency:tree
```

The output should look something like the following. For example, let's look for `lombok`:

```shell

[INFO] Scanning for projects...
[INFO]
[INFO] ---------------------< example:family-cash-cards >----------------------
[INFO] Building Family Cash Cards 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- dependency:3.8.1:tree (default-cli) @ family-cash-cards ---
[INFO] example:family-cash-cards:jar:0.0.1-SNAPSHOT
[INFO] +- org.springframework.boot:spring-boot-starter-web:jar:4.1.0:compile
[INFO] |  +- org.springframework.boot:spring-boot-starter:jar:4.1.0:compile
[INFO] |  |  +- org.springframework.boot:spring-boot:jar:4.1.0:compile
[INFO] |  |  +- org.springframework.boot:spring-boot-autoconfigure:jar:4.1.0:compile
[INFO] |  |  +- org.springframework.boot:spring-boot-starter-logging:jar:4.1.0:compile

.... omitted for brevity

[INFO] |  +- org.springframework:spring-core:jar:7.0.8:compile
[INFO] |  |  \- org.jspecify:jspecify:jar:1.0.0:compile
[INFO] |  \- org.slf4j:slf4j-api:jar:2.0.18:compile
[INFO] +- org.projectlombok:lombok:jar:1.18.46:compile <== Here is where lombok is managed!
[INFO] +- com.h2database:h2:jar:2.4.240:runtime
[INFO] \- org.springframework.boot:spring-boot-starter-test:jar:4.1.0:test
[INFO]    +- org.springframework.boot:spring-boot-test:jar:4.1.0:test

.... omitted for brevity

[INFO]    +- org.springframework:spring-test:jar:7.0.8:test
[INFO]    \- org.xmlunit:xmlunit-core:jar:2.11.0:test
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.129 s
[INFO] Finished at: 2026-08-14T11:15:25-06:00
[INFO] ------------------------------------------------------------------------
```

Find the dependency in question, and see what version is being loaded. Are there any concerns? Is there a version conflict?

If you determine the dependency is being loaded transitively by another dependency, and assess that it's the correct version, you should consider removing the dependency from your project altogether, letting the other one completely manage it. If not, you may need to add an exclusion inside the dependency that is loading it transitively.

You can see above, that `org.projectlombok:lombok:jar:1.18.46` is managed by `org.springframework.boot:spring-boot-starter-web:jar:4.1.0` – the root of its dependency tree.

## Using the effective POM

Sometimes the dependency tree technique isn't enough to track down how a tricky dependency is managed. This is when inspecting the effective POM can help.

The effective POM is the composite of your POM and any POMs in the parent hierarchy. The first step that Maven takes before loading dependencies, is to create an `effective POM` for your project.

If you'd like to see what your effective POM is, run the following command:

```shell
$ ./mvnw help:effective-pom
```

If you can't determine what's controlling the version, there are a few different approaches you can take to determine what's controlling it. The easiest is to use an IDE, like IntelliJ, which allows you to navigate through the effective POM to see where the version came from.

![Viewing the Effective POM in IntelliJ](https://raw.githubusercontent.com/spring-academy/spring-academy-assets/main/courses/course-spring-boot-3-5-to-4-1-upgrade/effective-pom-intellij.png "Viewing the Effective POM in IntelliJ")

Or, you could manually hunt around your POM hierarchy looking for the dependency in a `dependency management` section. Alternatively, it might be included explicitly as a parent dependency.

@@@alert
{
"text": "#### Key Takeaway \n
"The recommended practice for dependency versions is to allow versions to be controlled by the highest POM in the hierarchy possible, or, transitively via the most precedent (highest physically) dependency in your project POM. As a reminder, if a version must be explicitly specified, a property should be used instead of hard-coding the version within the dependency.",
"type": "info"
}
@@@

If you've resolved what or how the dependency version should be managed, then iteratively apply this same technique to the remaining dependencies with explicit versioning. Once all dependencies have been assessed, establish a new baseline.

## Establish A New Baseline

Document the current state in writing and in source control.

1. Take note of any errors, warnings, or issues in the `upgrade-notes.md` file.
   1. Append a new heading to the document titled - "Update Non Spring Dependencies".
   2. Document any errors, warnings, or other issues.
2. Issue a commit.

At this point, our application is updated and compiling with the new version of Spring Boot. Now, it's time to run our tests. This is a first step towards proving the application is still working as it was before the upgrade. However, just like the core application dependencies, our test dependencies may have been impacted by the upgrade.

## Run the tests and assess

So, what's the state of our tests? Are they passing with flying colors, or failing left and right?

Let's find out! Run the tests and establish a new baseline.

1. Run the tests.

   ```shell
   $ ./mvnw clean test
   ```

2. Assess - What happened?

   - Did the test compile succeed?
   - Did the tests run?
   - Did they all pass?

3. Establish a new baseline.
   **Don't change any code yet!** Start by documenting the current state in writing, and in source control.

   - Take note of any errors, warnings, or issues in the `upgrade-notes.md` file..
     1. Append a new heading to the document titled "Test - Initial Test Execution".
     2. Document any errors, warnings, or other issues.
   - Issue a commit.

If your tests compile and all run successfully, you could move on to the next lesson. However, we recommend that you go through the same dependency update process for your test dependencies that you did with your non Spring dependencies. Revisit the _Update Non Spring Dependencies_ lesson, as needed.

If your tests don't compile, you'll be required to go through that process. So, let's just go ahead and do it!

## Update the test dependencies

You might be asking, "what's a test dependency?"

For our purposes, it'll be any dependency that has a `test` scope: `<scope>test</scope>`

For example:

```xml
<dependency>
   <groupId>org.springframework.boot</groupId>
   <!-- Here is a test-scoped dependency -->
   <artifactId>spring-boot-starter-webmvc-test</artifactId>
   <scope>test</scope> <!-- <=== there it is! -->
</dependency>
```

You can see in the example above, `spring-boot-starter-webmvc-test` is scoped to `test`. You're looking for these dependencies.

So, let's go through our POM and look at our test dependencies.

Our focus will be on three specific things:

- Discovering dependencies that have explicit versioning that can/should be managed by Spring Dependency management, to ensure compatibility.
- Finding overlapping dependencies and deciding what should manage the dependency. Should these be managed by the Project POM or another dependency?
- Looking for dependencies that aren't following the best practice of using `properties` for version specification.

### Steps for assessing `test` scoped dependencies

The following steps should be performed iteratively for the dependencies following the **SCAR** method.

1. Find any dependency with an explicitly set version.

   Example:

   ```xml
   <dependency>
       <groupId>org.assertj</groupId>
       <artifactId>assertj-core</artifactId>
       <!-- Here is a hard-coded test-scoped dependency -->
       <version>3.26.0</version> <!-- <=== there it is! -->
       <scope>test</scope>
   </dependency>
   ```

2. Determine if this dependency is managed (version controlled) somewhere else.

   1. **S**mall Change- Comment out the explicit versioning in our POM

      ```xml
      <dependency>
          <groupId>org.assertj</groupId>
          <artifactId>assertj-core</artifactId>
          <!-- Comment out the explicitly set version -->
          <!-- <version>3.26.0</version> -->
          <scope>test</scope> <!-- <=== keep this -->
      </dependency>
      ```

   2. **C**ompile - Attempt to compile (Run the tests).

      ```shell
      $ ./mvnw clean test
      ```

   3. **A**ssess - Does maven complain about a missing version for the dependency?

      1. **R**eact:

         If **YES**, create a property for the version, and add it to the properties section of your POM if it's not already present there.

         Then, reference this property in the dependency. Move on to the next dependency, with explicit versioning.

         ```xml
         <properties>
         <!-- ... existing properties ... -->
            <assertj.version>3.26.0</assertj.version>
         </properties>
         ```

         ```xml
         <dependency>
             <groupId>org.assertj</groupId>
             <artifactId>assertj-core</artifactId>
             <!-- reference the property defined above -->
             <version>${assertj.version}</version>
             <scope>test</scope>
         </dependency>
         ```

         If **NO**, the version is being managed by something else.

         To see what version is being loaded, Run Dependency Tree. See [Dependency Tree Documentation](https://maven.apache.org/plugins/maven-dependency-plugin/tree-mojo.html) for details on the `mojo`.

## Viewing the dependency tree

We've talked quite a bit about how dependency versions should usually be managed by Parent POM(s) or transitive dependencies.

But what if we want - or _need_ - to know specifically what's managing the dependency? This is where viewing the **dependency tree** is very helpful.

**Note:** we'll use Maven as an example. If you're using Gradle, the command is `./gradlew app:dependencies`.

Maven provides a `dependency:tree` command that allows you to see what version is being loaded for your maven project. See [Dependency Tree Documentation](https://maven.apache.org/plugins/maven-dependency-plugin/tree-mojo.html) for details on the `mojo`.

```shell
$ ./mvnw dependency:tree
```

The output should look something like this:

```shell
[INFO] Scanning for projects...
[INFO]
[INFO] ---------------------< example:family-cash-cards >----------------------
[INFO] Building Family Cash Cards 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- dependency:3.8.1:tree (default-cli) @ family-cash-cards ---
[INFO] example:family-cash-cards:jar:0.0.1-SNAPSHOT
[INFO] +- org.springframework.boot:spring-boot-starter-webmvc:jar:4.1.0:compile
[INFO] |  +- org.springframework.boot:spring-boot-starter:jar:4.1.0:compile
[INFO] |  |  +- org.springframework.boot:spring-boot:jar:4.1.0:compile
[INFO] |  |  +- org.springframework.boot:spring-boot-autoconfigure:jar:4.1.0:compile
[INFO] |  |  +- org.springframework.boot:spring-boot-starter-logging:jar:4.1.0:compile


.... omitted for brevity

[INFO] +- org.projectlombok:lombok:jar:1.18.46:compile
[INFO] +- com.h2database:h2:jar:2.4.240:runtime
[INFO] +- com.itextpdf:itextpdf:jar:5.5.13.3:compile
[INFO] +- org.springframework.boot:spring-boot-starter-webmvc-test:jar:4.1.0:test
[INFO] |  +- org.springframework.boot:spring-boot-test:jar:4.1.0:test


.... omitted for brevity

[INFO] |  +- org.springframework:spring-test:jar:7.0.8:test
[INFO] |  \- org.xmlunit:xmlunit-core:jar:2.11.0:test
[INFO] \- org.assertj:assertj-core:jar:3.27.7:test <== Here is where assertj-core is managed!
[INFO]    \- net.bytebuddy:byte-buddy:jar:1.18.10:test
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.129 s
[INFO] Finished at: 2026-08-14T11:15:25-06:00
[INFO] ------------------------------------------------------------------------
```

Find the dependency in question. See what version is being loaded. Are there any concerns? Is there a version conflict?

If you determine the dependency is being loaded transitively by another dependency, and assess that it's the correct version, you should consider removing the dependency from your project altogether, letting the other one completely manage it. If not, you may need to add an exclusion inside the dependency that's loading it transitively.

Above you can see that `org.assertj:assertj-core:jar:3.27.7:test` is managed by `org.springframework.boot:spring-boot-starter-webmvc-test:jar:4.1.0:test`, which is _higher_ in the dependency tree.

This example tells us that perhaps `org.springframework.boot:spring-boot-starter-webmvc-test:jar:4.1.0:test` should handle the dependency!

## Iterate

If you've resolved what/how the dependency version should be managed, then you should iteratively apply this same technique to the remaining test dependencies with explicit versioning.

Once all dependencies have been assessed, establish a new baseline.

## Establish A New Baseline

Document the current state in writing and in source control.

1. Take note of any errors, warnings, or issues in the `upgrade-notes.md` file.
   1. Append a new heading to the document titled - "Update Test Dependencies".
   2. Document any errors, warnings, or other issues.
2. Issue a commit.

## Run the tests, again!

Keep iterating!

1. Run the tests

   ```shell
   $ ./mvnw test
   ```

2. Did your tests pass? If not, we'll need to iteratively fix them using the SCAR method.
3. Pick a test to fix.
4. Make a **S**mall change - attempt to fix it.
5. **C**ompile - Run the tests
6. **A**ssess - Is the test passing now? If yes, proceed to fix the next test.
7. **R**eact - Make another small change to fix the test
8. Repeat as necessary until all tests are passing.

If you've got a lot of failing tests, or if your test suite takes more than a minute to execute, we recommend executing a single test at a time, to keep your feedback loop small and fast.

To execute a single test class

```shell
$ ./mvnw test -Dtest="TheTestClassName"
```

To execute a single test method

```shell
$ ./mvnw test -Dtest=""TheTestClassName#TheTestMethodName"
```

## Establish A New Baseline, again!

Document the current state in writing and in source control.

1. Take note of any errors, warnings, or issues in the `upgrade-notes.md` file.
   1. Append a new heading to the document titled - "All Tests Pass".
2. Issue a commit.

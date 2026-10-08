Now that the application is compiling and all tests are passing, we're ready to begin run-time testing of the application.

The first step on the path to running the application is to verify that we've remediated any deprecated properties. To facilitate that, the Spring team created a utility called the Spring Boot Properties Migrator.

In this lesson we'll learn how to use this utility to help us find and remediate deprecated properties. We'll need to perform the following steps:

1. Add the Spring Boot Properties Migrator to our POM.
2. Run the application.
3. Fix any identified errors.
4. Once completed, we'll remove it from our POM, as it's not intended to be a permanent addition.

@@@alert
{
"text": "#### Note \n
During \"Assess\" we modified the logging subsystem to use `INFO` logging. During this phase, you may need to adjust your logging to `DEBUG` in order to get the necessary information to make informed reactions.",
"type": "info"
}
@@@

## Using the Spring Boot Properties Migrator

Let's add the utility to our POM file, and run the application.

1. Add Spring Boot Properties Migrator to the POM.

   Open the POM and add the following to the `<dependencies>` section at the top of the file:

   ```xml
   <dependencies>
   ...
      <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-properties-migrator</artifactId>
         <scope>runtime</scope>
      </dependency>
   ...
   </dependencies>
   ```

2. Run the application.

   ```shell
   $ ./mvnw spring-boot:run [required parameters]
   ```

   The `[required parameters]` in the above command would be any parameters or properties required by your application for it to successfully bootstrap and run.

3. **Assess** the results by reviewing the console log and/or any log files produced by the application.

   1. Did the application successfully bootstrap and run?

      1. If **YES**, move to step 4.
      2. If **NO**, what happened?

         The output from the utility will guide you in the right direction.

         You might also see "Class Signature" errors. Fix and repeat.

         Please take a look at our more detailed instructions in the **Spring Boot Property Migrator output** section below regarding both of these errors.

4. Comment out the entire `spring-boot-properties-migrator` dependency in the Project POM.

@@@alert
{
"text": "Notice that we state to _comment out_ the Spring Boot Properties Migrator. A utility like this will have use when the application is upgraded over time. It's recommended to leave this entry in the POM, however, it should be commented out and should **NOT** be run in Production.\n\nUltimately, you need to follow the accepted practices established by your team and operating environment. So, if commented code is frowned upon, just remove the dependency completely.",
"type": "info"
}
@@@

### Spring Boot Property Migrator output

Errors produced by the Properties Migrator will look something like this:

```shell
The use of configuration keys that have been renamed was found in the environment:

Property source 'Config resource 'class path resource [application.yml]' via location 'optional:classpath:/'':
        Key: spring.artemis.host
                Line: 11
                Replacement: spring.artemis.broker-url

Each configuration key has been temporarily mapped to its replacement for your convenience. To silence this warning, please update your configuration to use the new keys.
```

In the example output above, the Properties Migrator has highlighted that we're using a deprecated property named `spring.artemis.host`. Further, it's identified the file and line number where this property can be found, as well as the appropriate property to be used:

- File: `application.yml`
- Line number: `Line: 11`
- Old property: `Key: spring.artemis.host`
- New property: `Replacement: spring.artemis.broker-url`

Using the **SCAR** method, we'd fix this property in the `application.yml` and attempt running the application again. Then we'd once again "Assess" the results and "React" by migrating the next identified property. Repeat this process until all Property Migrator errors and warnings have been resolved.

If you received other runtime errors or warnings, you should deal with those the same way you dealt with them during the Update/Compile process. At this point, errors are likely related to configuration and or "Class Signature".

## Class Format Errors

Class Format Errors occur when an object (instantiated class) attempts to instantiate an object for a class, and it's expecting a class compiled by one version of a JDK, and finds instead one that was compiled by another. This is often the result of a library dependency that we need to _downgrade_ from a newer version.

Yes, _downgrade..._

These types of errors can occur when a class's API has not changed, therefore we get no indication during the _compile_ process that there is a problem. We only see the indication at _runtime_ when attempting to actually instantiate an instance of the class.

### Class Format Error Example

Here is a possible situation: your application is using a library whose developers are really on the ball and they have published a version of their library for version(s) of the JVM greater than the one you are using. For example, your application is using Java **_17_** and the library developers have published a version they compiled using Java **_21_**.

Furthermore, that newer version is referenced by _another_ library and is pulled in transitively and used by your application.

But, you are not aware of all of these updates and transitive dependency impacts, and now your application is crashing during this Spring Boot upgrade process.

What to do?

Once again, the Maven Dependency Tree plugin to the rescue! You will have to hunt down the offending library using this tool. Please review the previous dependency-themed lessons and labs where we explain in detail how to use this tool.

### Resolving Class Format Errors

These errors will be dealt with by finding the correct version of the library and specifying it in our POM.

You could do this by specifying a specific version. This might be a case where you need to _downgrade_ a library to work with your application.

In the case of transitive dependency conflict, you might create an "exclusion", then making the required library a direct dependency of our project. For more details on this process see [Maven Dependencies](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html) and [Dependency Exclusions](https://maven.apache.org/guides/introduction/introduction-to-optional-and-excludes-dependencies.html#dependency-exclusions).

At this point you should've dealt with all property deprecations and runtime errors. Your application should be successfully bootstrapping and running.

@@@alert
{
"text": "Class Format Errors typically only surface when you aren't on the latest GA version of Java. We've highlighted them here because some dependent libraries your project uses could've updated their code and compiled against a new Java version, while your application is compiled against an older version of Java.",
"type": "warning"
}
@@@

## Establish A New Baseline

Document the current state in writing and in source control.

1. Take note of any errors, warnings, or issues in the `upgrade-notes.md` file.
   1. Append a new heading to the document titled - "Deprecated Properties".
   2. Document any remaining warnings or other known issues.
2. Issue a commit.

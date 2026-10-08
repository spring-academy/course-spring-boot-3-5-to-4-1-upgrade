In this lesson, we'll look for - and address - places where dependency versions are set explicitly.

As a best practice, it's important to keep your Spring and Spring Boot dependencies in sync. The Spring Boot Parent and Spring Boot Dependencies BOM are designed to ensure that all the Spring and Spring Boot libraries will interoperate compatibly.

## Look for Spring and Spring Boot dependencies

So, let's go through our POM and make sure that NO versions are explicitly set. If they are, let's remove them and allow the version to be controlled by the Starter or Dependencies BOM.

Here's an example of an explicitly set version:

```xml
<dependency>
   <groupId>org.springframework.data</groupId>
   <artifactId>spring-data-jdbc</artifactId>
   <!-- Here is an explicitly set version! -->
   <version>3.4.5</version>
</dependency>
```

In the `spring-data-jdbc` dependency above, the version is explicitly set to `3.4.5`.

We'll comment that out, so that the version is compatible with the new version of Spring Boot being used:

```xml
<dependency>
   <groupId>org.springframework.data</groupId>
   <artifactId>spring-data-jdbc</artifactId>
   <!-- Comment out the explicitly set version -->
   <!-- <version>3.4.5</version> -->
</dependency>
```

It's also important to look in your Dependencies Management section (both project and parent) for the same type of thing.

Remember: **SCAR**

1. Update one dependency (**S**mall change)
1. **C**ompile
1. **A**ssess
1. **R**eact

Repeat!

**Note:** When the upgrade is complete and everything is working, remove these commented versions.

```xml
<dependency>
   <groupId>org.springframework.data</groupId>
   <artifactId>spring-data-jdbc</artifactId>
</dependency>
```

Once you've completed cleaning up all the Spring dependencies (using the SCAR method), it's time to establish a new baseline.

## Establish A New Baseline

Document the current state in writing and in source control.

1. Take note of any errors, warnings, or issues in the `upgrade-notes.md` file.
   1. Append a new heading to the document titled - "Update Spring Dependencies".
   2. Document any errors, warnings, or other issues.
2. Issue a commit.

The first step in upgrading any application to a newer version of Spring Boot is to change the base Spring Boot dependency. To do that, we'll want to determine the latest version.

## Determine latest 4.1 version

Go to [Spring Releases](https://github.com/spring-projects/spring-boot/releases) and find the latest `4.1.X` version. There's a search feature that can make this easier at the top of the page. Enter `v4.` and it should pop up the latest 4.X. release. For the purposes of this course we'll use `4.1.0`.

## Spring Boot Starter parent

The Spring Boot Starter Parent is the entry point or base upon which most Spring Boot applications are built. It manages the versions of all Spring Boot & Spring Framework dependencies. It also manages a number of transitive dependencies related to these components, such as database driver versions, messaging middleware driver versions, and utilities like Jackson and Hibernate. This is done to ensure that things interoperate dependably and reduces the burden on application developers to find what versions of things will play nicely together.

You'll need to locate your build file and update the Spring Boot Starter Parent accordingly.

### For Maven projects

Locate your `pom.xml` file and modify the following:

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.5.16</version>
    <relativePath/> <!-- lookup parent from repository -->
</parent>
```

In this example, you can see the current version of `spring-boot-starter-parent` is `3.5.16`. Set the version to `4.1.0`.

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>4.1.0</version>
    <relativePath/> <!-- lookup parent from repository -->
</parent>
```

#### What to do if you _aren't_ using `spring-boot-starter-parent`?

We recommend the following steps for updating the current Spring Boot version if you have a very customized or "bespoke" parent `pom`.

@@@alert
{
"text": "You should follow your established SDLC practice if it doesn't exactly match the steps below.",
"type": "warning"
}
@@@

1. Fetch the latest version of the code.
2. Create a branch with an appropriate name, for example, `spring-boot-3.5-upgrade`.
3. Modify the `spring-boot-starter-parent` version in the Parent POM.
4. Update the "version" for the parent pom project, based on your SDLC versioning practice.
5. Publish this change to your local M2 repository. For example:

   ```shell
   $ ./mvnw publish
   ```

6. Commit your work to the new branch.
7. Update your project pom to use the new parent pom version.
8. Proceed with the upgrade.

**Note:** Once you're comfortable with the change(s), generate a pull request, or merge this update back to the trunk, or the appropriate place for your operating environment.

If you're using `spring-boot-dependencies` BOM:

- Update the BOM version to `4.1.0`
  - Ideally, this will be in your parent `pom`'s dependency management section or the dependency management section of your project `pom`.
  - Take similar steps to those outlined above for the bespoke parent `pom`, if required.

### Pro tip: properties

If you do need to manually set the Spring Boot version, we highly recommend using properties to keep your discrete versions in one place. Then, reference those properties in the dependency. This avoids the error-prone overhead of searching everyone in your `pom` for hard-coded versions.

#### Properties in Maven projects

```xml
<properties>
   <java.version>17</java.version>
   <spring.boot.dependencies.version>4.1.0</spring.boot.dependencies.version>
</properties>

    <dependencyManagement>

       <dependencies>
      <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-dependencies</artifactId>
         <version>${spring.boot.dependencies.version}</version>
      </dependency>
   </dependencies>
</dependencyManagement>
```

Well, that was easy! Now, let's compile.

## Attempt to Compile the Code

Now that we've updated the base Spring Boot version, let's attempt to compile, and see what happens. Depending on the complexity of the application, the number of Spring Boot/Spring dependencies, and lots of other factors, the application may or may not compile. Don't worry if it doesn't. We're going to make many small changes, and we'll be compiling frequently as we perform the upgrade.

The old adage "Plan small, Fail small" comes to mind. In this case, it's "Small Change, Compile, Assess, React" - **SCAR**.

**S**mall change -> **C**ompile -> **A**ssess - > **R**eact (small change) -> compile ...

To allow us to iterate quickly, and keep our feedback loop tight, we're going to skip running tests for now. We don't want to waste time or focus on tests until we're done making updates to the project dependencies. Don't worry, when we get through the "Update" part of the process, we'll be running the tests!

```shell
$ ./mvnw clean compile
```

**SCAR** - Keep your feedback loop tight. Make a small change, attempt to compile, assess the impact of the change, react.

## Establish a New Baseline

Now that you've attempted to compile, capture any warnings and/or error messages. This will become our new baseline. As we move through the remainder of this module our goal will be to improve the baseline until the code successfully compiles again.

Document the current state in writing, and in source control.

1. Take note of any errors, warnings, or issues in the `upgrade-notes.md` file.
   1. Append a new heading to the document titled - "Update Base Spring Version".
   2. Document any errors, warnings, or other issues.
2. Issue a commit.

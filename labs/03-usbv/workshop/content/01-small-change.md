With any luck we only need to make one change: updating the `spring-boot-starter-parent` version in our `pom.xml`.

To reinforce the **SCAR** method, you'll make a **S**mall change and then continually **C**ompile, **A**ssess, and **R**eact to the output you see.

**_Note:_** At the time of this writing, the current Spring Boot 4.1.x version is `4.1.0`.

## Make a **S**mall Change

The first **S**mall change consists of updating the Spring Boot Parent Starter version.

The current `pom.xml` looks like this:

```editor:select-matching-text
file: ~/exercises/pom.xml
text: "spring-boot-starter-parent"
before: 2
after: 3
```

```xml
<parent>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-parent</artifactId>
	<version>3.5.16</version> <!-- <=== Update this! -->
	<relativePath/> <!-- lookup parent from repository -->
</parent>
```

The updated `pom.xml` should look like this:

```xml
<parent>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-parent</artifactId>
	<version>4.1.0</version> <!-- <=== Updated! -->
	<relativePath/> <!-- lookup parent from repository -->
</parent>
```

Well, that was easy! Now let's compile.

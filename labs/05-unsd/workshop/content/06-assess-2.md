There's really nothing to **A**ssess in terms of a version change here -- `itextpdf`'s version wasn't managed by Spring before, and it still isn't. It was only moved to a clearer section of the `pom.xml`.

Just to be sure, though, let's confirm the build is healthy and check the dependency tree again.

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

```shell
[~/exercises] $ ./mvnw dependency:tree | grep itextpdf
```

You'll see the version is exactly as it was before:

```shell
[INFO] +- com.itextpdf:itextpdf:jar:5.5.13.3:compile
```

Nice! The version is unchanged, just managed through a property instead of an inline hard-coded value.

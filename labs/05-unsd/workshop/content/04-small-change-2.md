We found at least one hard-coded _non_-Spring dependency. Are there any others? Let's keep looking through the `pom.xml` and find out.

1. Keep searching through `pom.xml`.

   Open up `pom.xml` and see if there are any other hard-coded non-Spring dependencies.

   ```editor:select-matching-text
   file: ~/exercises/pom.xml
   text: "com.itextpdf"
   before: 1
   after: 3
   ```

   Look at the `itextpdf` dependency, its version is explicitly stated!

   ```xml
   <dependency>
       <groupId>com.itextpdf</groupId>
       <artifactId>itextpdf</artifactId>
       <version>5.5.13.3</version>
   </dependency>
   ```

   Let's see if Spring will manage this one for us, too.

2. Comment out the explicit `itextpdf` version and **A**ssess.

   ```editor:select-matching-text
   file: ~/exercises/pom.xml
   text: "com.itextpdf"
   before: 1
   after: 3
   ```

   ```xml
   <dependency>
       <groupId>com.itextpdf</groupId>
       <artifactId>itextpdf</artifactId>
       <!-- <version>5.5.13.3</version> -->
   </dependency>
   ```

   Let's **A**ssess by seeing what the dependency tree says:

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw dependency:tree | grep itextpdf

   [ERROR] 'dependencies.dependency.version' for com.itextpdf:itextpdf:jar is missing. @ line 54, column 15
   [ERROR]     'dependencies.dependency.version' for com.itextpdf:itextpdf:jar is missing. @ line 54, column 15
   ```

   Oh no! Maven can't even build the project now. `itextpdf` is a third-party library that neither Spring nor Spring Boot has any awareness of, so there's no managed version for Maven to fall back on once we remove the hard-coded one.

Unlike `lombok`, this dependency really does need an explicit version. Let's implement the best practice of using a Maven Property to manage it, rather than hard-coding it inline.

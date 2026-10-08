Again, we'll use **SCAR** to iteratively update our non-Spring dependencies.

## Make a **S**mall change

1. Locate hard-coded non-Spring dependencies.

   Open `pom.xml` and search through the dependencies within.

   Can you find any hard-coded non-Spring versions?

   ```editor:select-matching-text
   file: ~/exercises/pom.xml
   text: "org.projectlombok"
   before: 1
   after: 3
   ```

   We found one! Look at `lombok` -- its version is hard-coded.

   ```xml
   <dependency>
       <groupId>org.projectlombok</groupId>
       <artifactId>lombok</artifactId>
       <version>1.18.30</version>
   </dependency>
   ```

   Check it out in the dependency tree, too:

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   [~/exercises] $ ./mvnw dependency:tree | grep lombok

   [INFO] +- org.projectlombok:lombok:jar:1.18.30:compile
   ```

   Let's see if Spring will manage this for us or not.

2. Comment out the `<version>` tag.

   Go back to the `pom.xml` and comment-out the hard-coded `lombok` version:

   ```editor:select-matching-text
   file: ~/exercises/pom.xml
   text: "org.projectlombok"
   before: 1
   after: 3
   ```

   ```xml
   <dependency>
       <groupId>org.projectlombok</groupId>
       <artifactId>lombok</artifactId>
       <!-- <version>1.18.30</version> -->
   </dependency>
   ```

That's the first one! Let's compile and assess before searching for other non-Spring dependencies with hard-coded versions.

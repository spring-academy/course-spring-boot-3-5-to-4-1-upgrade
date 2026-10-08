Let's add the `spring-boot-properties-migrator` dependency, and use it to find any deprecated properties.

## Make a **S**mall Change

Add the `spring-boot-properties-migrator` dependency to the `pom.xml`

```editor:select-matching-text
file: ~/exercises/pom.xml
text: "Developer Tools"
```

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-properties-migrator</artifactId>
    <scope>runtime</scope>
</dependency>
```

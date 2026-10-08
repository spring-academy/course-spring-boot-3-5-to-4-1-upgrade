Don't forget, you want to disable or remove the `spring-boot-properties-migrator` before running this application in production.

The choice is yours (or perhaps it's your organization policy's choice) to either delete the dependency, or just comment it out for use during future Spring Boot upgrades.

```editor:select-matching-text
file: ~/exercises/pom.xml
text: "spring-boot-properties-migrator"
```

```xml
<!-- comment out or delete -->
<!-- <dependency> -->
    <!-- <groupId>org.springframework.boot</groupId> -->
    <!-- <artifactId>spring-boot-properties-migrator</artifactId> -->
    <!-- <scope>runtime</scope> -->
<!-- </dependency> -->
```

It's a diagnostic tool for upgrades, not something to ship to production.

Let's close out our upgrade notes for this section:

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

```markdown
- Removed the `spring-boot-properties-migrator` dependency again - it's a diagnostic tool for upgrades, not something to ship to production

_Result:_ code compiles without errors or warnings and all tests pass
```

The `spring-boot-properties-migrator` did its job and found a property that's been deprecated and replaced by another.

Let's note this in `upgrade-notes.md`.

Open the file and add this new section:

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

```markdown
## Address deprecated Spring Properties

- Added the `spring-boot-properties-migrator` dependency (runtime scope, dev-only) and ran `./mvnw spring-boot:run`
- The migrator flagged a renamed property:
  ```
  WARN ... PropertiesMigrationListener:
  The use of configuration keys that have been renamed was found in the environment:
  	Key: spring.resources.cache.period
  		Line: 22
  		Replacement: spring.web.resources.cache.period
  ```
  - Without the migrator, this property is silently ignored on Boot 4 - the app starts up with no error or warning, and the static resource cache-control header just quietly doesn't get set the way we intended
```

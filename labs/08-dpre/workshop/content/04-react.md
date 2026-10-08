Now, we can fix the offending property.

Replace the key `spring.resources.cache.period` with the key `spring.web.resources.cache.period` as the Migrator suggested. In practice, that means nesting the `resources: cache: period:` block under `web:` instead of leaving it as a sibling of `web:`:

```editor:select-matching-text
file: ~/exercises/src/main/resources/application.yml
text: "resources:"
```

Pay attention, as you may not need the whole file in the sample below. The `application.yml` may already have other Spring configurations.

```yaml
spring:

  web:
    locale: en_US
    resources:
      cache:
        period: 31536000
```

Remove the old top-level `resources:` block entirely - it's now nested under `web:` instead.

You can now re-run the application and verify you've eliminated the deprecated key.

Kill any running apps in the **Terminal** by pressing `CTRL-C`, then run the application again.

```dashboard:open-dashboard
name: Terminal
```

```shell
[~/exercises] $ ./mvnw spring-boot:run
...
2026-08-14T09:24:03-06:00  INFO 42107 --- [           main] example.cashcard.CashCardApplication     : Started CashCardApplication in 3.842 seconds (process running for 4.077)
```

Great! No more `PropertiesMigrationListener` warning - you've eliminated the deprecated property.

Let's update our upgrade notes again:

```markdown
- Fixed `application.yml` to use `spring.web.resources.cache.period`, re-ran, confirmed the warning is gone
```

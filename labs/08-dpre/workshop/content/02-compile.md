Actually, at this point, we're _not_ going to **C**ompile the code directly.

Rather, we're going to use the Spring Boot Maven Plugin to start the application!

```dashboard:open-dashboard
name: Terminal
```

```shell
[~/exercises] $ ./mvnw spring-boot:run
```

The application should be up and running, but you'll find some interesting output at the end of the log.

```shell
...
2026-08-14T09:22:41-06:00  INFO 41822 --- [           main] example.cashcard.CashCardApplication     : Started CashCardApplication in 3.978 seconds (process running for 4.231)
2026-08-14T09:22:41-06:00  WARN 41822 --- [           main] ... PropertiesMigrationListener            :
The use of configuration keys that have been renamed was found in the environment:

Property source 'Config resource 'class path resource [application.yml]' via location 'optional:classpath:/'':
        Key: spring.resources.cache.period
                Line: 22
                Replacement: spring.web.resources.cache.period


Each configuration key has been temporarily mapped to its replacement for your convenience. To silence this warning, please update your configuration to use the new keys.
```

Interesting! We have a property that needs to be migrated.

Notice that the application still started up successfully. The migrator temporarily maps the deprecated key to its replacement for us behind the scenes, so it only *warns* rather than fails.

That's convenient while we're actively upgrading, but don't be fooled by it: if we hadn't added `spring-boot-properties-migrator` at all, this exact same `application.yml` would have started up with **no error and no warning whatsoever**. The property would simply be silently dropped - the app looks perfectly healthy in the logs, and the only real-world symptom is that our static resources quietly stop getting the cache-control header we configured. That's exactly the kind of failure this tool exists to catch before it ships.

Let's keep track of this.

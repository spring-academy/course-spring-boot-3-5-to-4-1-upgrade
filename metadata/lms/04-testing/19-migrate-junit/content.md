Our sample application's tests are already written against JUnit 5 (Jupiter), so there's no JUnit 4-to-5 migration to perform here. But this upgrade still has a JUnit-related trap worth knowing about, especially if your own application still has legacy JUnit 4 tests.

## JUnit Jupiter version bump

Spring Boot 3.5 manages JUnit Jupiter `5.12.x`; Spring Boot 4.1 bumps that to JUnit Jupiter `6.0.x`. For typical Jupiter usage this is source-compatible and shouldn't require any code changes.

## The JUnit Vintage engine is no longer included

If your application still has JUnit 3 or JUnit 4 tests, you were likely relying on the *JUnit Vintage engine* - a compatibility layer that lets JUnit 3/4-style tests run on the JUnit 5 Platform. Earlier versions of `spring-boot-starter-test` pulled this in transitively without you having to think about it.

@@@alert
{
"text": "#### Key Takeaway \n Spring Boot 4's `spring-boot-starter-test` (and its modular successors, like `spring-boot-starter-webmvc-test`) no longer bring in the JUnit Vintage engine by default. If you still have JUnit 3/4-style tests, they won't error out - they'll simply stop being discovered and run at all. This can be a dangerously silent way to lose test coverage during an upgrade.",
"type": "warning"
}
@@@

If you still need to run legacy JUnit 3/4 tests under Boot 4, you'll need to add `org.junit.vintage:junit-vintage-engine` as an explicit test-scoped dependency yourself. Spring Framework 7 has otherwise deprecated JUnit 4 support in favor of Jupiter + `SpringExtension`, so treat the Vintage engine as a temporary bridge, not a long-term solution - plan to actually migrate those tests.

## Key changes when migrating JUnit 4 tests to JUnit 5/6?

**Annotations:**

- `@Before` annotation is now `@BeforeEach`
- `@After` annotation is now `@AfterEach`
- `@BeforeClass` annotation is now `@BeforeAll`
- `@AfterClass` annotation is now `@AfterAll`
- `@RunWith` annotation is now `@ExtendWith`

Explore the [official JUnit 4 migration guide](https://docs.junit.org/6.0.3/migrating-from-junit4.html) if you have a legacy test suite to migrate.

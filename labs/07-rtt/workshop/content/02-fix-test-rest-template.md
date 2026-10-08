Fixing this takes three small, related changes: add the new dependency that actually contains `TestRestTemplate`, point the import at its new package, and — this part is easy to miss — tell Spring Boot to actually give us a `TestRestTemplate` bean to autowire.

## Add the new test dependencies

Open `pom.xml` and find the `spring-boot-starter-webmvc-test` dependency:

```editor:select-matching-text
file: ~/exercises/pom.xml
text: "spring-boot-starter-webmvc-test"
before: 2
after: 2
```

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-webmvc-test</artifactId>
    <scope>test</scope>
</dependency>
```

Add two new test-scoped dependencies right after it: `spring-boot-resttestclient`, the new home for `TestRestTemplate`, and `spring-boot-starter-restclient`, which `spring-boot-resttestclient` needs on the classpath to do its job.

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-resttestclient</artifactId>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-restclient</artifactId>
    <scope>test</scope>
</dependency>
```

## Update the import

Now open `CashCardApplicationTests.java` and fix the import:

```editor:select-matching-text
file: ~/exercises/src/test/java/example/cashcard/CashCardApplicationTests.java
text: "import org.springframework.boot.test.web.client.TestRestTemplate;"
```

```java
import org.springframework.boot.resttestclient.TestRestTemplate; // <=== Updated!
```

While you're in the imports, add one more, for the annotation we're about to use:

```java
import org.springframework.boot.resttestclient.autoconfigure.AutoConfigureTestRestTemplate; // <=== New import!
```

## Add `@AutoConfigureTestRestTemplate`

Here's the part that's easy to miss. In Spring Boot 3.x, simply declaring `@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)` was enough — Spring Boot would automatically register a `TestRestTemplate` bean for you to `@Autowired`. In Spring Boot 4, now that `TestRestTemplate` lives in its own separate module, that auto-registration no longer happens automatically. You have to ask for it explicitly with a new annotation, `@AutoConfigureTestRestTemplate`.

Find the class declaration:

```editor:select-matching-text
file: ~/exercises/src/test/java/example/cashcard/CashCardApplicationTests.java
text: "@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)"
after: 1
```

```java
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class CashCardApplicationTests {
```

Add the new annotation right above the class declaration:

```java
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureTestRestTemplate // <=== Add this!
class CashCardApplicationTests {
```

That's the fix — a new dependency, an updated import, and one new annotation. Let's see if it worked.

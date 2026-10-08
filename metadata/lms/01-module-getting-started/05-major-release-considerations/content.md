## Major Release Upgrade Considerations

Because this upgrade crosses a `major` release boundary it is important to take some preliminary or preparatory steps to reduce the risk of the upgrade.

As a best practice we should review any upgrade guides or blogs looking for deprecations or big API changes that will impact us and update our code as recommended.

- [Upgrading Spring Boot 3.5 to 4.0](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-4.0-Migration-Guide)
- [Spring Boot 4.0 Migration Guide](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-4.0-Migration-Guide)
- [Spring Security Migration to 7.0 Guide](https://docs.spring.io/spring-security/reference/6.5/migration-7/index.html)

Based on what we learn we need to make the recommended changes/updates:

1. Review release notes and blogs
1. Update code as recommended
1. Ensure we still have our application in a **K**nown **G**ood **S**tate

@@@alert
{
"text": "After making the recommended changes it is imperative that your code still compiles and all tests pass!",
"type": "warning"
}
@@@

## Establish A New Baseline

Document the current state in writing and in source control.

1. Take note of any errors, warnings, or issues in the `upgrade-notes.md` file.
   1. Append a new heading to the document titled - "Major Release Considerations".
   2. Document any errors, warnings, or other issues.
2. Issue a commit.

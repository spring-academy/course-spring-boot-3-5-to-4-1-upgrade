Prior to attempting any upgrade it's important to review the release notes for your current version of Spring Boot (in this case 3.5), its predecessor minor version (3.4), the target version (4.1), and any versions in between. The release notes will familiarize you with deprecations, known issues, and what's new.

## Deprecations

For the purposes of this course you'll definitely want to understand the deprecations for 3.4 and 3.5 because you'll need to address those in order to successfully upgrade to 4.1. The Spring Boot team will maintain deprecations for one (1) minor version only. So, 3.2 deprecations are no longer supported in 3.4, and 3.3 deprecations will no longer be supported in 3.5.

- [3.4 Release Notes](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-3.4-Release-Notes)
- [3.5 Release Notes](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-3.5-Release-Notes)
- [4.0 Release Notes](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-4.0-Release-Notes)
- [4.1 Release Notes](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-4.1-Release-Notes)

## `major` Version Upgrades

It is also important to understand the significance of a `major` version upgrade. A major version upgrade is represented by the "major" number incrementing. For example, "1.0" to 2.0", "10.9.8" to "11.2.5", etc.

Why is this so important when upgrading? According to [semantic versioning](https://semver.org/) (semver) conventions, API developers are allowed to make non-backwards-compatible or "breaking" changes when crossing a major-version boundary.

For a Spring Boot upgrade, deprecations will not be maintained across major version releases for any Spring or Spring Boot library. That means what might have been deprecation warnings in a minor release might turn into compilation or runtime errors when the Spring or Spring Boot teams publish a major release.

### Spring Security

As is the case in most Spring Boot upgrades, Spring Security is of particular concern. Spring Boot 4 pairs with Spring Security 7, which removes some APIs outright rather than just deprecating them. That means we'll upgrade the major version of not only Spring Boot, but also the major version of at least one Spring project used within our sample Spring Boot application.

### Auto-Configuration Modularization

Spring Boot 4 is also a good reminder that major releases aren't just about removed APIs. Boot 4 split the old, monolithic `spring-boot-autoconfigure` jar into many smaller, per-technology modules. A dependency that "just worked" under Boot 3 because it happened to ride along with the monolithic autoconfigure jar may need its dedicated Boot starter under Boot 4 -- and the compiler won't tell you if you miss one. We'll see a concrete example of this later in the course.

### Review the Docs

With that in mind we recommended you perform some extra due diligence during `major` upgrades. For this upgrade that means reviewing the following in addition to the normal release notes.

- [Upgrading Spring Boot 3.5 to 4.0](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-4.0-Migration-Guide)
- [Spring Boot 4.0 Migration Guide](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-4.0-Migration-Guide)
- [Spring Security Migration to 7.0 Guide](https://docs.spring.io/spring-security/reference/6.5/migration-7/index.html)

As part of the next step in the upgrade process -- "Assess" -- we are going to execute some `preparatory` changes to our code to ensure it is ready for the leap of a `major` release upgrade. Doing that will pay huge dividends as we perform the upgrade.

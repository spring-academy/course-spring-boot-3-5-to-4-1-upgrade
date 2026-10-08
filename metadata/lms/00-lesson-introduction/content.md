When we upgrade an application to a new version of Spring Boot, we change its dependencies and code so that it's based on the new version. This requires modification of the application dependencies, including Spring Boot, Spring, and third party libraries.

## Basic upgrade process

1. Prepare

   - Review the release notes for the target version of Spring

1. Assess

   - Access and assess the application source code
   - Establish a baseline - Known Good State (KGS)

1. Update

   - Base Spring Boot dependency
   - Spring/Spring Boot dependencies
   - Non Spring managed dependencies as required

1. Test

   - Update Test Dependencies
   - Execute Test
   - Run the application and test for parity

1. Release

We'll walk through these steps systematically, and you'll get a chance to practice everything in our interactive, hands-on labs. That's right -- you'll actually upgrade a Spring Boot 3.5 application to 4.1, right here in this course!

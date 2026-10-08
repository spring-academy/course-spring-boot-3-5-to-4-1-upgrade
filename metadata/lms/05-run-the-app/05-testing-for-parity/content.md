Your application compiles now, based on the upgraded version of Spring Boot. All tests are passing! It bootstraps and runs without ab-ending or generating warnings or errors.

But, just because the application compiles and locally-run tests pass, does this mean the application actually works _exactly_ the same way that it did before the upgrade? Does it perform _as well_ or _better_ than it did before the upgrade?

To answer these questions you'll need to perform every kind of validation at your disposal. The following are our suggestions.

## Validate Functionality

Now that the application is running, it's time to validate that it's operating and functioning as expected.

Our recommended approach would be as follows:

1. Execute any and all automated functional, integration, and end to end (E2E) tests that you can locally.
2. Execute any static code analysis required in your operating environment and security policies.
3. Manually go through the application to verify that all use-cases are functioning. If your application exposes a UI, ensure everything is rendering as expected.
4. Once all of the above are done to your satisfaction, generate a commit following your SDLC practice. Get your application into your CI/CD pipeline, and deployed into the development or testing environment.
5. If you have a QA or Customer Service team that performs testing, now would be a good time to engage them. QA and CS teams often know the application better than anyone!
6. Remediate any other issues that arise, if any. Remember to establish a new baseline with each change!

## Validate Performance

Now that we've ensured that the application is behaving functionally, as expected, it's time to ensure that it's performing as well - or better - than before the upgrade.

If you have a suite of performance test(s), now's the time to execute them. If you don't, we'd recommend engaging in some form of manual performance and/or load testing. We'd recommend using something like [JMeter](https://jmeter.apache.org/), a Java application designed to load test functional behavior and measure performance.

If you're unfamiliar with these concepts and would like to learn more

- [Site Reliability Engineering](https://sre.google/)
- [Load Testing](https://www.geeksforgeeks.org/software-testing-load-testing/)

@@@alert
{
"text": "#### Key Takeaway \n
Parity and Performance testing are essential to establishing confidence in both you and your customer's minds in the upgraded application.",
"type": "info"
}
@@@

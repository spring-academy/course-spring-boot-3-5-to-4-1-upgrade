Before attempting to upgrade the application, we must understand what state it's currently in. The primary goal is to establish a baseline of the application's current behavior before making changes.

Lacking this understanding, we'd have no idea if problems we may encounter were caused by the changes being made during the upgrade, or if they were pre-existing.

### Before we begin: Setting the logging level

Before assessing the application, we recommend that you adjust the logging level of your Spring Boot application. We recommend temporarily commenting out any discrete logging settings and adjusting the "ROOT" logger to `INFO`. Please accept the spirit of the recommendation and adjust for whatever logging implementation you're using.

Here is an example of how you might do this in Spring Boot's `application.yml`:

```yaml
logging.level:
  # org.springframework.context: WARN
  # org.springframework.data: WARN
  # org.springframework.jdbc: WARN
  ROOT: INFO
```

## The known good state

As a best practice, we should start the upgrade from a known "good" state _(KGS)_.

What exactly does that mean?

- The code compiles
- All tests are passing
- The application runs, and the feature functionality is working as expected
- You have no warning or error messages during compilation or at runtime
  - An exception would be warnings or errors related to deprecations that will be addressed during the upgrade*

    @@@alert
    {
    "text": "This particular upgrade we are faced with an existing deprecation for Spring Security's `AntPathRequestMatcher`. Don't worry we will address it first as part of the `Major Release Considerations` lesson & lab.",
    "type": "info"
    }
    @@@


@@@alert
{
"text": "It's our firm recommendation if the code doesn't compile or if you have broken tests, that they should be fixed before proceeding!",
"type": "warning"
}
@@@

**Note:** If there's commented-out code or tests, you should, at a minimum, understand _why_ this code isn't part of the production codebase, and if that's appropriate. If it's not appropriate, you should take the time now to clean up, and/or fix the code, and tests.

@@@alert
{
"text": "#### Key Takeaway \n If we don't start from a **K**nown **G**ood **S**tate we won't know if the failures, errors, or warnings we encounter are pre-existing, or related to changes made during the upgrade!",
"type": "info"
}
@@@

Assessing our code and starting from a known good state sets us up for our first **baseline**.

## Baseline

Now that we have a KGS, let's document our baseline. What's a baseline?

> ### baseline
>
> bās′līn″
>
> noun
>
> - A line serving as a basis, as for measurement, calculation, or location.
> - Something, such as a set of data, is used as a basis for comparison or as a control in a study.
> - A starting point.

We recommend documenting the current state in writing, and in source control. Note that we won't be making actual source control commits during lab(s). The following are the steps we recommend that you take when working in your operating environment on your application source.

1. If you made changes to establish your KGS, commit them to your source control.
2. Create a new branch based on your current commit.
3. Take note of any remaining warnings or issues (**Hint:** If you're doing it right there shouldn't be any!). For example, we'll use a document called `upgrade-notes.md` in our labs.
   - You should apply a heading for these particular notes of "Initial Baseline". We'll be modifying this document throughout the upgrade process, adding more notes, and documenting new/updated baselines repeatedly.
4. Commit your notes to the branch.

## Rinse and repeat

Spoiler alert: You're going to end each subsequent lesson in this course with the same step: **_Establish a New Baseline._** Establishing and continuously updating your baseline will help you methodically work through the upgrade process. This minimizes the risk of losing track of your progress and the evolving state of the application.


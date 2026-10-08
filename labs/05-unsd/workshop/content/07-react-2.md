Time for our final **r**eaction of this lab: update our notes.

Add the following to the `Update Non Spring/Spring Boot Managed Dependencies` section we started earlier:

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

```markdown
- moved hardcoded `itextpdf` version to `<properties>` - Spring doesn't manage this dependency for us, so we can't just delete the version, but we can stop hard-coding it inline

_Result:_ code compiles without errors or warnings (tests not yet run)
```

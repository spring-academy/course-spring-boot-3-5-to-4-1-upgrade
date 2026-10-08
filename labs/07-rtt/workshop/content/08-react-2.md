Our reaction here is simple: just note the change in `upgrade-notes.md`.

Add a new section, `Test Dependency Housekeeping`:

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

```markdown
## Test Dependency Housekeeping

- Removed the explicit `assertj-core` test dependency
- Code Compiles, No Errors or Warnings, all tests still pass
  - It's managed by `spring-boot-starter-webmvc-test`

_Result:_ code compiles without errors or warnings and all tests pass
```

Fewer explicit dependencies means fewer versions for us to babysit by hand — one less thing to remember to double-check on the *next* major upgrade.

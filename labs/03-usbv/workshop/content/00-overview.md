In this lab we'll make the first steps in our Family Cash Card application upgrade: updating the Spring Boot Starter Parent version. The Spring Boot Starter Parent is the entry point or base upon which most Spring Boot applications are built, so it makes sense to start there.

This is also where we put the **SCAR** method to the test for real. In the last lab you fixed a deprecation you could already *see* before making the major-version jump. This time, you're going to make the version bump first and find out what breaks — for real, not hypothetically.

## Review our Upgrade Notes

We're keeping detailed notes of the baseline state of our application as we upgrade it. Take a look at `upgrade-notes.md` to review where we are now.

```editor:open-file
file: ~/exercises/upgrade-notes.md
```

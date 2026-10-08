In this lab you learned how to find and remove a hard-coded _non_-Spring dependency version that Spring is willing to manage for us -- `lombok` -- and confirmed the parent-managed version was already current.

You also learned that sometimes we really do need an explicit, hard-coded version, because Spring has no idea a dependency like `itextpdf` even exists. In that case, the best practice is a Maven Property, not an inline version -- it keeps every explicitly-pinned version visible in one place, near the top of the `pom.xml`.

Our `pom.xml` is in good shape now: no unnecessary hard-coded versions, and the one dependency that genuinely needs one is tucked away in `<properties>` where it belongs.

There's still more `pom.xml` housekeeping ahead of us, though -- next up, we'll look at how Spring Boot 4 renamed some of its own starters, and bring our `pom.xml` in line with what a fresh Spring Initializr project would generate today.

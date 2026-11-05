# Stage 1 — Dart Fundamentals Retention Assessment

**Stage 1 curriculum:** Completed (8/8 lessons).  
**Retention assessment:** Completed (4/4 checkpoints approved).
**Stage 2:** Not started.

This assessment checks whether I can apply Dart fundamentals independently after completing the lessons. The checkpoints distinguish initial recall from later corrections; approved code alone is not evidence that an attempt was error-free.

| Checkpoint | Topic                                                               | Status   | Independence                                                             |
| ---------- | ------------------------------------------------------------------- | -------- | ------------------------------------------------------------------------ |
| 01         | [Developer Model](checkpoint-01-developer-model.dart)               | Approved | Initial attempt without notes; approved after guided corrections         |
| 02         | [Specialized Developers](checkpoint-02-specialized-developers.dart) | Approved | Passed first attempt without notes; formatting suggestions only          |
| 03         | [Developer Registry Report](checkpoint-03-registry-report.dart)     | Approved | Initial attempt without notes; approved after one method-call correction |
| 04         | [Safe Project Updates](checkpoint-04-error-handling.dart)           | Approved | Initial attempt without notes; approved after guided corrections         |

## Checkpoint 01 — Developer Model

**Goal:** Rebuild a class with `String` and `String?` fields, a library-private integer field, constructor, getter, validated state mutation, null-safe display, and object method calls.

**Initial independent attempt:** Remembered fields, constructor shorthand, getter, validation intent, and output structure. Mistakes included `class Developer()` syntax, updating the local `amount` rather than `_completedProjects`, missing `??`, and incorrect object creation and instance method calls.

**Corrections:** Fixed the class declaration and object calls, added `githubUsername ?? 'Not provided'`, and corrected state mutation to `_completedProjects += amount`.

**Approved expected output:**

```text
Developer: Lary
GitHub: Not provided
Completed projects: 6
```

**Retention finding:** Good recall of individual OOP constructs; combining them and correctly updating object state initially required hints.

## Checkpoint 02 — Specialized Developers

**Goal:** Extend the approved Developer model with `FlutterDeveloper` and `BackendDeveloper`, constructor chaining through `super(...)`, overridden `introduce()` methods, and inherited `showProfile()`.

**Independent attempt:** Passed on the first submission without notes. The class hierarchy, null safety, parent constructor arguments, overrides, and method calls were correct. Only optional formatting and constructor parameter naming were suggested.

**Approved expected output:**

```text
I am Lary, a Flutter developer.
I am Alex, a backend developer.
Developer: Alex
GitHub: Not provided
Completed projects: 7
```

**Retention finding:** Improved independent recall, including the `_completedProjects += amount` correction that was challenging in Checkpoint 01.

## Run the exercises

From the repository root:

```bash
dart run dart-fundamentals/retention-assessment/checkpoint-01-developer-model.dart
dart run dart-fundamentals/retention-assessment/checkpoint-02-specialized-developers.dart
```

## Checkpoint 03 — Developer Registry Report

**Independent attempt:** Completed without notes. Parent and child classes, constructor chaining, null safety, four-object collection, getter-based accumulator, and report summary were correct. One functional correction was needed: `developer.introduce;` referenced the method instead of invoking it. Corrected to `developer.introduce();`.

**Approved output:** Four introductions and profiles in Lary, Alex, Sam, Nina order; total developers **4** and total completed projects **18**.

**Retention finding:** Strong recall of inheritance, method overriding, null-safe display, getters, and accumulator scope. Review method invocation syntax.

## Checkpoint 04 — Safe Project Updates

**Independent attempt:** Completed without notes. Developer class, validation, private state, getter, and null-safe profile were retained. The initial `main()` reused the prior registry loop and did not implement the required exception handling.

**Guided corrections:** Replaced the unnecessary collection loop with one Developer instance. Built the first successful `try/catch`, corrected missing catch and closing brace, added a second `try/catch/finally` for a negative update, removed an unnecessary print, and moved `showProfile()` after `finally`.

**Approved output:** Successful addition from 4 to **7**, rejected `-2` with the specified exception, completion message exactly once, and final profile showing **7** projects.

**Retention finding:** Validation and object state were retained; independent construction of `try/catch/finally` and block scope needed reinforcement.

## Overall assessment

| Checkpoint                | Result                            | Independent attempt |
| ------------------------- | --------------------------------- | ------------------- |
| 01 Developer Model        | Approved after guided corrections | Without notes       |
| 02 Specialized Developers | Approved first attempt            | Without notes       |
| 03 Registry Report        | Approved after one correction     | Without notes       |
| 04 Error Handling         | Approved after guided corrections | Without notes       |

**Strengths:** Classes, constructors, getters, inheritance, overriding, null safety, lists, loops, and accumulation.

**Review targets:** Distinguish object from collection; method references versus calls; braces and scope; independent exception-handling structure.

**Stage 1:** Eight lessons and four retention checkpoints completed. **Stage 2 has not started.**

## Run

```bash
dart format dart-fundamentals/retention-assessment/checkpoint-03-registry-report.dart dart-fundamentals/retention-assessment/checkpoint-04-error-handling.dart
dart analyze dart-fundamentals/retention-assessment/checkpoint-03-registry-report.dart dart-fundamentals/retention-assessment/checkpoint-04-error-handling.dart
dart run dart-fundamentals/retention-assessment/checkpoint-03-registry-report.dart
dart run dart-fundamentals/retention-assessment/checkpoint-04-error-handling.dart
```

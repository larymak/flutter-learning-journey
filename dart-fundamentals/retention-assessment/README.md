# Stage 1 — Dart Fundamentals Retention Assessment

**Stage 1 curriculum:** Completed (8/8 lessons).  
**Retention assessment:** 2/4 checkpoints approved.  
**Stage 2:** Not started.

This assessment checks whether I can apply Dart fundamentals independently after completing the lessons. The checkpoints distinguish initial recall from later corrections; approved code alone is not evidence that an attempt was error-free.

| Checkpoint | Topic | Status | Independence |
| --- | --- | --- | --- |
| 01 | [Developer Model](checkpoint-01-developer-model.dart) | Approved | Initial attempt without notes; approved after guided corrections |
| 02 | [Specialized Developers](checkpoint-02-specialized-developers.dart) | Approved | Passed first attempt without notes; formatting suggestions only |
| 03 | Registry Report | Pending | Not assessed |
| 04 | Error Handling | Pending | Not assessed |

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

## Next

Complete Checkpoints 03 and 04, then evaluate readiness for Stage 2. No Stage 2 lessons have started.

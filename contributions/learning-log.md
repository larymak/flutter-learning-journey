# Learning and contribution log

Use this file to record progress, questions, and contributions without turning every lesson into a full article.

## Lesson 01 — Variables and types

- Built a developer profile generator.
- Practiced Dart's basic types, `var`, `final`, `const`, and interpolation.
- Learned lowerCamelCase naming and the `main()` entry point.

## Lesson 02 — Operators and control flow

- Built a learning tracker with progress and eligibility calculations.
- Corrected an incomplete `&&` expression and an undefined variable.
- Learned to distinguish logical AND from OR.
- Identified boundary tests for lesson counts 0, 14, 15, 29, 30, and 40.

## Lesson 03 — Loops and Collections

**Completed:** October 23, 2026

- Built a Multi-Learner Progress Tracker.
- Practiced lists, indexing, `for` loops, and conditional statements.
- Used a counter to identify advanced learners.
- Used an accumulator to calculate total completed lessons.
- Corrected mistakes involving undefined variables, string indexing, counter placement, and `+=`.

**Key takeaway:** A loop processes each learner, a condition determines their level, a counter tracks matching learners, and an accumulator maintains the running total.

## Lesson 04 — Functions and Parameters

**Completed:** October 26, 2026

- Created a reusable greeting function with one parameter.
- Used multiple positional parameters to display developer progress.
- Returned integer results from `calculateRemainingLessons()` and stored them in `main()`.
- Refactored a shopping cart into separate calculation, counting, and report functions.
- Corrected mistakes involving variable scope, early returns, interpolation, `void` function calls, and unused return values.
- Completed the final coding project and reported passing the knowledge check.

**Key takeaway:** A reusable calculation function returns data; a reporting function can call it and display that data. Keeping responsibilities separate makes code easier to maintain and test.

**Revision goal:** Rebuild a small function-based report from memory after a few days.

## Lesson 05 — Null Safety

**Completed:** October 27, 2026

- Practiced nullable and non-nullable Dart types (`String` and `String?`).
- Used `??` to supply fallback values and `?.length ?? 0` to safely calculate username length.
- Built the Developer Profile Manager with two helper functions and a reporting function.
- Corrected mistakes involving `'null'` versus `null`, parameter scope, positional arguments, void function calls, and exact output formatting.
- Completed the final coding project and reported passing the knowledge check.

**Key takeaway:** Nullable inputs can be safely transformed into predictable non-null outputs, then reused by a reporting function.

**Revision goal:** Rebuild a two-function null-safe report independently without starter code.

## Lesson 06 — Object-Oriented Programming

**Coding milestones completed:** October 29, 2026  
**Final knowledge check:** Pending; to complete during free time.

- Created a Developer class, constructor, methods, and multiple instances.
- Used a library-private `_completedProjects` field with a public read-only getter.
- Implemented state updates and validated positive project additions.
- Built a Developer Directory using `List<Developer>`, indexing, and a `for-in` loop.
- Calculated 3 developers and 17 completed projects using an accumulator.
- Corrected mistakes involving field versus local-variable updates, validation of the wrong value, method-call scope, loop placement, getter access, and interpolation.

**Key takeaway:** Each object owns its own state; methods change that state, getters expose it for reading, and directory-wide calculations belong in the code processing the list.

**Revision goal:** Rebuild a two-developer directory and summary from memory without starter code. Complete the final knowledge check before marking the full lesson assessed.

## Future contribution entries

For each issue or PR, record:

- Project and issue link
- Problem being solved
- Proposed change and tests
- PR link and review feedback
- Outcome and lessons learned

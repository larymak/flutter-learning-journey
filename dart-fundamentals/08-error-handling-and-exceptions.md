# Lesson 08 — Error Handling and Exceptions in Dart

**Status:** Completed — four coding milestones and final knowledge check (6/6), November 2, 2026.

**Project:** [Developer Input Validator](exercises/developer_input_validator.dart)

## What I learned

- Use `try` to run code that might throw, `catch` to handle exceptions, and `finally` for completion/cleanup actions.
- `int.parse()` converts numeric text or throws a `FormatException` for malformed input.
- `throw Exception(...)` enforces an application rule, such as a minimum age.
- Separate parsing, validation, and registration into reusable functions.
- Return `true` or `false` from registration so callers can count successful results.
- Process a list of maps using a `for-in` loop and access known keys using `!`.
- Increment counters conditionally, then calculate and print a single summary **after** the loop.

## Milestones

1. **try/catch/finally:** Handled invalid age text.
2. **throw and validation:** Rejected ages below 18.
3. **Exception handling in functions:** Returned a fallback when parsing failed.
4. **Developer Input Validator:** Combined parsing, validation, boolean results, and a four-person registration report.

## Run the project

```bash
dart format dart-fundamentals/exercises/developer_input_validator.dart
dart analyze dart-fundamentals/exercises/developer_input_validator.dart
dart run dart-fundamentals/exercises/developer_input_validator.dart
```

## Expected behavior

- Lary (`25`) — accepted.
- Alex (`16`) — rejected: underage.
- Sam (`unknown`) — rejected: invalid number format (Dart's exception diagnostic can span multiple lines).
- Nina (`30`) — accepted.

**Summary:** 4 registrations, 2 accepted, 2 rejected.

## Mistakes and corrections

- Used the original input variable instead of a hardcoded literal when parsing.
- Distinguished the input string from the parsed integer.
- Moved both parsing and validation calls inside `try` to catch their exceptions.
- Stopped assigning results from a `void` function.
- Added explicit boolean return values to communicate success or failure.
- Passed the current map's `name` and `ageInput`, rather than the entire list.
- Incremented `acceptedCount` only when registration succeeded.
- Corrected rejected-count subtraction and moved the final summary outside the loop.

## Final knowledge check

**Passed: 6/6.** Topics included `try/catch/finally`, `FormatException`, validation, boolean return values, and loop placement.

## Retention challenge

Rebuild a registration validator from memory using a valid age, an underage value, and malformed text. Explain why the two helper calls belong inside `try`.

## Stage status

**Stage 1 — Dart Fundamentals: completed (8/8 lessons).** Stage 2 has not started.

## References

- [Dart error handling](https://dart.dev/language/error-handling)
- [Dart core libraries](https://dart.dev/libraries/dart-core)

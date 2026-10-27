# Lesson 05 — Null Safety in Dart

**Status:** Completed (coding project and final knowledge check)

**Project:** [Developer Profile Manager](exercises/developer_profile_manager.dart)

## What I learned

- Non-nullable `String` requires a string; nullable `String?` can hold a string or `null`.
- `null` means no value; it differs from `''` (empty string) and `'null'` (literal text).
- `??` provides a fallback only when its left operand is null.
- `?.` safely accesses a member when an object might be null.
- `username?.length ?? 0` returns an integer even if the username is missing.
- `!` asserts a value is non-null; using it on null causes a runtime error. Prefer safe handling.
- Functions can accept nullable inputs and return non-nullable results using fallbacks.

## Project architecture

- `getDisplayValue(String? value) -> String`: returns a displayable string, substituting `Not provided` for null.
- `getUsernameLength(String? username) -> int`: returns the username length or zero.
- `printDeveloperProfile(String developerName, String? githubUsername, String? portfolioUrl) -> void`: coordinates the helpers and prints a report.
- `main()`: creates the sample profile and calls the report function with three positional arguments.

### Expected output

```text
=== DEVELOPER PROFILE ===
Developer: Lary
GitHub: Not provided
Username length: 0
Portfolio: https://example.com
=========================
```

## Mistakes and lessons learned

- Passing `'null'` passes a string, not the absent value `null`.
- Passing `value` from another function fails if it is out of scope.
- Function declarations specify types, but calls pass values without repeating types.
- A function with three required positional parameters needs all three arguments in one call.
- A `void` reporting function should be called directly; it does not return a useful result to print.
- Use the returned values from helper functions instead of hardcoding the report.
- Check exact labels, capitalization, punctuation, and trailing whitespace.

## Independent recall challenge

Without consulting this file, create a `formatContact(String? email)` function that returns `No email` when null, then call it with both a real email and `null`. Explain why `''` does not activate the fallback.

## References

- [Dart null safety](https://dart.dev/null-safety)
- [Dart functions](https://dart.dev/language/functions)
- [Effective Dart](https://dart.dev/effective-dart)

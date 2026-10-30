# Lesson 07 — Inheritance and Polymorphism in Dart

**Status:** Completed — four coding milestones and final knowledge check (6/6), October 30, 2026.

**Project:** [Developer Roles Directory](exercises/developer_roles_directory.dart)

## What I learned

- `extends Developer` establishes inheritance and a subtype relationship.
- A child constructor uses `super(name)` to invoke the parent constructor and initialize inherited state.
- `@override` marks an implementation of an inherited member; it is not for unrelated new methods.
- Polymorphism lets a `List<Developer>` hold parent and child instances. A call to `developer.introduce()` dispatches to the actual object's implementation.
- `is` checks runtime types. `developer is FlutterDeveloper || developer is BackendDeveloper` identifies the specialized roles in this project.
- Initialize a counter once before a loop, increment it only when a condition matches, and print summaries after the loop.
- `${developers.length}` interpolates a property expression; general count is total minus specialized count in this directory.

## Milestones

1. **Inheritance basics:** Built `Developer` and `FlutterDeveloper` using `extends` and `super(name)`.
2. **Method overriding:** Overrode `introduce()` in `FlutterDeveloper` and `BackendDeveloper`.
3. **Polymorphism:** Stored mixed developer types in `List<Developer>` and called `introduce()` through one loop.
4. **Developer Roles Directory:** Added four developers, counted specialized types, and generated a summary.

## Run the project

```bash
dart run dart-fundamentals/exercises/developer_roles_directory.dart
```

## Expected output

```text
=== DEVELOPER ROLES REPORT ===
I am Lary, a Flutter developer.
I am Alex, a backend developer.
I am Sam, a developer.
I am Nina, a Flutter developer.

Total developers: 4
Specialized developers: 3
General developers: 1
==============================
```

## Mistakes and corrections

- Initially marked a new `buildFlutterApp()` method with `@override`, even though the parent did not declare it. Changed child methods to override `introduce()` instead.
- Corrected missing punctuation in output strings to meet the exact report specification.
- Reused one `for-in` loop for all developer types rather than writing a separate loop per subtype.
- Placed `specializedCount++` inside the type-check condition so the general developer is not counted.
- Kept summary calculations and printing after the loop so they run only once.

## Knowledge check

**Passed: 6/6.** Topics: inheritance, `super(name)`, overriding, subtype lists, runtime dispatch, and conditional counters.

## Retention challenge

Rebuild a small mixed developer list without starter code. Explain why an overridden method is chosen at runtime and why the specialized counter excludes general developers.

## References

- [Dart classes](https://dart.dev/language/classes)
- [Dart extend a class](https://dart.dev/language/extend)
- [Dart type test operators](https://dart.dev/language/operators#type-test-operators)

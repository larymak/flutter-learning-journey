# Lesson 01: Variables, types, and string interpolation

**Status:** Completed  
**Exercise:** [Developer Profile Generator](exercises/developer_profile.dart)

## Learning goals

- Define the `main()` entry point.
- Store values using basic Dart types.
- Distinguish `var`, `final`, and `const`.
- Display values using `print()` and string interpolation.

## Key concepts

A variable gives a name to a value. Dart is statically typed, but it can infer a type from an initializer.

| Type | Example | Purpose |
| --- | --- | --- |
| `String` | `'Lary'` | Text |
| `int` | `10` | Whole numbers |
| `double` | `4.5` | Decimal numbers |
| `bool` | `true` | True/false values |

```dart
void main() {
  final developerName = 'Lary';
  const weeklyLearningHours = 10;
  var completedProjects = 0;
  bool learningFlutter = true;
  String targetPlatform = 'Mobile and Web';

  print('Name: $developerName');
  print('Weekly Learning Hours: $weeklyLearningHours');
  print('Completed Projects: $completedProjects');
  print('Learning Flutter: $learningFlutter');
  print('Target Platform: $targetPlatform');
}
```

### `var`, `final`, and `const`

- `var` lets Dart infer a variable's type; the variable can usually be reassigned.
- `final` allows assignment once, including a value computed at runtime.
- `const` requires a compile-time constant.

Prefer `final` for local variables that will not be reassigned. Explicit type annotations are useful when they improve clarity.

### String interpolation

`'$developerName'` inserts a variable into a string. For expressions, use `${...}`, for example `'Next project: ${completedProjects + 1}'`.

## Mistakes and lessons learned

1. **Naming:** The original `DevNmae` contained a typo and did not follow lowerCamelCase. The improved name is `developerName`.
2. **Program structure:** Executable `print()` statements belong inside `main()` (or another executable function/method), not at the top level.
3. **Meaningful boolean values:** `learningFlutter = false` would mean the learner is not currently learning Flutter; `true` better matches this exercise.
4. **Output:** Declaring values does not display them; use `print()`.
5. **Formatting:** Use the Dart formatter to keep indentation consistent.

## Try it yourself

Change `completedProjects` to 1, then add a line that prints the next project number using `${completedProjects + 1}`.

## Official references

- [Variables](https://dart.dev/language/variables)
- [Built-in types](https://dart.dev/language/built-in-types)
- [Effective Dart: Style](https://dart.dev/effective-dart/style)

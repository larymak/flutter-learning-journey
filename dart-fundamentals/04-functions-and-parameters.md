# Lesson 04 — Functions and Parameters in Dart

**Status:** Completed (coding challenges and knowledge check)

**Project:** [Refactored Shopping Cart](exercises/shopping_cart_refactored.dart)

## What I learned

### Declaring and calling functions

A function packages reusable behavior. `void` indicates it doesn't return a useful value.

```dart
void welcomeDeveloper(String name) {
  print('Welcome to Flutter, $name!');
}

void main() {
  welcomeDeveloper('Lary');
}
```

### Parameters and arguments

Parameters are declared in a function's signature; arguments are supplied at the call site. Positional arguments must match the declared order and types.

```dart
void showDeveloperProgress(String name, int completed, int total) {
  print('$name has completed $completed out of $total lessons.');
}

void main() {
  showDeveloperProgress('Lary', 3, 40);
}
```

### Returning values

A function returning `int` can send a calculated integer to its caller. The caller can store and display it.

```dart
int calculateRemainingLessons(int total, int completed) {
  return total - completed;
}

void main() {
  final remaining = calculateRemainingLessons(40, 3);
  print('Remaining: $remaining');
}
```

### Refactoring and function responsibilities

The final Shopping Cart separates calculations from presentation:

- `calculateCartTotal(List<int> prices)` returns the sum.
- `countExpensiveItems(List<int> prices)` returns the number of prices at least 1000.
- `printCartReport(List<int> prices)` prints the items and calls the calculation functions.
- `main()` creates the list and calls the report function.

The sample cart `[500, 1200, 300, 2500, 800]` totals **KES 5300** with **2 expensive items**.

## Independent recall prompts

- Explain the difference between a parameter and an argument.
- Explain why `return total;` must be after the summing loop.
- Write a function that counts prices over a threshold without notes.
- Predict the output of a function that returns a value but whose caller ignores it.

## Further reading

- [Dart functions](https://dart.dev/language/functions)
- [Dart variables and scope](https://dart.dev/language/variables)
- [Effective Dart](https://dart.dev/effective-dart)

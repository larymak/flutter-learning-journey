# Lesson 03: Loops and Collections in Dart

**Status:** Completed  
**Project:** Multi-Learner Progress Tracker

## Learning objectives

- Create and access Dart lists.
- Iterate using `for`, `for-in`, and `while` loops.
- Combine loops with conditional statements.
- Use counters and accumulators.
- Understand loop boundaries and variable scope.

## 1. Lists

A list stores multiple values in an ordered collection.

```dart
final completedLessons = [10, 25, 35, 5, 40];

print(completedLessons[0]); // 10
print(completedLessons.length); // 5
```

Dart lists use zero-based indexing.

## 2. For loops

A `for` loop repeats code while its condition remains true.

```dart
for (int i = 0; i < completedLessons.length; i++) {
  print(completedLessons[i]);
}
```

The loop has three parts: initialization, condition, and update.

## 3. For-in loops

Use `for-in` when you need each value but don't need its index.

```dart
for (final completed in completedLessons) {
  print(completed);
}
```

## 4. While loops

A `while` loop checks its condition before every iteration.

```dart
int count = 0;

while (count < 3) {
  print(count);
  count++;
}
```

The loop must eventually terminate.

## 5. Counters

Counters track how many times a condition is satisfied.

```dart
int advancedLearners = 0;

for (final completed in completedLessons) {
  if (completed >= 30) {
    advancedLearners++;
  }
}
```

**Result:** 2 advanced learners.

## 6. Accumulators

Accumulators maintain a running result.

```dart
int totalCompleted = 0;

for (final completed in completedLessons) {
  totalCompleted += completed;
}
```

**Result:** 115 completed lessons.

## 7. Mistakes I Made

### Undefined identifiers

I initially referenced `lessons[i]` when my list was named `completedLessons`.

**Lesson:** Variable names must match their declarations.

### Indexing the wrong value

I used `learnerLevel[i]` when I wanted to print the complete string.

**Lesson:** Understand the type of each variable and whether indexing is necessary.

### Incrementing the wrong counter

I initially incremented `advancedLearners` inside the Intermediate branch.

**Lesson:** Place counters inside the condition they are intended to count.

### Confusing `=+` with `+=`

I wrote `totalCompleted =+ completed` instead of `totalCompleted += completed`.

**Lesson:** `=+` assigns a positive value, while `+=` adds to the existing value.

## Project outcome

Built a Multi-Learner Progress Tracker that:

- Processes five learners.
- Classifies each learner.
- Counts advanced learners.
- Calculates total completed lessons.
- Produces a formatted console report.

## Further reading

- [Dart Collections](https://dart.dev/language/collections)
- [Dart Loops](https://dart.dev/language/loops)
- [Effective Dart](https://dart.dev/effective-dart)

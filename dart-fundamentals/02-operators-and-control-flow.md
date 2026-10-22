# Lesson 02: Operators and control flow

**Status:** Completed lesson; reference exercise polished from reviewed solution  
**Exercise:** [Flutter Learning Tracker](exercises/learning_tracker.dart)

## Learning goals

- Perform arithmetic and calculate a percentage.
- Compare values with relational and equality operators.
- Combine boolean conditions with `&&`, `||`, and `!`.
- Choose one branch using `if`, `else if`, and `else`.

## Arithmetic operators

| Operator | Meaning | Example | Result |
| --- | --- | --- | --- |
| `+` | Add | `10 + 5` | `15` |
| `-` | Subtract | `10 - 5` | `5` |
| `*` | Multiply | `10 * 5` | `50` |
| `/` | Divide | `10 / 4` | `2.5` |
| `~/` | Truncating division | `10 ~/ 4` | `2` |
| `%` | Remainder | `10 % 4` | `2` |

For a learning tracker:

```dart
const totalLessons = 40;
var completedLessons = 25;
final remainingLessons = totalLessons - completedLessons;
final progress = completedLessons / totalLessons * 100;
```

This gives 15 remaining lessons and 62.5% progress.

## Comparison and logical operators

- `==` checks equality; `=` assigns a value.
- `!=` checks inequality.
- `<`, `<=`, `>`, `>=` compare ordered values.
- `&&` is AND: both operands must be true.
- `||` is OR: at least one operand must be true.
- `!` negates a boolean value.

```dart
final eligible = completedLessons >= 30 && passedAssessment;
```

Even if 30 lessons are complete, eligibility is **false** when `passedAssessment` is false. This was an important misconception corrected during the lesson.

## Conditional branching

```dart
String learnerLevel;
if (completedLessons >= 30) {
  learnerLevel = 'Advanced';
} else if (completedLessons >= 15) {
  learnerLevel = 'Intermediate';
} else {
  learnerLevel = 'Beginner learner';
}
```

The second condition does not need `completedLessons <= 29`: reaching it already means the first condition (`>= 30`) was false.

## Mistakes and lessons learned

1. **Incomplete condition:** `completedLessons >= 15 && <= 29` is invalid. Each side of `&&` must be a complete boolean expression.
2. **Undefined identifier:** Printing `$Level` fails when only `learnerLevel` is declared. Dart identifiers are case-sensitive.
3. **Report completeness:** Calculating a value is not enough; print all requested fields.
4. **Percentage display:** `Progress %: 62.5` is less clear than `Progress: 62.5%`.
5. **AND vs OR:** `true && false` is `false`; `true || false` is `true`.
6. **Formatting:** Use two-space indentation, consistent string quotes, and `dart format`.

## Boundary cases

| Completed lessons | Level |
| --- | --- |
| 0 | Beginner learner |
| 14 | Beginner learner |
| 15 | Intermediate |
| 29 | Intermediate |
| 30 | Advanced |
| 40 | Advanced |

The exercise assumes the count is between 0 and 40. Input validation will be covered later.

## Review reflection

The original exercise's calculations and classification logic were approved. The executable reference version includes the final report fields, simpler conditional, and consistent formatting. It is a polished reference, not a claim that every polish change was submitted in the final learner attempt.

## Official references

- [Operators](https://dart.dev/language/operators)
- [Branches](https://dart.dev/language/branches)
- [Effective Dart](https://dart.dev/effective-dart)

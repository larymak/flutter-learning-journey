# Lesson 06 — Object-Oriented Programming in Dart

**Status:** Coding milestones complete; Final knowledge check: Passed. (October 29, 2026).

**Project:** [Developer Directory](exercises/developer_directory.dart)

## What I learned

- A class defines a blueprint; objects are individual instances with separate state.
- A constructor initializes fields, and `this.name` refers to the current object's field.
- Methods operate on an object's state. `++` increments a field; `+=` updates it by an amount.
- A leading underscore makes an identifier private to its Dart library, not strictly its class.
- A getter such as `int get completedProjects => _completedProjects;` provides public read access without a public setter.
- Validate incoming method parameters before updating fields: `if (amount > 0)`.
- `List<Developer>` holds Developer objects; `for (final developer in developers)` visits one object at a time.
- A directory-wide accumulator belongs outside the Developer class and before the loop.
- Use `developer.completedProjects` to read the getter and `${developers.length}` to interpolate a property expression.

## Project walkthrough

1. Construct Lary (4 projects), Alex (7), and Sam (2).
2. Call `completeProject()` on Lary, `addProjects(3)` on Alex, and `addProjects(-2)` on Sam.
3. The negative amount is ignored; updated counts are 5, 10, and 2.
4. Loop through the list, call `showProfile()` on each object, and accumulate project counts using the public getter.
5. Print the directory size (3) and total completed projects (17).

### Expected output

```text
=== DEVELOPER DIRECTORY REPORT ===
Developer: Lary
Completed projects: 5
Developer: Alex
Completed projects: 10
Developer: Sam
Completed projects: 2

Total developers: 3
Total completed projects: 17
================================
```

## Mistakes and lessons learned

- `completedProjects + amount` computes a value but does not update the field; use `+=`.
- Assigning the calculation to a new local variable also leaves the original field unchanged.
- Validate `amount > 0`, not the existing project count.
- Call `developer.showProfile()` on each object _inside_ the loop, not on the list or outside the loop.
- Place one-time object updates _before_ the reporting loop; otherwise they repeat for every developer.
- Accumulate `developer.completedProjects`, not the entire `developer` object.
- Use the public getter rather than accessing `_completedProjects` from reporting code.
- `${developers.length}` evaluates the property; `$developers.length` does not.

## Remaining limitation

The constructor still permits an initial negative project count. A future exercise can add constructor validation and test boundary cases.

## Final knowledge check — pending

Explain in your own words: (1) class versus object, (2) constructor and `this`, (3) private field and getter, (4) validation of incoming amounts, and (5) why the directory accumulator is outside the loop and uses the getter. Mark this section complete only after review.

## References

- [Dart classes](https://dart.dev/language/classes)
- [Dart constructors](https://dart.dev/language/constructors)
- [Dart libraries and imports](https://dart.dev/language/libraries)

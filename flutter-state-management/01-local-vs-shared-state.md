# Stage 3 — Lesson 1: Local vs. Shared State

**Status:** In progress  
**Milestone 1:** Completed — 3 exercises, **6/6**  
**Milestone 2:** In progress — Exercise 1 approved, **8/8**  
**Next exercise:** Milestone 2, Exercise 2 — **not started**  
**Learning method:** Explain → practice → review → correct → approve

## Learning objectives covered

- Distinguish **local state** from **shared state**.
- Identify which widgets actually need a given piece of state.
- Explain why a single source of truth helps keep views consistent.
- Choose an appropriate **state owner** in a simple widget tree.
- Understand **lifting state up** to a common ancestor.
- Pass a parent's value to a child via a **named constructor parameter**.
- Distinguish a constructor **declaration** from a constructor **call**.

## 1. Local state

Local state is information owned by a particular widget's `State` object, usually because only that widget (or its own subtree) needs it.

**Example: Follow / Following button.** If only one button needs to remember whether it was pressed, local state using `StatefulWidget` and `setState()` is sufficient.

```dart
bool isFollowing = false;

void toggleFollowing() {
  setState(() {
    isFollowing = !isFollowing;
  });
}
```

A widget can then choose its label from the current value:

```dart
Text(isFollowing ? 'Following' : 'Follow')
```

`setState()` notifies Flutter that the State changed and schedules a rebuild. It does **not** mean that the data is automatically stored persistently or shared globally.

## 2. Shared state: one consistent source of truth

Shared state matters when multiple widgets or screens need the same information.

**Example: To-Do Manager**

- `TasksScreen` lets users complete tasks.
- `Dashboard` shows completed and pending counts.
- Marking a task complete must also update the Dashboard.

If the two screens independently track unrelated copies of the count or task list, they may disagree. Instead, both should use one consistent source of task state.

```text
       Shared task state
             |
      +------+------+
      |             |
  Tasks screen   Dashboard
  edits tasks    shows totals
```

Shared state does **not** automatically require a library such as Provider, Riverpod, or Bloc. A common parent can often own the data and pass it to children; a dedicated state-management solution becomes useful as an application grows in complexity.

## 3. State ownership and lifting state up

When two child widgets depend on the same data, a straightforward solution is to place the state at their **lowest practical common ancestor**.

**Shopping cart example:**

```text
          ShoppingPage
          owns cartCount
           /       \
          /         \
    ProductList   CartBadge
    adds items    shows count
```

Possible data flow:

1. `ShoppingPage` owns the cart value and an update function.
2. `ProductList` receives a callback for adding an item.
3. When the callback runs, `ShoppingPage` changes its state.
4. `CartBadge` receives the updated count from its parent and rebuilds with the new value.

This pattern is called **lifting state up**. It avoids two unrelated copies of the same count. It is an ownership and communication pattern, not a requirement to use an external state-management package.

### Milestone 1 result

| Exercise  | Concept                               |   Score |
| --------- | ------------------------------------- | ------: |
| 1         | Recognize local state                 |     2/2 |
| 2         | Recognize shared state                |     2/2 |
| 3         | Choose a common parent as state owner |     2/2 |
| **Total** | **Milestone 1 approved**              | **6/6** |

## 4. Passing state from parent to child with a constructor

A child can receive a current value through a constructor argument rather than maintaining a duplicate copy of that state.

For example, this widget displays a task count provided by its parent:

```dart
class TaskCount extends StatelessWidget {
  const TaskCount({
    super.key,
    required this.completedTasks,
  });

  final int completedTasks;

  @override
  Widget build(BuildContext context) {
    return Text('Completed: $completedTasks');
  }
}
```

- `final int completedTasks;` declares the widget's configuration field.
- `required this.completedTasks` defines a required named constructor parameter that initializes the field.
- `Text(...)` uses the received value.

The parent owns an integer named `completedTasks`:

```dart
int completedTasks = 5;
```

The parent creates the child with this **widget creation expression**:

```dart
TaskCount(
  completedTasks: completedTasks,
)
```

The **left-hand** `completedTasks:` is the constructor's named argument; the **right-hand** `completedTasks` is the variable in the parent's scope. This is not a hardcoded `5`.

If the parent later rebuilds and supplies a different count, the child's displayed count can update. Passing values to children is one-way data flow; editing a parent's value from a child requires an appropriate callback or another state-management mechanism.

### Constructor declaration versus constructor call

**Declaration (inside the widget's class)** specifies what is required:

```dart
const TaskCount({
  super.key,
  required this.completedTasks,
});
```

**Call / creation expression (in the parent widget tree)** supplies the value:

```dart
TaskCount(
  completedTasks: completedTasks,
)
```

A complete standalone statement would end with a semicolon, while a widget expression passed as an argument generally uses a comma according to the enclosing syntax.

## 5. Exercise review and corrections — Milestone 2, Exercise 1

The task was to create `TaskCount` and pass the parent's `completedTasks` variable through the required named argument.

**Approved solution:**

```dart
TaskCount(
  completedTasks: completedTasks,
)
```

## 6. Key takeaways

1. Keep state local if no other part of the app needs it.
2. When several widgets use the same information, choose one consistent source of truth.
3. A common ancestor can own state and pass data down to children.
4. Lifting state up is an architectural technique, not a specific package.
5. A child receives a value using a constructor's named parameter.
6. `required this.field` **defines** a constructor parameter; `field: value` **supplies** it when creating an instance.
7. Dart widget constructor calls use parentheses. Arguments use commas, not semicolons.
8. Choosing where data lives comes before choosing Provider, Riverpod, or Bloc.

## 7. Current progress

| Stage / lesson     | Milestone or exercise                                         | Status             |
| ------------------ | ------------------------------------------------------------- | ------------------ |
| Stage 3 / Lesson 1 | Milestone 1 — State ownership                                 | **Approved (6/6)** |
| Stage 3 / Lesson 1 | Milestone 2, Exercise 1 — Pass a parent's variable to a child | **Approved (8/8)** |
| Stage 3 / Lesson 1 | Milestone 2, Exercise 2                                       | **Not started**    |
| Stage 3            | Lesson 1 overall                                              | **In progress**    |
| Stage 3            | All 6 lessons                                                 | **0/6 completed**  |

**Next action:** Begin Milestone 2, Exercise 2 only when explicitly requested. Do not mark Lesson 1 complete yet.

## References

- [Flutter: State management approaches](https://docs.flutter.dev/data-and-backend/state-mgmt/options)
- [Flutter: Passing data to a new screen](https://docs.flutter.dev/cookbook/navigation/passing-data)
- [Flutter: State.setState](https://api.flutter.dev/flutter/widgets/State/setState.html)
- [Dart: Constructors](https://dart.dev/language/constructors)

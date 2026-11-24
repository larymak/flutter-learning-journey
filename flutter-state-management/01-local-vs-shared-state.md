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

## 6. Passing callbacks from parent to child — Milestone 2

A child can request a change to its parent's state **without owning a separate state copy**. The parent owns the data and update method, then passes a function reference to the child.

### Parent method and callback

```dart
int cartCount = 0;

void _addToCart() {
  setState(() {
    cartCount++;
  });
}
```

The parent creates the child:

```dart
AddToCartButton(
  onAdd: _addToCart,
)
```

`_addToCart` is a function **reference**. `_addToCart()` would invoke the function immediately. A Flutter `VoidCallback` is a function with no positional arguments and no return value.

### Child widget

```dart
class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAdd,
      child: const Text('Add to Cart'),
    );
  }
}
```

The child receives `onAdd`, assigns it as the button's `onPressed`, and invokes it **when pressed**. `ShoppingPage` remains responsible for the state update and subsequent rebuild.

## 7. Combining data and callbacks — Milestone 2

A single child widget can both **display parent-supplied data** and **request a parent-owned state update**:

```dart
class CartControls extends StatelessWidget {
  const CartControls({
    super.key,
    required this.cartCount,
    required this.onAdd,
  });

  final int cartCount;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Cart: $cartCount items'),
        ElevatedButton(
          onPressed: onAdd,
          child: const Text('Add to Cart'),
        ),
      ],
    );
  }
}
```

The parent provides the value and function:

```dart
CartControls(
  cartCount: cartCount,
  onAdd: _addToCart,
)
```

### Direction of communication

1. The parent passes `cartCount` and the `_addToCart` callback **down** through the child's constructor.
2. The child displays the received count and **invokes** `onAdd` when the button is pressed.
3. The parent's `_addToCart()` method updates `cartCount` inside `setState()`.
4. The parent rebuilds and supplies the new count to the child.

Starting with `cartCount = 2`, one press displays **Cart: 3 items**.

### Milestone 2 result

| Exercise  | Concept                                               |     Score |
| --------- | ----------------------------------------------------- | --------: |
| 1         | Pass an integer through a named constructor parameter |       8/8 |
| 2A        | Pass a parent method reference as a callback          |       7/7 |
| 2B        | Connect received callback to `onPressed`              |       5/5 |
| 3A        | Pass both current data and callback                   |       8/8 |
| 3B        | Explain complete parent-child update sequence         |       3/3 |
| **Total** | **Milestone 2 approved**                              | **31/31** |

## 8. Duplicated state and consistency — Milestone 3, Exercise 1

When two widgets each own a separate copy of data that should describe the same thing, they can become inconsistent. For example, `ProfileHeader` and `ProfileEditor` each storing `developerName = 'Lary'` can disagree after the editor changes its independent copy to `Alex`.

A simple solution is to let their common ancestor own `developerName` and send the current value to the header plus an update callback to the editor:

```dart
// Illustrative parent State fields and method
String developerName = 'Lary';

void _updateDeveloperName(String newName) {
  setState(() {
    developerName = newName;
  });
}
```

The parent passes `developerName` down and lets the editor request an update via `_updateDeveloperName`. The **child does not mutate parent-owned state directly**.

## 9. Derived state — Milestone 3, Exercise 2

Often, a count is a **derived value** of more fundamental data. If the task list is authoritative, the number of completed tasks can be calculated from it instead of maintained as a second mutable counter:

```dart
List<bool> completedTasks = [true, false, false, true];

int completedCount =
    completedTasks.where((done) => done).length;
```

When the second task becomes complete:

```dart
completedTasks[1] = true;
// List is now [true, true, false, true]
// Recomputing completedCount gives 3.
```

For a Flutter screen whose build method reads this authoritative task list, calculate the completed count when building (or in another reactive derivation) rather than storing it as an unrelated mutable field. The summary stays consistent when the source data changes and the UI rebuilds.

In a more realistic To-Do app, the task objects and their completed flags—not just a stand-alone integer—should be the source of truth.

### Milestone 3 status

| Exercise | Topic                        | Status          |
| -------- | ---------------------------- | --------------- |
| 1        | Recognizing duplicated state | Approved — 3/3  |
| 2        | Derived state                | Approved — 3/3  |
| 3        | Next exercise                | **Not started** |

Milestone 3 is **in progress**, with 6/6 assessed answers correct so far. It has not been marked complete.

## 10. Key takeaways

1. Keep state local if no other part of the app needs it.
2. When several widgets use the same information, choose one consistent source of truth.
3. A common ancestor can own state and pass data down to children.
4. Lifting state up is an architectural technique, not a specific package.
5. A child receives a value using a constructor's named parameter.
6. `required this.field` **defines** a constructor parameter; `field: value` **supplies** it when creating an instance.
7. Dart widget constructor calls use parentheses. Arguments use commas, not semicolons.
8. Choosing where data lives comes before choosing Provider, Riverpod, or Bloc.
9. Passing a function reference (`onAdd: _addToCart`) is different from invoking the function immediately (`_addToCart()`).
10. A child calls a parent-supplied callback, while the parent remains the state owner.
11. Do not maintain independent copies of identical state in different widgets if one source can serve them.
12. Derive completed and pending counts from the task data when practical.

## 11. Current progress

| Stage / lesson                 | Milestone or exercise                      | Status                                  |
| ------------------------------ | ------------------------------------------ | --------------------------------------- |
| Stage 1 — Dart Fundamentals    | 8 lessons                                  | **Complete — 8/8**                      |
| Stage 2 — Flutter Fundamentals | 8 lessons                                  | **Complete — 8/8**                      |
| Stage 3 / Lesson 1             | Milestone 1 — State ownership              | **Approved — 6/6**                      |
| Stage 3 / Lesson 1             | Milestone 2 — Data and callbacks           | **Approved — 31/31**                    |
| Stage 3 / Lesson 1             | Milestone 3, Exercise 1 — Duplicated state | **Approved — 3/3**                      |
| Stage 3 / Lesson 1             | Milestone 3, Exercise 2 — Derived state    | **Approved — 3/3**                      |
| Stage 3 / Lesson 1             | Milestone 3, Exercise 3                    | **Not started**                         |
| Stage 3                        | Six planned lessons                        | **0/6 completed; Lesson 1 in progress** |

**Next action:** Milestone 3, Exercise 3, only when explicitly requested. Do not mark Lesson 1 complete or start another milestone based on documentation alone.

## References

- [Flutter: State management approaches](https://docs.flutter.dev/data-and-backend/state-mgmt/options)
- [Flutter: Passing data to a new screen](https://docs.flutter.dev/cookbook/navigation/passing-data)
- [Flutter: State.setState](https://api.flutter.dev/flutter/widgets/State/setState.html)
- [Dart: Constructors](https://dart.dev/language/constructors)
- [Flutter: VoidCallback API](https://api.flutter.dev/flutter/dart-ui/VoidCallback.html)
- [Dart: Iterable.where](https://api.dart.dev/dart-core/Iterable/where.html)

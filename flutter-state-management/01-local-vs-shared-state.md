# Lesson 01 — Local vs. Shared State

**Stage:** 3 — State Management  
**Prerequisites:** Dart lists and functions; Flutter `StatefulWidget`, `StatelessWidget`, constructors, and `setState()`.

[Exercise workbook](exercises/01-local-vs-shared-state.md) · [Separate solutions](solutions/01-local-vs-shared-state.md) · [Stage index](README.md)

## Learning objectives

By the end of this lesson, you should be able to determine where state belongs, pass data and callbacks across widgets, derive consistently filtered results, and create a searchable task list in an existing Flutter application.

## 1. What is state?

State is information that can change while an application is running and affect what is shown: a selected tab, the status of a Follow button, a shopping-cart count, or search text.

A `StatefulWidget` has a separate `State` object that can hold mutable state. Call `setState()` when changes should be reflected in the widget tree.

```dart
class FollowButton extends StatefulWidget {
  const FollowButton({super.key});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isFollowing = !isFollowing;
        });
      },
      child: Text(isFollowing ? 'Following' : 'Follow'),
    );
  }
}
```

**Rule:** Keep state local when only that widget needs to own and change the value.

## 2. State ownership and lifting state up

Imagine these sibling widgets:

```text
ToDoPage
├── TaskList
└── TaskSummary
```

If both must read the same list of tasks, give their **nearest common ancestor** (`ToDoPage`) ownership of the data and pass relevant values to the children. Independent copies risk disagreeing.

A `SearchBox` can keep a purely local input value if no other widget needs it. Once its query must control a sibling `TaskList`, the parent should own `searchQuery`.

**Decision questions:** Who reads the value? Who changes it? Which ancestor is closest to *all* widgets that depend on it? Sharing data does not automatically require global state.

## 3. Pass data down through constructor arguments

```dart
class TaskCount extends StatelessWidget {
  final int completedTasks;

  const TaskCount({super.key, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Text('Completed: $completedTasks');
  }
}

// In a parent's children list:
TaskCount(completedTasks: completedTasks),
```

`TaskCount` receives a value and displays it; it does not maintain another independent count.

## 4. Send events up through callbacks

Two common callback types are:

| Type | Signature | Example |
| --- | --- | --- |
| `VoidCallback` | No arguments, returns `void` | Add item, increment counter |
| `ValueChanged<String>` | One `String` argument, returns `void` | Report changed search text |

```dart
class AddToCartButton extends StatelessWidget {
  final VoidCallback onAdd;

  const AddToCartButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAdd,
      child: const Text('Add to cart'),
    );
  }
}
```

Pass a **reference** such as `onPressed: onAdd`, not a method call like `onPressed: onAdd()`. The callback should execute when the event occurs, not while the widget is being built.

A text-change callback uses the same principle:

```dart
class SearchBox extends StatelessWidget {
  final ValueChanged<String> onQueryChanged;

  const SearchBox({super.key, required this.onQueryChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(onChanged: onQueryChanged);
  }
}
```

The parent supplies `SearchBox(onQueryChanged: _updateSearch)`; `TextField` reports new text by calling that supplied function.

## 5. Avoid duplicated state: derive values

Store the original data once and calculate dependent values from it.

```dart
final completedTasks = <bool>[true, false, true, false];

final totalTasks = completedTasks.length;
final completedCount = completedTasks.where((done) => done).length;
final pendingCount = totalTasks - completedCount;
```

`completedCount` and `pendingCount` are **derived values**. Recalculate them when the source changes, rather than storing three unrelated mutable counters. A calculation only runs when your code executes it; in a Flutter UI, derive current values in `build()` or a suitable getter.

## 6. Filter lists without changing the original

```dart
final tasks = <String>[
  'Learn Dart',
  'Practice Flutter',
  'Write Documentation',
  'Build Flutter App',
];
final searchQuery = 'flutter';

final filteredTasks = tasks
    .where(
      (task) => task.toLowerCase().contains(searchQuery.toLowerCase()),
    )
    .toList();
```

- `where()` selects matching elements and returns an `Iterable`.
- `toList()` creates a `List` containing those matches.
- Lowercasing both sides makes matching case-insensitive.
- The original `tasks` list is unchanged.

For `'flutter'`, the results are **Practice Flutter** and **Build Flutter App**.

### Clearing the search

Every Dart string contains the empty string: `'Learn Dart'.contains('')` is `true`. Therefore, when `searchQuery == ''`, all four original tasks match. Clearing a filter is not the same as deleting tasks.

## 7. Building the shared-state flow

```text
SearchBox → onQueryChanged(newQuery)
          → ToDoPage._updateSearch(newQuery)
          → setState() updates searchQuery
          → ToDoPage.build() derives filteredTasks
          → TaskList receives filteredTasks
          → ListView.builder displays rows
```

The parent owns `tasks` and `searchQuery`:

```dart
final List<String> tasks = [
  'Learn Dart',
  'Practice Flutter',
  'Write Documentation',
  'Build Flutter App',
];
String searchQuery = '';

void _updateSearch(String newQuery) {
  setState(() {
    searchQuery = newQuery;
  });
}
```

`build()` can derive `filteredTasks` and pass it to a child:

```dart
return Scaffold(
  body: Column(
    children: [
      SearchBox(onQueryChanged: _updateSearch),
      Expanded(child: TaskList(tasks: filteredTasks)),
    ],
  ),
);
```

`Expanded` gives the scrolling `ListView` bounded height within a `Column`. `TaskList` can remain stateless because it displays a list supplied by the parent. See the [complete example](solutions/01-local-vs-shared-state.md#exercise-10--build-the-to-do-manager).

## 8. Preserve existing screens through navigation

Keep the home screen and project screen; make the To-Do Manager another route. From `main.dart`:

```dart
import 'todo_page.dart';

// Inside the existing home screen's State class:
void _openToDoPage() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ToDoPage()),
  );
}
```

Then connect an `ElevatedButton` with `onPressed: _openToDoPage`. `Navigator.push()` opens a route while retaining the previous route in the navigation stack.

## 9. Project checks

From the Flutter project root (where `pubspec.yaml` lives):

```bash
flutter pub get
flutter analyze
flutter run -d chrome
```

Static analysis catches syntax, type, and lint issues; runtime checks establish whether navigation and filtering behave as expected. Test the default four-task view, the two matches for `flutter`, and the return to four after clearing the query.

Use `debugPrint()` for development logging when the `avoid_print` lint applies. For imports, follow the installed Flutter SDK and project dependencies: some versions use `package:flutter/material.dart`, while environments using the installed standalone Material UI package may use `package:material_ui/material_ui.dart`.

## Review questions

1. When should a value remain local?
2. Where should shared task data live if both a task list and summary need it?
3. How are values passed down, and how are events passed up?
4. Why does `onPressed: callback` differ from `onPressed: callback()`?
5. Why is `filteredTasks` derived instead of independently stored?
6. What happens when the search query becomes an empty string?

**Continue:** [Exercise workbook](exercises/01-local-vs-shared-state.md).

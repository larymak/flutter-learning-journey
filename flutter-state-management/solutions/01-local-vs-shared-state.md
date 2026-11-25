# Lesson 01 — Local vs. Shared State: Solution Guide

[Notes](../01-local-vs-shared-state.md) · [Exercises](../exercises/01-local-vs-shared-state.md) · [Stage index](../README.md)

**Recommended approach:** Attempt the matching exercise before viewing each solution. These are reference implementations; equivalent valid Dart approaches are acceptable when the required behavior is preserved.

## Exercise 1 — Decide who owns the state

- **Follow/Following:** `FollowButton` owns its local Boolean because no other widget needs it.
- **Shared tasks:** `ToDoPage` owns the list because `TaskList` and `TaskSummary` are siblings using the same data.
- **Cart count:** `ShoppingPage` owns the cart count because `ProductList` changes it and `CartBadge` displays it.

**Principle:** Put shared state in the closest ancestor of every widget that needs it.

[Back to Exercise 1](../exercises/01-local-vs-shared-state.md#exercise-1--decide-who-owns-the-state)

## Exercise 2 — Pass values down

```dart
class TaskCount extends StatelessWidget {
  final int completedTasks;

  const TaskCount({super.key, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Text('Completed: $completedTasks');
  }
}

// Inside the parent's widget tree:
TaskCount(completedTasks: completedTasks),
```

The parent supplies the current count; the child renders it.

[Back to Exercise 2](../exercises/01-local-vs-shared-state.md#exercise-2--pass-values-down)

## Exercise 3 — Send a no-argument callback up

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

// Inside a parent widget tree:
AddToCartButton(onAdd: _addToCart),
```

The parent defines `_addToCart()` and changes its own state. `onAdd` is a function reference, not an immediate call.

[Back to Exercise 3](../exercises/01-local-vs-shared-state.md#exercise-3--send-a-no-argument-callback-up)

## Exercise 4 — Derive task statistics

```dart
final completedTasks = <bool>[true, false, true, false];
final totalTasks = completedTasks.length;
final completedCount = completedTasks.where((done) => done).length;
final pendingCount = totalTasks - completedCount;
```

Expected values: **total 4, completed 2, pending 2**. Deriving counts prevents separate mutable counters from getting out of sync.

[Back to Exercise 4](../exercises/01-local-vs-shared-state.md#exercise-4--derive-task-statistics)

## Exercise 5 — Change the state owner

1. Initially, `SearchBox` may own its input if only that widget uses it.
2. Once the search filters the sibling `TaskList`, move `searchQuery` to `ToDoPage`.
3. `SearchBox` uses `ValueChanged<String>` to report edited text upward.
4. `ToDoPage` derives `filteredTasks` and passes that list down to `TaskList`.

```text
ToDoPage (owns tasks and searchQuery)
├── SearchBox → sends query through callback
└── TaskList ← receives filtered tasks
```

[Back to Exercise 5](../exercises/01-local-vs-shared-state.md#exercise-5--change-the-state-owner)

## Exercise 6 — Define and connect a text callback

```dart
class SearchBox extends StatelessWidget {
  final ValueChanged<String> onQueryChanged;

  const SearchBox({super.key, required this.onQueryChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(onChanged: onQueryChanged);
  }
}

// Inside parent build():
SearchBox(onQueryChanged: _updateSearch),
```

`ValueChanged<String>` accepts one String and returns void. The child passes the callback to `TextField` rather than invoking it during build.

[Back to Exercise 6](../exercises/01-local-vs-shared-state.md#exercise-6--define-and-connect-a-text-callback)

## Exercise 7 — Update parent-owned search state

Inside `_ToDoPageState`:

```dart
String searchQuery = '';

void _updateSearch(String newQuery) {
  setState(() {
    searchQuery = newQuery;
  });
}
```

`setState()` schedules a rebuild so filtering can use the latest query.

[Back to Exercise 7](../exercises/01-local-vs-shared-state.md#exercise-7--update-parent-owned-search-state)

## Exercise 8 — Filter tasks case-insensitively

```dart
final filteredTasks = tasks
    .where((task) =>
        task.toLowerCase().contains(searchQuery.toLowerCase()))
    .toList();
```

Expected results:

| Search query | Matching tasks | Count |
| --- | --- | ---: |
| `flutter` | Practice Flutter; Build Flutter App | 2 |
| `DART` | Learn Dart | 1 |
| `xyz` | None | 0 |
| `''` | All original tasks | 4 |

`where()` does not remove elements from the original list. Every String contains the empty String, so the empty query matches all items.

[Back to Exercise 8](../exercises/01-local-vs-shared-state.md#exercise-8--filter-tasks-case-insensitively)

## Exercise 9 — Render a received task list

```dart
class TaskList extends StatelessWidget {
  final List<String> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(tasks[index]));
      },
    );
  }
}
```

`TaskList` renders the list it receives; its parent controls which tasks are included.

[Back to Exercise 9](../exercises/01-local-vs-shared-state.md#exercise-9--render-a-received-task-list)

## Exercise 10 — Build the To-Do Manager

Create `lib/todo_page.dart` with this complete example. Use the Material import supported by your project. For a Flutter project using the installed standalone `material_ui` package, use:

```dart
import 'package:material_ui/material_ui.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
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

  @override
  Widget build(BuildContext context) {
    final filteredTasks = tasks
        .where(
          (task) => task
              .toLowerCase()
              .contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      body: Column(
        children: [
          SearchBox(onQueryChanged: _updateSearch),
          Expanded(child: TaskList(tasks: filteredTasks)),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onQueryChanged;

  const SearchBox({super.key, required this.onQueryChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(onChanged: onQueryChanged);
  }
}

class TaskList extends StatelessWidget {
  final List<String> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(tasks[index]));
      },
    );
  }
}
```

The parent owns two state fields; `SearchBox` sends edits to the parent; `TaskList` receives derived display data. `Expanded` prevents an unbounded-height `ListView` within the `Column`. In SDKs using the built-in Material library, the import may instead be `package:flutter/material.dart`.

[Back to Exercise 10](../exercises/01-local-vs-shared-state.md#exercise-10--build-the-to-do-manager)

## Exercise 11 — Add navigation without replacing existing screens

In `lib/main.dart`, retain the existing app and add a local import:

```dart
import 'todo_page.dart';
```

Inside the existing `_MyHomePageState`:

```dart
void _openToDoPage() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ToDoPage(),
    ),
  );
}
```

Immediately after the existing **View My Projects** button in its `children` list:

```dart
ElevatedButton(
  onPressed: _openToDoPage,
  child: const Text('Open To-Do Manager'),
),
```

The previous home and Projects screens remain available. Passing `_openToDoPage` (without parentheses) lets Flutter invoke it on tap.

[Back to Exercise 11](../exercises/01-local-vs-shared-state.md#exercise-11--add-navigation-without-replacing-the-existing-app)

## Exercise 12 — Analyze and validate the app

From `flutter-fundamentals/hello_flutter`:

```bash
flutter pub get
flutter analyze
flutter run -d chrome
```

Expected behavior:

1. **Open To-Do Manager** navigates to the search screen.
2. Empty search shows four original tasks.
3. Searching for `flutter` shows **Practice Flutter** and **Build Flutter App**.
4. Clearing the text restores the original four tasks.
5. The existing **View My Projects** button continues to open its screen.

For a Dart lint about `print()` calls, consider `debugPrint('message')` for development logging. Only change imports or dependencies when your specific analyzer messages and SDK versions require it. Static analysis and runtime verification answer different questions; do both.

[Back to Exercise 12](../exercises/01-local-vs-shared-state.md#exercise-12--analyze-and-validate-the-app)

## Stretch challenge — Matching task summary

Keep the count derived from `filteredTasks.length` and pass it down:

```dart
class MatchingTaskSummary extends StatelessWidget {
  final int matchingCount;

  const MatchingTaskSummary({
    super.key,
    required this.matchingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Matching tasks: $matchingCount');
  }
}

// Add inside ToDoPage's Column, after SearchBox:
MatchingTaskSummary(matchingCount: filteredTasks.length),
```

This displays the count of *currently matching* tasks. It does not create a separately updated State variable.

[Back to the stretch challenge](../exercises/01-local-vs-shared-state.md#stretch-challenge-optional)

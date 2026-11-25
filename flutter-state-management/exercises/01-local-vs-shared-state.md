# Lesson 01 — Local vs. Shared State: Practice Workbook

[Concept notes](../01-local-vs-shared-state.md) · [Solution guide](../solutions/01-local-vs-shared-state.md) · [Stage 3 index](../README.md)

**Instructions:** Work through each exercise before opening its solution. Write answers in a notebook or your own Dart files. The questions intentionally do not provide complete answers. For the final project, use `flutter-fundamentals/hello_flutter` and preserve all existing screens.

## Exercise 1 — Decide who owns the state

Consider these widget trees:

```text
A. ProfilePage → FollowButton
B. ToDoPage → TaskList + TaskSummary
C. ShoppingPage → ProductList + CartBadge
```

For each case, decide which widget should own the changing value and explain **why**:

1. A Follow/Following Boolean used only by the button.
2. A task list used by both `TaskList` and `TaskSummary`.
3. A cart item count shown in `CartBadge` and updated by `ProductList`.

**Acceptance criteria:** Identify the smallest appropriate owner for each case; explain the nearest-common-ancestor rule.

[View solution for Exercise 1](../solutions/01-local-vs-shared-state.md#exercise-1--decide-who-owns-the-state)

## Exercise 2 — Pass values down

Create a `TaskCount` stateless widget that receives a required `int completedTasks` and displays `Completed: N`. Show how its parent passes an existing `completedTasks` variable into it.

**Acceptance criteria:** Typed `final` field, required constructor argument, `Text` output, and a correctly named parent argument.

[View solution for Exercise 2](../solutions/01-local-vs-shared-state.md#exercise-2--pass-values-down)

## Exercise 3 — Send a no-argument callback up

Create a stateless `AddToCartButton` with a required `VoidCallback onAdd`. Its button should call the parent's function when tapped. Then show how a parent passes an existing `_addToCart` method to it.

**Acceptance criteria:** Pass the callback *reference*, not a function call; the parent remains responsible for state updates.

[View solution for Exercise 3](../solutions/01-local-vs-shared-state.md#exercise-3--send-a-no-argument-callback-up)

## Exercise 4 — Derive task statistics

Given:

```dart
final completedTasks = <bool>[true, false, true, false];
```

Calculate `totalTasks`, `completedCount`, and `pendingCount` without declaring three independently maintained State fields. Write the resulting numbers.

**Acceptance criteria:** Use list length, `where()`, and subtraction; explain why counts should be derived from the source list.

[View solution for Exercise 4](../solutions/01-local-vs-shared-state.md#exercise-4--derive-task-statistics)

## Exercise 5 — Change the state owner when requirements change

Initially `SearchBox` is the only widget using its text. Then the product requirement changes: typing in `SearchBox` must filter a sibling `TaskList`.

1. Where should `searchQuery` live before the change?
2. Where should it live afterward?
3. How should the child report new text to the parent?
4. What does the parent pass to the list?

**Acceptance criteria:** Correct state owner before and after, callback-based upward event, and downward filtered data flow.

[View solution for Exercise 5](../solutions/01-local-vs-shared-state.md#exercise-5--change-the-state-owner)

## Exercise 6 — Define and connect a text callback

Create a `SearchBox` extending `StatelessWidget`. It should expose a required `ValueChanged<String> onQueryChanged`, have a `const` constructor, and return a `TextField` that reports input changes. Then show how a parent passes `_updateSearch` into `SearchBox`.

**Acceptance criteria:** Correct callback type and constructor; no premature callback invocation.

[View solution for Exercise 6](../solutions/01-local-vs-shared-state.md#exercise-6--define-and-connect-a-text-callback)

## Exercise 7 — Update parent-owned search state

In a parent State class, declare an initially empty `String searchQuery`. Implement `void _updateSearch(String newQuery)` to update it when the child reports new text.

**Acceptance criteria:** State is owned by parent; `setState()` encloses the assignment; parameter and method signatures match.

[View solution for Exercise 7](../solutions/01-local-vs-shared-state.md#exercise-7--update-parent-owned-search-state)

## Exercise 8 — Filter tasks case-insensitively

Given:

```dart
final tasks = <String>[
  'Learn Dart',
  'Practice Flutter',
  'Write Documentation',
  'Build Flutter App',
];
```

Write an expression that creates `filteredTasks` using the current `searchQuery`. It must ignore letter case and must not remove elements from `tasks`.

Predict the results for the queries `flutter`, `DART`, `xyz`, and the empty string `''`.

**Acceptance criteria:** `where()`, `contains()`, `toLowerCase()` on both sides, `toList()`, and accurate result counts including an empty query.

[View solution for Exercise 8](../solutions/01-local-vs-shared-state.md#exercise-8--filter-tasks-case-insensitively)

## Exercise 9 — Render a received task list

Create `TaskList` as a `StatelessWidget` with a required `List<String> tasks`. Use `ListView.builder` with one `ListTile` per received task. The title should show the indexed task name.

**Acceptance criteria:** `itemCount: tasks.length`, correct `itemBuilder` indexing, and no filtering or shared search state inside `TaskList`.

[View solution for Exercise 9](../solutions/01-local-vs-shared-state.md#exercise-9--render-a-received-task-list)

## Exercise 10 — Build the To-Do Manager

Create `lib/todo_page.dart` inside the existing Flutter application. Combine the widgets from earlier exercises:

- `ToDoPage` is a `StatefulWidget` with `_ToDoPageState`.
- The parent owns four task strings and an initially empty search query.
- The parent updates the query via a callback and derives filtered tasks in `build()`.
- A `Scaffold` contains a `Column` with `SearchBox` followed by `Expanded(child: TaskList(...))`.
- Keep both child widgets independent of the parent's State class.

**Acceptance criteria:** The parent is the source of truth; children have typed constructor contracts; filtered results change when search text changes.

[View solution for Exercise 10](../solutions/01-local-vs-shared-state.md#exercise-10--build-the-to-do-manager)

## Exercise 11 — Add navigation without replacing the existing app

In the existing `main.dart`, retain `MyHomePage`, `ProjectsScreen`, the developer profile, and existing navigation. Import the new To-Do page. Add a `_openToDoPage()` method in `_MyHomePageState` that uses `Navigator.push()` and a `MaterialPageRoute` returning `const ToDoPage()`. Add an `ElevatedButton` labeled **Open To-Do Manager** below the existing **View My Projects** button.

**Acceptance criteria:** Both destination screens remain reachable; the new button passes the method reference; existing app features stay intact.

[View solution for Exercise 11](../solutions/01-local-vs-shared-state.md#exercise-11--add-navigation-without-replacing-existing-screens)

## Exercise 12 — Analyze and validate the app

In the directory containing your Flutter app's `pubspec.yaml`, run static analysis and start the web app. Check the following behavior:

| Action | Expected behavior |
| --- | --- |
| Tap Open To-Do Manager | To-Do screen opens |
| Leave search empty | Four tasks appear |
| Search `flutter` | Two tasks appear: Practice Flutter and Build Flutter App |
| Clear the search | All four original tasks reappear |
| Use existing View My Projects | Existing Projects screen remains accessible |

If the analyzer reports an informational lint, read the file path, line number, and lint rule before making a targeted change. Keep unrelated app behavior unchanged.

**Acceptance criteria:** No static analyzer issues, successful navigation, and expected filtered-list behavior.

[View solution for Exercise 12](../solutions/01-local-vs-shared-state.md#exercise-12--analyze-and-validate-the-app)

## Stretch challenge (optional)

Add a task-summary widget that displays the number of matching tasks, without creating an independent mutable count. Decide whether it should receive the original list or the filtered list, and explain your choice.

[View stretch solution](../solutions/01-local-vs-shared-state.md#stretch-challenge--matching-task-summary)

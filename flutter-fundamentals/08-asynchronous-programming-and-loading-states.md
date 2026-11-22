# Lesson 08 — Asynchronous Programming & Loading States

**Stage:** 2 — Flutter Fundamentals  
**Status:** Completed (all five milestones)  
**Final knowledge check:** 8/8 (learner-reported)  
**Capstone:** Asynchronous Project Manager in `hello_flutter`

## Learning objectives

By the end of this lesson, I can:

- Explain asynchronous work, `Future<T>`, `Future<void>`, and eventual completion or error.
- Use `async` and `await` to receive values without blocking Flutter's UI thread.
- Predict the execution order of an asynchronous function called without `await`.
- Chain dependent asynchronous operations.
- Handle an error from an awaited Future using `try-catch`.
- Maintain a Boolean loading state with `setState()`.
- Render a `CircularProgressIndicator` conditionally and disable a loading button.
- Check `mounted` after an asynchronous gap before calling `setState()`.
- Await `Future<List<String>>`, update a mutable list using `clear()` and `addAll()`, and display its contents through `ListView.builder`.

## Milestone 1 — Understanding Future

### 1.1 Future<void>, async, and await

A `Future<T>` represents an asynchronous operation that can later complete with a `T` value or an error. `Future<void>` represents completion without a useful value.

My first approved asynchronous exercise:

```dart
Future<void> loadProjects() async {
  await Future.delayed(
    const Duration(seconds: 2),
  );
  print('Projects loaded');
}
```

`Future.delayed` simulates an asynchronous operation, not an actual network request. `await` suspends the containing async function until the Future completes; it does not freeze Flutter's entire interface.

### 1.2 Execution order without awaiting the call

```dart
Future<void> loadProjects() async {
  print('Starting to load projects');
  await Future.delayed(const Duration(seconds: 2));
  print('Projects loaded');
}

void main() {
  print('App started');
  loadProjects();
  print('App is ready');
}
```

Expected output:

```text
App started
Starting to load projects
App is ready
Projects loaded
```

`main()` does not await `loadProjects()`. The async function starts running until it reaches its first unfinished `await`, at which point the caller can continue. I initially predicted that `Projects loaded` would print earlier, but corrected my reasoning and final ordering.

### 1.3 Returning an integer from a Future

```dart
Future<int> getProjectCount() async {
  await Future.delayed(const Duration(seconds: 1));
  return 3;
}
```

The returned `3` is a value available to the caller, whereas `print(3)` would only write to the console. The exercise reinforced matching required function names: `getProjectCount()` rather than `loadProjects()`.

**Milestone 1:** 3/3 exercises approved.

## Milestone 2 — Working with async and await

### 2.1 Await a result

```dart
Future<void> main() async {
  print('Checking projects...');
  int count = await getProjectCount();
  print('You have $count projects');
}
```

Here, `getProjectCount()` is a `Future<int>`, but `await getProjectCount()` yields the integer after successful completion. The output is `Checking projects...` followed by `You have 3 projects` after the one-second delay.

### 2.2 Sequential dependent operations

```dart
Future<String> getProjectStatus(int count) async {
  await Future.delayed(const Duration(seconds: 1));
  return 'You have $count projects';
}

Future<void> main() async {
  print('Loading project information...');
  int count = await getProjectCount();
  String status = await getProjectStatus(count);
  print(status);
}
```

The second Future needs the first Future's result. With one second of delay in each helper, the complete sequence takes approximately two seconds. The two operations are **sequential**, not parallel.

### 2.3 Handling failures with try-catch

The example helper completes with an error:

```dart
Future<int> getProjectCount() async {
  await Future.delayed(const Duration(seconds: 1));
  throw Exception('Failed to load projects');
}
```

My approved handling pattern:

```dart
Future<void> main() async {
  try {
    int count = await getProjectCount();
    print('You have $count projects');
  } catch (error) {
    print('Error: $error');
  }
}
```

When the Future completes with an error, the success `print()` is skipped and the `catch` block receives that error. Expected output: `Error: Exception: Failed to load projects`.

**Milestone 2:** 3/3 exercises approved.

## Milestone 3 — Loading States

### 3.1 State model

Inside `_ProjectsScreenState`:

```dart
bool isLoading = false;
```

The observed values are:

| Phase                         | `isLoading` | Meaning      |
| ----------------------------- | ----------- | ------------ |
| Before request                | `false`     | Ready        |
| During asynchronous operation | `true`      | Busy/loading |
| After normal completion       | `false`     | Ready again  |

I corrected an initial misunderstanding: after the final state update the value is `false`, not `true`. This is a class field, not a variable recreated in each `build()` call.

### 3.2 Set state around an asynchronous gap

```dart
Future<void> _loadProjects() async {
  setState(() {
    isLoading = true;
  });

  await Future.delayed(const Duration(seconds: 2));

  if (!mounted) return;

  setState(() {
    isLoading = false;
  });
}
```

This version illustrates simulated loading before adding actual returned list data in Milestone 4. It must live inside a `State` subclass.

`setState()` runs its callback synchronously and schedules a rebuild. We do not put the asynchronous wait inside the `setState` callback. The `mounted` check after `await` protects against calling `setState()` on a disposed State object if the user has navigated away.

### 3.3 Conditional UI with the ternary operator

Within the Projects screen's `Column`:

```dart
Expanded(
  child: isLoading
      ? const Center(child: CircularProgressIndicator())
      : ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.folder),
              title: Text(projects[index]),
              subtitle: const Text('Flutter learning project'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removeProject(index),
              ),
            );
          },
        ),
),
```

`isLoading ? trueWidget : falseWidget` chooses one of two widgets. The `Center` wrapper centers the progress indicator in the space given to `Expanded`. The existing `ListView.builder` remains available after loading finishes.

During practice I learned to use `Center(child: CircularProgressIndicator())` rather than placing two widget names next to each other without parentheses or a `child:` argument.

### 3.4 Disabling repeated loads

```dart
ElevatedButton(
  onPressed: isLoading ? null : _loadProjects,
  child: const Text('Load Projects'),
),
```

A button with `onPressed: null` is disabled. Passing `_loadProjects` (without parentheses) gives the button a callback to invoke later. The conditional callback prevents repeated clicks from starting overlapping loads via this button.

**Milestone 3:** Approved.

## Milestone 4 — Displaying Asynchronous Results

### 4.1 Return a list asynchronously

A Future can wrap a collection:

```dart
Future<List<String>> _fetchProjects() async {
  await Future.delayed(const Duration(seconds: 2));

  return ['Weather App', 'Task Manager', 'Portfolio Website'];
}
```

`Future<List<String>>` is the pending result; `await _fetchProjects()` yields a `List<String>` on success. Leading underscores in Dart make declarations private to their library.

### 4.2 Read the resulting data

```dart
Future<void> example() async {
  print('Fetching projects...');
  List<String> projects = await _fetchProjects();
  print('Total projects: ${projects.length}');
  print(projects[0]);
}
```

Expected output after the two-second await:

```text
Fetching projects...
Total projects: 3
Weather App
```

`projects.length` is the number of entries. `projects[0]` is the first String; indexing requires a nonempty list. I fixed an initially hardcoded total (`Total projects 3: ...`) and a missing semicolon in `print(projects[0]);`.

### 4.3 Replace the existing mutable list

The State field from Lesson 7 remains `final`:

```dart
final List<String> projects = List<String>.of(ProjectsScreen.projectNames);
```

The following changes the list's **contents**, not the `final` variable reference:

```dart
setState(() {
  projects.clear();
  projects.addAll(loadedProjects);
});
```

`clear()` removes all existing entries. `addAll()` adds the fetched entries in order. The resulting list replaces the previous items rather than appending to them.

### 4.4 Integrate fetching into the loading flow

The final approved source for `_ProjectsScreenState` uses a separate `_fetchProjects()` helper and this loading method:

```dart
Future<void> _loadProjects() async {
  setState(() {
    isLoading = true;
  });

  List<String> loadedProjects = await _fetchProjects();

  if (!mounted) return;

  setState(() {
    projects.clear();
    projects.addAll(loadedProjects);
    isLoading = false;
  });
}
```

The helper owns simulated data retrieval; `_loadProjects()` coordinates state and replaces visible data. This organization avoids two separate two-second delays.

**Milestone 4:** Approved.

The knowledge check covered:

1. `Future<List<String>>` and typed asynchronous return values.
2. How `await` suspends the containing function.
3. The type obtained by awaiting `_fetchProjects()`.
4. The purpose of `setState()`.
5. Setting `isLoading = false` after successful loading.
6. Disabling a button conditionally with `onPressed: null`.
7. Using `mounted` to avoid updates after disposal.
8. Replacing list contents with `clear()` followed by `addAll()`.

### Final widget architecture

```text
MyApp → MyHomePage (StatefulWidget)
  └── Profile UI, name editor, counters, navigation
       └── Navigator.push → ProjectsScreen (StatefulWidget)
            └── _ProjectsScreenState
                 ├── projects (mutable List<String> field)
                 ├── isLoading (bool field)
                 ├── _fetchProjects() → Future<List<String>>
                 ├── _loadProjects() → Future<void>
                 │    ├── setState(isLoading = true)
                 │    ├── await _fetchProjects()
                 │    ├── if (!mounted) return
                 │    └── setState(clear, addAll, isLoading = false)
                 ├── _addProject()
                 ├── _removeProject(int index)
                 └── build()
                      ├── Completed Projects label (passed-in count)
                      ├── Expanded → loader or ListView.builder
                      ├── Load Projects button
                      ├── Add Project button
                      └── Go Back button
```

### Runtime and design limitations

- **Simulated fetch:** `_fetchProjects()` returns local hardcoded data after a delay; it does not call a server.
- **No persistence:** Route-local edits are not stored after the Projects route is removed and recreated.
- **Separate counts:** `widget.completedProjects` is passed from the Profile screen; `projects.length` tracks editable list rows. These values are not synchronized.
- **Error behavior:** The final `_loadProjects()` assumes fetching succeeds. If `_fetchProjects()` throws, `isLoading` will remain true while the State remains mounted unless error handling resets it. A production implementation should handle exceptions and show an error or retry state, typically with `try/catch/finally` and a mounted check before updating UI state.
- **Lifecycle:** `mounted` protects state updates but does not cancel an outstanding operation.
- **Verification scope:** Chrome tests and final quiz were reported by the learner. This generated source was not independently compiled or tested in a Flutter runtime.

## Stage 2 completion record

Lessons **01–08 of Flutter Fundamentals: complete**. Stage 1 **Dart Fundamentals: 8/8 complete**. Combined progress: **16/16 lessons completed** across the first two stages. Stage 3 has not started.

## Retention prompts

- Explain why `await` does not freeze Flutter's UI.
- Predict console ordering when an async function is called without `await`.
- Explain why a `final List<String>` can be cleared and repopulated.
- Show why `isLoading` must be updated using `setState()` and why `mounted` is checked after `await`.
- Describe what happens to locally added projects after the Load Projects button successfully reloads the hardcoded fetched list.
- Explain how to add a user-visible error state if `_fetchProjects()` throws.

## References

- [Dart asynchronous programming](https://dart.dev/language/async)
- [Flutter setState API](https://api.flutter.dev/flutter/widgets/State/setState.html)
- [Flutter State.mounted API](https://api.flutter.dev/flutter/widgets/State/mounted.html)
- [Flutter CircularProgressIndicator API](https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html)
- [Flutter ListView API](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [Dart collections](https://dart.dev/language/collections)

**Next stage:** Stage 3 — not started; advancement requires an explicit request.

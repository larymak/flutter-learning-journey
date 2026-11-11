# Lesson 03 — Interactivity and State

**Stage:** 2 — Flutter Fundamentals  
**Status:** Completed  
**Knowledge check:** 6/6  
**Project:** Developer Project Tracker (`hello_flutter`)  
**Chrome testing:** 4/4 final interaction tests passed (learner-reported)

## Learning objectives

- Explain state in Flutter and the difference between `StatelessWidget` and `StatefulWidget`.
- Store changing values in a `State` object.
- Display state variables using Dart string interpolation.
- Update state using `setState()`.
- Connect `ElevatedButton` widgets to callbacks.
- Test increments, resets, and subsequent interactions in Chrome.

## 1. Understanding state

State is information used by a widget that can change while the application runs. In this project, the number of completed projects is state.

Previously, the profile card displayed a fixed value:

```dart
Text('4'),
```

We introduced an integer field in `_MyHomePageState`:

```dart
int completedProjects = 4;
```

## 2. StatefulWidget and State

A `StatelessWidget` has no associated mutable `State` object, though it can rebuild when its inputs or dependencies change. A `StatefulWidget` has a separate `State` object for information that can change over time.

```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
```

`createState()` creates the associated state object. The leading underscore in `_MyHomePageState` makes the class private to its Dart library.

## 3. Displaying state in the UI

```dart
Text('$completedProjects'),
```

String interpolation turns the integer's current value into text when the widget builds. Unlike `Text('4')`, the display is based on the variable rather than a fixed string.

## 4. setState() and changing data

```dart
void _incrementProjects() {
  setState(() {
    completedProjects++;
  });
}

void _resetProjects() {
  setState(() {
    completedProjects = 4;
  });
}
```

- `completedProjects++` increments by one.
- `completedProjects = 4` assigns a specific value.
- `setState()` executes its callback and tells Flutter to schedule a rebuild so the widget can display the latest value.
- `setState()` does not save data permanently. After restarting the app, the initial value is used again unless persistence is implemented.

## 5. Buttons and callbacks

```dart
ElevatedButton(
  onPressed: _incrementProjects,
  child: Text('Complete a Project'),
),
ElevatedButton(
  onPressed: _resetProjects,
  child: Text('Reset Projects'),
),
```

`onPressed` receives a callback, which Flutter executes when the button is pressed. Writing `onPressed: _incrementProjects` passes the method reference. Writing `_incrementProjects()` would call the method immediately instead.

## 6. Final project — Developer Project Tracker

Built on the Developer Profile Card from Lesson 2, the app shows the developer's name, role, avatar, and project count. Two buttons increment and reset that count. Both buttons update the same `completedProjects` field in `_MyHomePageState`.

**Source code:** [`hello_flutter/lib/main.dart`](hello_flutter/lib/main.dart)

### Interaction flow

1. User taps `Complete a Project` or `Reset Projects`.
2. `onPressed` calls the corresponding method.
3. The method updates `completedProjects` inside `setState()`.
4. Flutter rebuilds the affected widget.
5. `Text('$completedProjects')` shows the current count.

## 7. Chrome test results

| Test | Expected | Result |
| --- | ---: | --- |
| Open app | 4 | Passed |
| Press Complete a Project twice | 6 | Passed |
| Press Reset Projects | 4 | Passed |
| Press Complete a Project again | 5 | Passed |

Earlier increment-only tests (4 → 5 → 7) also passed. These results were reported after running the app in Chrome.

## 8. Milestones and assessment

1. Understanding State — approved.
2. StatefulWidget and displaying state — approved.
3. Updating state with `setState()` — approved.
4. Buttons and user interaction — approved, tested in Chrome.
5. Final project: reset method, button, and tests — approved.

**Final knowledge check:** 6/6 passed.

## 9. Lessons learned

- Keep mutable data in a `State` object when the widget owns that state.
- The widget tree is rebuilt from the latest state rather than manually editing text on screen.
- Passing a method reference to `onPressed` differs from invoking it immediately.
- Code review verifies structure, but running interaction tests verifies behavior.
- App state and persistent storage are different concepts.

## 10. Retention challenge

Rebuild a small counter from memory with increment and reset actions. Explain what `setState()` does, why `Text('$completedProjects')` changes, and why the value resets after an app restart.

## References

- [Flutter interactivity](https://docs.flutter.dev/ui/interactivity)
- [State.setState API](https://api.flutter.dev/flutter/widgets/State/setState.html)
- [ElevatedButton API](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)

**Next lesson:** Lesson 4 — not started.

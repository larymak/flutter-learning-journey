# Lesson 05 — Navigation and Multiple Screens

**Stage:** 2 — Flutter Fundamentals  
**Status:** Completed  
**Project:** Developer Portfolio App (`hello_flutter`)

## Learning objectives

By the end of this lesson, I can:

- Define a separate screen as a Flutter widget returning a `Scaffold`.
- Navigate forward with `Navigator.push()` and `MaterialPageRoute`.
- Return to the previous route with `Navigator.pop()`.
- Explain the Navigator route stack.
- Pass a value from a `StatefulWidget`'s `State` to a new screen through a constructor.
- Distinguish mutable local state from an immutable constructor property.
- Test navigation and data passing in Chrome.

## 1. Creating a second screen

A screen is a widget representing a page in the application. A `Scaffold` provides Material page structure (such as an app bar and body). Since the Projects screen has no mutable state of its own, it can extend `StatelessWidget`.

```dart
class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key, required this.completedProjects});

  final int completedProjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Projects')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Completed Projects: $completedProjects'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
```

The lesson began with a simpler `ProjectsScreen` that had only an `AppBar`. We added its body and its data property in later exercises.

## 2. Navigator and the route stack

A Navigator manages a stack of routes, similar to a stack data structure:

```text
Before pushing:          After pushing:        After popping:
                           ProjectsScreen
MyHomePage                MyHomePage            MyHomePage
```

- **Push:** add a new route on top; the previous route remains underneath.
- **Pop:** remove the top route; the previous route becomes visible again.

`Navigator.push` handles navigation; it does **not** need `setState()` to change the route.

## 3. Opening the Projects screen: Navigator.push()

Our navigation method belongs in `_MyHomePageState`:

```dart
void _openProjects() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProjectsScreen(
        completedProjects: completedProjects,
      ),
    ),
  );
}
```

- `Navigator.push(context, route)` adds a route to the Navigator associated with that context.
- `MaterialPageRoute` creates a Material-style page route.
- `builder: (context) => ...` provides the widget to render on that route.
- `ProjectsScreen(...)` constructs the destination widget.

The profile's button passes the method reference, rather than calling it during build:

```dart
ElevatedButton(
  onPressed: _openProjects,
  child: const Text('View My Projects'),
),
```

Writing `_openProjects()` inside `onPressed:` would invoke it immediately instead of passing the callback. The callback may be a method reference or an anonymous function with compatible parameters.

## 4. Returning: Navigator.pop()

The Projects screen's Go Back button executes:

```dart
ElevatedButton(
  onPressed: () {
    Navigator.pop(context);
  },
  child: const Text('Go Back'),
),
```

The anonymous function `() { ... }` runs **on tap**. `Navigator.pop(context)` removes the current route; it does not create another `MyHomePage` instance.

Because the existing Profile route remains mounted underneath the Projects route, the Profile's local state is normally preserved when the Projects route is popped.

## 5. Passing data through constructors

A destination widget can receive information as a constructor parameter:

```dart
class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({
    super.key,
    required this.completedProjects,
  });

  final int completedProjects;

  // build() follows.
}
```

`required` makes the named argument mandatory. `this.completedProjects` initializes the field, and `final` prevents it from being reassigned after construction.

The data handoff uses:

```dart
ProjectsScreen(completedProjects: completedProjects)
```

The **left** `completedProjects` is the destination constructor's named parameter. The **right** `completedProjects` is the source screen's state field.

Our profile's value is mutable:

```dart
int completedProjects = 4;
```

The destination screen receives an immutable **snapshot** of the value when it is constructed. Passing a number this way does not automatically synchronize future changes to that count between the screens.

## 6. Runtime values and const

The `ProjectsScreen` constructor can still be declared `const`, but we must not invoke it with `const` if `completedProjects` comes from mutable runtime state.

```dart
// Wrong when completedProjects is runtime state:
// const ProjectsScreen(completedProjects: completedProjects)

// Correct:
ProjectsScreen(completedProjects: completedProjects)
```

This builds on the `const` lessons from previous stages.

## 7. Widget composition in ProjectsScreen

The final screen includes:

```text
ProjectsScreen
└── Scaffold
    ├── AppBar
    │   └── Text('My Projects')
    └── Center
        └── Column
            ├── Text('Completed Projects: $completedProjects')
            └── ElevatedButton('Go Back')
```

`Center` accepts one `child`. When we needed both a counter label and a Go Back button, we used a `Column` inside `Center`, and put both widgets in the Column's `children` list.

## 8. Mistakes corrected during the lesson

1. **Missing `child:` in `Center`:** `Center(ElevatedButton(...))` was corrected to `Center(child: ElevatedButton(...))`.
2. **Unbalanced braces:** The first full `ProjectsScreen` submission was missing a final `}` to close the class; this was corrected.
3. **Temporarily uninitialized `final int` field:** Declaring the property before adding the constructor parameter caused an expected intermediate compiler error.
4. **Missing required argument:** Once the constructor required `completedProjects`, the old `const ProjectsScreen()` call had to be updated to pass a runtime value and drop `const` at that invocation.
5. **Layout nuance:** A Column inside Center may still position its own children near the top if it fills the available height; adding `mainAxisAlignment: MainAxisAlignment.center` centers the Column's children vertically.

## 9. Chrome verification

The learner reported that all these tests passed:

### Basic forward navigation (3/3)

- Developer Profile opened correctly.
- View My Projects opened `ProjectsScreen`.
- `My Projects` appeared without errors.

### Back navigation (4/4)

- Developer Profile opened.
- View My Projects opened the destination.
- Go Back returned to Developer Profile.
- Repeated navigation worked and profile information remained intact.

### Constructor data passing (4/4)

| Test                                           | Expected         | Result |
| ---------------------------------------------- | ---------------- | ------ |
| Open Projects from starting count              | 4                | Passed |
| Increment profile count twice, reopen Projects | 6                | Passed |
| Reset profile count, reopen Projects           | 4                | Passed |
| Return to Profile                              | Navigation works | Passed |

These results are from the learner's reported Chrome tests, not an independent test run of the packaged source.

## 10. Assessment and takeaways

**Coding milestones:** 5/5 completed.  
**Knowledge check:** 6/6 passed.  
**Project:** Developer Portfolio App — approved.

Key takeaways:

- A Flutter app can have multiple page widgets.
- Navigator uses a route stack; push opens and pop returns.
- `MaterialPageRoute` defines a Material-style route.
- Constructor parameters pass data to a destination widget.
- `final` widget properties are immutable after construction.
- Runtime state values are not compile-time constants.
- Constructor arguments transfer values at creation time, not a live subscription.
- Code review plus real browser testing catches both syntax and navigation errors.

## 11. Retention challenge

Without looking at the source, create a simple Details screen accepting a required `String title`, show it via `Navigator.push`, and return via a button calling `Navigator.pop`. Explain why its constructor can be `const` while the call might not be.

## References

- [Flutter navigation and routing](https://docs.flutter.dev/ui/navigation)
- [Navigator API](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
- [MaterialPageRoute API](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html)
- [StatelessWidget API](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html)

**Next lesson:** Lesson 6 — not started.

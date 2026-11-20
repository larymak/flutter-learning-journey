# Lesson 07 — Managing Lists with State

**Stage:** 2 — Flutter Fundamentals  
**Status:** Completed  
**Project:** Interactive Project Manager, `hello_flutter`

## Learning objectives

By the end of the lesson I can:

- Distinguish immutable `const` lists from mutable Dart lists and `final` references.
- Convert a `StatelessWidget` to a `StatefulWidget` with a separate State class.
- Create a mutable copy of existing list data with `List<String>.of(...)`.
- Add and remove list items with `.add()`, `.remove()` and `.removeAt()`.
- Call `setState()` when mutations should be reflected in the interface.
- Bind a `ListView.builder` to mutable state, and attach a Delete button to each `ListTile`.
- Correctly handle duplicate names by removing a selected list index.

## 1. Constant versus mutable lists

The starting project data from Lesson 6 was stored as a constant:

```dart
static const List<String> projectNames = [
  'Developer Profile Card',
  'Project Tracker',
  'Profile Editor',
];
```

A `const` list cannot be changed after creation. A regular list can be changed:

```dart
List<String> projects = [
  'Developer Profile Card',
  'Project Tracker',
  'Profile Editor',
];
```

**Correction made:** I initially wrote `String List<String> projects`, which is invalid because `List<String>` already specifies the full type.

## 2. Adding an item

```dart
projects.add('Portfolio App');
```

`.add()` appends the new value at the end. Lists permit duplicate values, so adding `Portfolio App` twice creates two entries. Updating a Dart list alone does not request a Flutter rebuild.

## 3. Converting ProjectsScreen to StatefulWidget

Previously `ProjectsScreen` extended `StatelessWidget` and contained its own `build()` method. I converted it so the widget stores configuration while a separate `State` object stores mutable data and builds the interface:

```dart
class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key, required this.completedProjects});

  final int completedProjects;

  static const List<String> projectNames = [
    'Developer Profile Card',
    'Project Tracker',
    'Profile Editor',
  ];

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    // The full Scaffold goes here.
    return Scaffold();
  }
}
```

`createState()` creates the associated State object. `_ProjectsScreenState` must be a separate class, not nested in the widget's class body. Intermediate code can have temporary compilation errors until the conversion is complete.

### Accessing widget properties and static data

Inside State, `completedProjects` still belongs to the widget. It is accessed through `widget.completedProjects`:

```dart
Text('Completed Projects: ${widget.completedProjects}')
```

The constant list is a static class field, so State can access it using `ProjectsScreen.projectNames`.

## 4. Copying into a mutable list owned by State

Inside `_ProjectsScreenState`:

```dart
final List<String> projects = List<String>.of(ProjectsScreen.projectNames);
```

`List.of` makes a new, growable list with the same starting values. `final` means the `projects` variable cannot be reassigned to a different list, but its current list's elements can still change:

```dart
projects.add('Portfolio App');         // Allowed
projects.remove('Project Tracker');   // Allowed
// projects = ['New'];                  // Not allowed: final variable
```

The mutable copy is separate from the constant starting list.

## 5. Updating state when adding projects

The approved method is:

```dart
void _addProject() {
  setState(() {
    projects.add('Portfolio App');
  });
}
```

`setState()` runs its callback and tells Flutter to schedule a rebuild. The button provides the method as a callback:

```dart
ElevatedButton(
  onPressed: _addProject,
  child: const Text('Add Project'),
)
```

Notice `onPressed: _addProject` does **not** include `()` because pressing the button should invoke the callback later.

### Binding the list to State

The ListView must read the mutable `projects` field, not the original `ProjectsScreen.projectNames` constant. Both `itemCount` and the item title must use the current list:

```dart
Expanded(
  child: ListView.builder(
    itemCount: projects.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: const Icon(Icons.folder),
        title: Text(projects[index]),
        subtitle: const Text('Flutter learning project'),
      );
    },
  ),
)
```

`Expanded` provides bounded space for the scrolling list in the Column. After `setState()`, the builder reads the latest number and values of the projects.

## 6. Removing by value

The first approach was:

```dart
void _removeProject(String projectName) {
  setState(() {
    projects.remove(projectName);
  });
}
```

`remove(value)` deletes the **first matching element** and returns a `bool` indicating whether a match was removed. This works for unique names but can remove the wrong row if duplicates exist.

## 7. Removing by index

`removeAt(index)` removes the element at a specific position and returns it. The index must be between zero and `projects.length - 1`; an invalid index causes `RangeError`.

I updated the method:

```dart
void _removeProject(int index) {
  setState(() {
    projects.removeAt(index);
  });
}
```

Each item now includes an `IconButton`:

```dart
trailing: IconButton(
  icon: const Icon(Icons.delete),
  onPressed: () => _removeProject(index),
),
```

The expression `index` is an integer identifying the selected position, while `projects[index]` returns the String name at that position. The callback delays calling `_removeProject()` until the Delete button is pressed and passes the correct type.

## 8. Final widget structure

```text
ProjectsScreen (StatefulWidget)
├── completedProjects (immutable constructor property)
├── projectNames (static const starting data)
└── createState()
    └── _ProjectsScreenState
        ├── projects (final reference to mutable list)
        ├── _addProject()
        ├── _removeProject(int index)
        └── build()
            └── Scaffold
                ├── AppBar
                └── Center → Column
                    ├── Text (widget.completedProjects)
                    ├── Expanded → ListView.builder → ListTile + Delete
                    ├── Add Project button
                    └── Go Back button
```

**Source code:** [`hello_flutter/lib/main.dart`](hello_flutter/lib/main.dart). This version retains earlier Profile, form validation, project-count, and navigation features.

**Important distinction:** `widget.completedProjects` is the value passed from the Profile route. `projects.length` is the number of editable list entries. They are independent and may differ; adding to this list does not update the Profile's number.

**Persistence limitation:** These project list changes exist only in the current State object. Opening a new Projects route after popping the old one creates a new list from the initial template. The lesson does not implement permanent storage.

## 9. Chrome testing and assessment

The learner reported passing these browser checks (not independently automated on the packaged source):

**Adding projects (4/4)**

1. Three initial projects appeared.
2. Pressing Add Project once created a fourth item.
3. Pressing again created a fifth item, including duplicate Portfolio App.
4. Go Back navigation continued to work.

**Removing by name (4/4)**

1. Three initial projects appeared.
2. Removing Project Tracker left the correct two projects.
3. Adding Portfolio App worked.
4. Removing Portfolio App and returning to Profile worked.

**Removing by index (4/4)**

1. Three initial projects appeared.
2. Two Add Project presses created two Portfolio App entries.
3. Deleting the second duplicate removed only the selected row.
4. Removing Project Tracker and returning to Profile worked.

**Final knowledge check:** 6/6 passed.

## 10. Errors and lessons learned

- Fixed `String List<String>` to `List<String>`.
- Learned why `StatefulWidget` uses a separate State class and a `createState()` override.
- Moved `build()` from `ProjectsScreen` to `_ProjectsScreenState`.
- Used `widget.completedProjects` and `ProjectsScreen.projectNames` correctly after the refactor.
- Changed `ListView.builder` from the constant list to the mutable list so updates became visible.
- Changed Delete callbacks from passing a String (`projects[index]`) to an integer (`index`) for `removeAt`.
- Understood the difference between changing data and telling Flutter to rebuild through `setState()`.

## 11. Retention exercise

Without looking at the solution, create a StatefulWidget with a list of three course names, an Add button, and a ListView with Delete icons. Make deletion target the selected index. Explain `final` versus `const`, and predict what happens after leaving and reopening the screen.

## References

- [Flutter state management](https://docs.flutter.dev/data-and-backend/state-mgmt)
- [State.setState API](https://api.flutter.dev/flutter/widgets/State/setState.html)
- [Flutter ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [Flutter ListTile](https://api.flutter.dev/flutter/material/ListTile-class.html)
- [Dart collections](https://dart.dev/language/collections)

**Next lesson:** Lesson 8 — not started at the time this lesson was finalized.

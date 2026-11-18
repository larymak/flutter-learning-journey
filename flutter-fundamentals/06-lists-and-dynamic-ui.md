# Lesson 06 — Lists and Dynamic UI

**Stage:** 2 — Flutter Fundamentals  
**Status:** Completed  
**Final knowledge check:** 6/6  
**Project:** Dynamic Projects List in `hello_flutter`  
**Testing:** ListView, ListView.builder, and ListTile Chrome checks passed (learner-reported)

## Learning objectives

After this lesson, I can:

- Define and read a typed Dart list of project names.
- Explain why `ListView` is useful for scrollable vertical content.
- Use `Expanded` to constrain the height of a ListView inside a bounded Column.
- Explain `itemCount`, `itemBuilder`, and zero-based `index` in `ListView.builder`.
- Generate widgets from a list instead of hardcoding them individually.
- Present each item with a `ListTile` containing an icon, title, and subtitle.
- Test the generated UI and navigation in Chrome.

## 1. Store project names in a Dart List

Inside `ProjectsScreen`:

```dart
static const List<String> projectNames = [
  'Developer Profile Card',
  'Project Tracker',
  'Profile Editor',
];
```

`List<String>` declares a collection whose elements are Strings. `static` makes the list a property of the class, rather than each widget instance. `const` makes the list immutable. Each entry has an index starting with 0.

| Index | Value |
| ---: | --- |
| 0 | Developer Profile Card |
| 1 | Project Tracker |
| 2 | Profile Editor |

`projectNames.length` returns 3. The **number of elements** is 3 even though the **largest valid index** is 2.

`projectNames` is an educational list of three named projects. It is separate from the `completedProjects` integer that comes from the Profile screen. The values are not automatically synchronized with each other.

## 2. ListView versus Column

A `Column` stacks children vertically without providing its own scrolling. A `ListView` provides a scrollable sequence of widgets.

Our initial exercise hardcoded three widgets:

```dart
ListView(
  children: [
    Text('Developer Profile Card'),
    Text('Project Tracker'),
    Text('Profile Editor'),
  ],
)
```

This is useful for learning, but tedious for large collections. A regular `ListView(children: [...])` receives its explicit child widgets rather than building the visible children on demand.

## 3. Why Expanded is necessary here

The Projects screen has a `Column` with a project count, list, and Go Back button. A vertical `ListView` inside a `Column` needs finite space along the vertical axis.

```dart
Column(
  children: [
    Text('Completed Projects: $completedProjects'),
    Expanded(
      child: ListView(
        children: [Text('Developer Profile Card')],
      ),
    ),
    ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Go Back'),
    ),
  ],
)
```

`Expanded` uses the remaining space within the bounded Column and supplies a finite height to the scrollable ListView. This is correct in the Projects screen's `Scaffold` body, but an `Expanded` inside a vertically unconstrained `SingleChildScrollView` can cause layout exceptions.

## 4. Generate items with ListView.builder

We replaced the hardcoded widgets with a builder:

```dart
Expanded(
  child: ListView.builder(
    itemCount: projectNames.length,
    itemBuilder: (context, index) {
      return Text(projectNames[index]);
    },
  ),
)
```

- `itemCount` declares the number of available list entries.
- `itemBuilder` is a callback receiving a `BuildContext` and requested index.
- `projectNames[index]` selects the matching String.
- `Text(...)` displays that String.
- Flutter builds children on demand instead of constructing every item in a single explicit `children` list.

### Common mistake: no returned widget

An early attempt had an empty callback:

```dart
itemBuilder: (context, index) {
},
```

The builder must return a Widget. The learner corrected this by returning `Text(projectNames[index])`, which went beyond the temporary `SizedBox()` placeholder requested in the exercise.

### Understanding indexes

- Index 0: `Developer Profile Card`
- Index 1: `Project Tracker`
- Index 2: `Profile Editor`

The learner passed the three-question indexing knowledge check with **3/3**.

## 5. Present items with ListTile

`ListTile` provides a Material layout for a row with supporting content:

```dart
ListTile(
  leading: const Icon(Icons.folder),
  title: Text('Developer Profile Card'),
  subtitle: const Text('Flutter learning project'),
)
```

`leading` is the icon before the text, `title` is the main label, and `subtitle` appears beneath it. The icon and subtitle are constant because they do not depend on the index.

We then replaced the hardcoded title with a title read from the list, producing one structured tile per project.

## 6. Final approved project code

Within `ProjectsScreen`, the final list is:

```dart
static const List<String> projectNames = [
  'Developer Profile Card',
  'Project Tracker',
  'Profile Editor',
];

// Inside ProjectsScreen.build() -> Scaffold.body -> Center -> Column.children:
Text('Completed Projects: $completedProjects'),
Expanded(
  child: ListView.builder(
    itemCount: projectNames.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: const Icon(Icons.folder),
        title: Text(projectNames[index]),
        subtitle: const Text('Flutter learning project'),
      );
    },
  ),
),
ElevatedButton(
  onPressed: () {
    Navigator.pop(context);
  },
  child: const Text('Go Back'),
),
```

The complete application source is [`hello_flutter/lib/main.dart`](hello_flutter/lib/main.dart). The Profile Editor, project counter, and navigation from earlier lessons remain in the app.

## 7. Chrome testing and assessment

All reported browser tests passed. Chrome was used by the learner; these results are not independent automated tests of the packaged source.

### Milestone 2 — ListView: 4/4

- ProjectsScreen opened without error.
- All three names appeared in order.
- Project count and Go Back button remained visible.
- Returning to Developer Profile worked.

### Milestone 3 — ListView.builder: 4/4

- ProjectsScreen opened.
- Builder displayed all three names in order.
- Completed project count was correct.
- Go Back navigation worked.

### Milestone 4 — ListTile: 4/4

- ProjectsScreen opened.
- Names and folder icons appeared.
- Each tile displayed the subtitle `Flutter learning project`.
- Go Back worked.

**Final knowledge check:** 6/6 passed.  
**Milestones completed:** 5/5.  
**Result:** Lesson 6 approved.

## 8. Key takeaways

1. Keep the data in a typed collection rather than duplicating it across widgets.
2. `ListView` provides scrolling, whereas a plain `Column` does not.
3. A vertically scrolling list inside a `Column` typically needs a height constraint; `Expanded` provides that in a bounded layout.
4. `ListView.builder` is a good choice for building items based on an index, particularly for longer lists.
5. The item builder must return a widget for each requested index.
6. `projectNames.length` is the total number of list elements, not the last valid index.
7. `ListTile` makes item layouts consistent with `leading`, `title`, and `subtitle`.
8. Verify new UI changes without breaking navigation and previously built features.

## 9. Retention challenge

Without copying the finished code, add a fourth project name to `projectNames` and predict what `itemCount` and the valid indexes become. Then build a three-item list using `ListView.builder` and `ListTile` from memory. Explain why the builder must return a widget and why its ListView needs a height constraint.

## References

- [Flutter ListView API](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [Flutter ListTile API](https://api.flutter.dev/flutter/material/ListTile-class.html)
- [Flutter Expanded API](https://api.flutter.dev/flutter/widgets/Expanded-class.html)
- [Flutter lists cookbook](https://docs.flutter.dev/cookbook/lists/long-lists)

**Next lesson:** Lesson 7 — not started.

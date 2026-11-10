# Lesson 02 — Layouts and Widget Composition

**Stage:** 2 — Flutter Fundamentals
**Project:** Developer Profile Card

## Learning objectives

- Arrange widgets horizontally and vertically.
- Combine multiple layout widgets.
- Understand `child` versus `children`.
- Add internal and external spacing.
- Style widgets with `Container` and `BoxDecoration`.
- Distribute available space using `Expanded`.
- Build a Developer Profile Card.

## 1. Row — Horizontal layouts

`Row` arranges its children horizontally.

```dart
Row(
  children: [
    Text('Dart Developer'),
    Text('Flutter Learner'),
  ],
)
```

The widgets appear side by side in a left-to-right layout.

**Key concept:** `Row` uses `children` because it accepts a list of widgets.

## 2. Column — Vertical layouts

`Column` arranges its children vertically.

```dart
Column(
  children: [
    Text('Lary'),
    Text('Flutter Developer'),
  ],
)
```

The second widget appears below the first.

### Nested layouts

A `Column` can be placed inside a `Row`, and vice versa.

```dart
Row(
  children: [
    Text('Dart Developer'),
    Column(
      children: [
        Text('Flutter Learner'),
        Text('Building My First App'),
      ],
    ),
  ],
)
```

Each layout widget controls the arrangement of its own children.

## 3. Understanding child vs. children

`child:` accepts a single widget.

```dart
Padding(
  padding: EdgeInsets.all(12),
  child: Text('Dart Developer'),
)
```

`children:` accepts a list of widgets.

```dart
Column(
  children: [
    Text('Lary'),
    Text('Flutter Developer'),
  ],
)
```

A mistake I corrected was writing:

```dart
child: [Text('Dart Developer')]
```

This is invalid for `Padding` because the square brackets create a list.

**Key takeaway:** Always check whether a widget constructor expects one `Widget` or a `List<Widget>`.

## 4. SizedBox — Creating space

`SizedBox` can create fixed gaps between widgets.

```dart
SizedBox(width: 20)
```

Creates a 20-logical-pixel horizontal gap when used between children of a Row.

```dart
SizedBox(height: 16)
```

Creates a vertical gap when used between children of a Column.

`SizedBox` can also constrain the size of a child widget.

## 5. Padding — Spacing around a child

`Padding` adds empty space around its child.

```dart
Padding(
  padding: EdgeInsets.all(12),
  child: Text('Dart Developer'),
)
```

Common `EdgeInsets` constructors:

- `EdgeInsets.all(12)` — all four sides.
- `EdgeInsets.symmetric(horizontal: 12)` — left and right.
- `EdgeInsets.symmetric(vertical: 12)` — top and bottom.
- `EdgeInsets.only(left: 12)` — left side only.

**Difference:** `Padding` surrounds a child with space; a standalone `SizedBox` can occupy a separate gap in a layout.

## 6. Container — Styling and layout

`Container` combines several layout and styling capabilities.

```dart
Container(
  color: Colors.blue,
  padding: EdgeInsets.all(12),
  child: Text('Dart Developer'),
)
```

Important properties:

- `color` — background color.
- `padding` — internal spacing.
- `width` and `height` — sizing.
- `child` — the widget contained inside.
- `decoration` — more advanced visual styling.

## 7. Expanded — Flexible space

`Expanded` tells a `Row`, `Column`, or other Flex layout to allocate available space along its main axis to its child.

```dart
Row(
  children: [
    Text('Dart'),
    Expanded(
      child: Text('Flutter'),
    ),
  ],
)
```

Inside a Row, Expanded uses the remaining horizontal space after non-flex children have been laid out.

Inside a Column with bounded height, it can use remaining vertical space.

**Key takeaway:** Expanded changes the space allocated to a child, not the font size of its text.

## 8. BoxDecoration — Rounded corners

`BoxDecoration` controls how a Container is painted.

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text('Developer Profile'),
)
```

When using `decoration`, place the background color inside `BoxDecoration`. Do not also set the Container's separate `color` property.

`BorderRadius.circular(12)` creates rounded corners.

## 9. CircleAvatar — Profile icons

`CircleAvatar` creates a circular area commonly used for profile images, initials, or icons.

```dart
CircleAvatar(
  radius: 28,
  child: Icon(Icons.person),
)
```

The `radius` property belongs to `CircleAvatar`, not to `Icon`.

This reinforced an important Dart concept: named arguments belong to the constructor that declares them.

## 10. Final project — Developer Profile Card

I built a profile card displaying:

- Developer name: Lary
- Role: Flutter Developer
- Circular avatar
- Completed projects: 4
- White background
- Rounded corners
- Internal padding and spacing

The project combined `Row`, `Column`, `Container`, `CircleAvatar`, `SizedBox`, `Text`, and `BoxDecoration`.

### Widget hierarchy

```text
Container
└── Column
    ├── Row
    │   ├── CircleAvatar
    │   │   └── Icon
    │   ├── SizedBox
    │   └── Column
    │       ├── Text (Name)
    │       └── Text (Role)
    ├── SizedBox
    └── Row
        ├── Text (Completed Projects)
        └── Text (4)
```

### Challenges and corrections

- Initially placed two Text widgets directly inside a Row instead of nesting them in a Column.
- Corrected `child: [Text(...)]` to `child: Text(...)`.
- Learned that `radius` belongs to `CircleAvatar`.
- Practiced matching parentheses, brackets, and commas in nested widget trees.
- Used `BoxDecoration` instead of combining Container's `color` and `decoration` properties.

## 11. Final assessment

**Coding milestones:** 6/6 approved  
**Knowledge check:** 5/5 passed  
**Final project:** Approved through code review

Final styled-app execution in Chrome was not confirmed at the time of assessment.

## 12. Key takeaways

1. `Row` arranges widgets horizontally.
2. `Column` arranges widgets vertically.
3. `child` accepts one widget; `children` accepts a list.
4. `SizedBox` can create fixed gaps.
5. `Padding` adds space around its child.
6. `Container` supports layout and visual decoration.
7. `Expanded` allocates remaining space in Flex layouts.
8. `BoxDecoration` enables backgrounds and rounded corners.
9. Complex interfaces are created by composing smaller widgets.

## Revision goals

- Rebuild a small profile card without referring to the completed solution.
- Practice writing nested widgets with correct closing brackets.
- Explain the difference between `Padding`, `SizedBox`, and `Expanded`.
- Explore responsive layout behavior on different screen sizes.

**Next lesson:** Lesson 3 — Interactivity and State.

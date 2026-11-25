# Stage 2 — Flutter Fundamentals

**Status: Completed — 8/8 lessons.**  
**Capstone:** Asynchronous Project Manager in [`hello_flutter`](hello_flutter/).

| Lesson | Topic                                                                                          | Completion      |
| ------ | ---------------------------------------------------------------------------------------------- | --------------- |
| 01     | [Your First Flutter App](01-hello-flutter-app.md)                                              | Completed — 3/3 |
| 02     | [Layouts & Widget Composition](02-layouts-and-widget-composition.md)                           | Completed — 5/5 |
| 03     | [Interactivity & State](03-interactivity-and-state.md)                                         | Completed — 6/6 |
| 04     | [User Input & Forms](04-user-input-and-forms.md)                                               | Completed — 6/6 |
| 05     | [Navigation & Multiple Screens](05-navigation-and-multiple-screens.md)                         | Completed — 6/6 |
| 06     | [Lists & Dynamic UI](06-lists-and-dynamic-ui.md)                                               | Completed — 6/6 |
| 07     | [Managing Lists with State](07-managing-lists-with-state.md)                                   | Completed — 6/6 |
| 08     | [Asynchronous Programming & Loading States](08-asynchronous-programming-and-loading-states.md) | Completed — 8/8 |

## Continue learning

Next: [Stage 3 — State Management](../state-management/README.md), beginning with [Local vs. Shared State](../state-management/01-local-vs-shared-state.md).

## Capstone overview

The `hello_flutter` app combines a profile screen, editable developer name, project completion counter, multiple-screen navigation, dynamic project list, index-based deletion, and simulated asynchronous loading of a new project list. It displays a loading indicator, disables the Load Projects button while loading, and guards against `setState` after disposal using `mounted`.

The fetched list is generated locally after a two-second delay. There is **no live API**, server database, or persistent storage yet. The completed-projects counter on the Profile screen is separate from the length of the editable project list.

## Run locally

```bash
cd flutter-fundamentals/hello_flutter
flutter pub get
flutter run -d chrome
```

Optional checks:

```bash
flutter analyze
flutter test
```

These are recommended commands, not results claimed for the packaged files. Existing tests may need adjustment if they assert older text or the original starter app.

## Learning approach

Learn → Build → Review → Document.

# Stage 3 — State Management

Learn how to choose where state lives, coordinate related widgets, and keep a single source of truth.

## Lessons

| Lesson | Notes | Exercises | Solutions |
| --- | --- | --- | --- |
| 01 — Local vs. Shared State | [Read notes](01-local-vs-shared-state.md) | [Work through exercises](exercises/01-local-vs-shared-state.md) | [Solution guide](solutions/01-local-vs-shared-state.md) |

## How to use this section

1. Read the concept notes and run the small examples.
2. Complete the exercises without looking at the answers.
3. Follow the **Solution** link beneath each exercise only after attempting it.
4. Build the To-Do Manager inside the existing [Flutter app](../flutter-fundamentals/hello_flutter/), preserving the earlier Profile and Projects screens.
5. Compare behavior with the acceptance criteria, then use `flutter analyze` and run the app.

### Lesson 01 learning outcomes

- Distinguish local widget state from data shared across widgets.
- Choose the nearest common ancestor to own shared state.
- Pass values down via constructors and events up via callbacks.
- Use `VoidCallback`, `ValueChanged<String>`, and `setState()`.
- Avoid duplicate state by deriving values from primary data.
- Filter collections case-insensitively and handle empty search queries.
- Build a searchable To-Do Manager using three widgets.
- Navigate to the new screen without replacing an existing screen.

## References

- [Flutter state management](https://docs.flutter.dev/data-and-backend/state-mgmt/intro)
- [Simple app state management](https://docs.flutter.dev/data-and-backend/state-mgmt/simple)
- [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- [ValueChanged](https://api.flutter.dev/flutter/foundation/ValueChanged.html)
- [Dart collections](https://dart.dev/language/collections)

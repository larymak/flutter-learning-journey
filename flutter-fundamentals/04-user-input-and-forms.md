# Lesson 04 — User Input and Forms

**Stage:** 2 — Flutter Fundamentals  
**Status:** Completed  
**Final knowledge check:** 6/6  
**Project:** Developer Profile Editor (`hello_flutter`)  
**Chrome testing:** 4/4 validation tests passed (learner-reported)

## Learning objectives

- Create editable fields using `TextField`.
- Add labels and validation messages using `InputDecoration`.
- Use `TextEditingController` to read input text.
- Dispose of controllers when their owning `State` is removed.
- Update a displayed name using `setState()`.
- Validate empty and whitespace-only input.
- Use a nullable error state and display feedback under the field.
- Diagnose misuse of `const` when a widget depends on runtime state.

## 1. TextField and InputDecoration

`TextField` lets the user type text. `InputDecoration` configures presentation such as labels, hints, borders, and validation messages.

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Developer Name',
    errorText: nameError,
  ),
  controller: nameController,
),
```

Here `errorText` is a `String?`: `null` displays no error; a message such as `'Name cannot be empty'` appears under the input. Because `nameError` changes at runtime, its enclosing `InputDecoration` cannot be `const`.

## 2. TextEditingController

A `TextEditingController` manages the field's editable value and makes its current text available through `.text`.

Inside `_MyHomePageState`:

```dart
final nameController = TextEditingController();
```

- `final` prevents reassigning the controller variable; its managed text can still change.
- `nameController.text` returns a `String` with the field's current input.
- The `controller:` property belongs on `TextField`, not inside `InputDecoration`.

### Lifecycle cleanup

The owning `State` should dispose of the controller:

```dart
@override
void dispose() {
  nameController.dispose();
  super.dispose();
}
```

`dispose()` is called by Flutter when the State is permanently removed; it is not called after each button tap. `super.dispose()` should come last.

## 3. Dynamic profile name

The displayed name begins as a mutable state variable:

```dart
String developerName = 'Lary';
```

In the profile header:

```dart
Column(
  children: [
    Text(developerName),
    const Text('Flutter Developer'),
  ],
),
```

`Text(developerName)` reads the String variable. `Text('developerName')` would instead print those literal characters. Unlike the integer project count, a String variable can be passed directly to `Text` without interpolation.

The parent `Row` must not be `const` if it contains `Text(developerName)`. This was a real compilation error encountered and fixed during the lesson (`Not a constant expression`). Individual static child widgets may still be `const`.

## 4. Updating the name with a callback

The button passes the method reference, without calling it during build:

```dart
ElevatedButton(
  onPressed: _updateProfile,
  child: const Text('Update Profile'),
),
```

The method reads the connected controller, validates its input, and changes the displayed profile name via `setState()`.

## 5. Input validation and early return

A blank string and a string containing only spaces should be rejected. This checks both:

```dart
nameController.text.trim().isEmpty
```

- `.trim()` removes whitespace from the beginning and end.
- `.isEmpty` checks if the resulting String has no characters.
- `return;` in a `void` method stops execution before invalid data is saved.

## 6. Error state and feedback

The nullable field begins with no error:

```dart
String? nameError = null;
```

The final approved method:

```dart
void _updateProfile() {
  if (nameController.text.trim().isEmpty) {
    setState(() {
      nameError = 'Name cannot be empty';
    });
    print('Name cannot be empty'); // Optional debug message
    return;
  }

  setState(() {
    developerName = nameController.text;
    nameError = null;
  });
}
```

**Invalid input:** the error state is populated; the TextField displays feedback; `return` preserves the existing profile name.  
**Valid input:** the name changes; the error state becomes `null`; Flutter rebuilds the UI without an error.

Note: The approved code trims **for validation**, but stores the original entered String. For example, `'  Lary Mak  '` is accepted with spaces included. A later refinement could use `developerName = nameController.text.trim();` to store the normalized name.

## 7. Final project — Developer Profile Editor

Built on the existing interactive Developer Project Tracker, the app now includes:

- A profile avatar, developer name, and role.
- Completed project count, increment button, and reset button.
- A Developer Name input field.
- An Update Profile button.
- Inline error text for invalid names, cleared upon a valid update.
- Correct controller lifecycle cleanup.

**Source:** [`hello_flutter/lib/main.dart`](hello_flutter/lib/main.dart).

## References

- [Flutter forms and input](https://docs.flutter.dev/cookbook/forms)
- [TextField API](https://api.flutter.dev/flutter/material/TextField-class.html)
- [TextEditingController API](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)
- [InputDecoration API](https://api.flutter.dev/flutter/material/InputDecoration-class.html)
- [State.dispose API](https://api.flutter.dev/flutter/widgets/State/dispose.html)

**Next lesson:** Lesson 5 — not started.

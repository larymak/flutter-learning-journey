# Lesson 02 — Milestone 1: Solutions and Explanations

**Topic:** Sharing Data Between Widgets  
[Back to exercises](../exercises/02-sharing-data-between-widgets-milestone-1.md) · [Concept notes](../02-sharing-data-between-widgets.md) · [Complete runnable example](02-shopping-cart-milestone-1.dart)

This answer guide is separate from the learner workbook. Complete each exercise before reading its solution.

## Exercise 2.1 — Choose the state owner

[Back to Exercise 2.1](../exercises/02-sharing-data-between-widgets-milestone-1.md#exercise-21-choose-the-state-owner)

**Answer:** `ShoppingPage` owns `cartCount` because it is the nearest common ancestor of the button branch and badge branch. `AddToCartButton` requests a change through a callback. The parent updates its count and provides the new value through `ShoppingHeader` to `CartBadge`.

The widget that starts an action and the widget that owns the state need not be the same widget.

## Exercise 2.2 — Forward data through an intermediate widget

[Back to Exercise 2.2](../exercises/02-sharing-data-between-widgets-milestone-1.md#exercise-22-forward-data-through-an-intermediate-widget)

**Answer:** Yes, `ShoppingHeader` receives `cartCount` so it can pass it to its child. It should forward that value rather than create an independently updated counter. Both branches then depend on the same parent-owned value, keeping the badge consistent when the parent rebuilds.

## Exercise 2.3, Step 1 — ShoppingHeader field and constructor

[Back to Exercise 2.3, Step 1](../exercises/02-sharing-data-between-widgets-milestone-1.md#step-1-declare-shoppingheader)

```dart
class ShoppingHeader extends StatelessWidget {
  final int cartCount;

  const ShoppingHeader({
    super.key,
    required this.cartCount,
  });
}
```

This is an **intentional scaffold**, not a complete concrete widget. Its `build()` method is added in Step 2. `final` prevents reassigning the widget's configuration field.

## Exercise 2.3, Step 2 — Forward count to CartBadge

[Back to Exercise 2.3, Step 2](../exercises/02-sharing-data-between-widgets-milestone-1.md#step-2-forward-the-value-to-cartbadge)

```dart
@override
Widget build(BuildContext context) {
  return CartBadge(cartCount: cartCount);
}
```

The named parameter on the left belongs to `CartBadge`; the value on the right is the current field of `ShoppingHeader`.

## Exercise 2.3, Step 3 — Pass count from ShoppingPage

[Back to Exercise 2.3, Step 3](../exercises/02-sharing-data-between-widgets-milestone-1.md#step-3-supply-the-value-from-the-parent)

```dart
ShoppingHeader(cartCount: cartCount),
```

Pass the variable rather than a fixed number so that a subsequent parent rebuild uses the latest count. The trailing comma makes the expression a valid element in `children: [...]`.

## Exercise 2.4, Step 1 — ProductList callback field and constructor

[Back to Exercise 2.4, Step 1](../exercises/02-sharing-data-between-widgets-milestone-1.md#step-1-declare-productlist)

```dart
class ProductList extends StatelessWidget {
  final VoidCallback onAdd;

  const ProductList({
    super.key,
    required this.onAdd,
  });
}
```

This is an **intentional scaffold**. The callback is received, not executed. The `build()` method follows in Step 2.

## Exercise 2.4, Step 2 — Forward the callback

[Back to Exercise 2.4, Step 2](../exercises/02-sharing-data-between-widgets-milestone-1.md#step-2-forward-the-callback)

```dart
@override
Widget build(BuildContext context) {
  return AddToCartButton(onAdd: onAdd);
}
```

The right-hand `onAdd` is a function reference. Adding parentheses to call it here would execute it during the build and yield `void`, which is not a `VoidCallback`.

## Exercise 2.4, Step 3 — Provide the parent callback

[Back to Exercise 2.4, Step 3](../exercises/02-sharing-data-between-widgets-milestone-1.md#step-3-supply-the-parents-update-method)

```dart
ProductList(onAdd: _addToCart),
```

`ProductList` receives a reference to the parent's existing update method and can pass it to the button unchanged.

## Exercise 2.5, Step 1 — Order the update cycle

[Back to Exercise 2.5, Step 1](../exercises/02-sharing-data-between-widgets-milestone-1.md#step-1-order-the-events)

**Correct event-letter order:** **B → D → E → C → A**.

1. The button is pressed.
2. The forwarded callback invokes `_addToCart()`.
3. `setState()` updates the parent's `cartCount` synchronously.
4. Flutter schedules and performs a rebuild; the parent provides the updated count to `ShoppingHeader`.
5. `ShoppingHeader` forwards that count to `CartBadge`.

The state update happens before the widget tree displays the resulting value.

## Exercise 2.5, Step 2 — Implement _addToCart

[Back to Exercise 2.5, Step 2](../exercises/02-sharing-data-between-widgets-milestone-1.md#step-2-implement-the-update-method)

```dart
void _addToCart() {
  setState(() {
    cartCount++;
  });
}
```

`cartCount++` adds one to the existing State field. Calling `setState()` informs Flutter that widgets depending on this state need to be rebuilt.

## Exercise 2.5, Step 3 — Compose ShoppingPage.build

[Back to Exercise 2.5, Step 3](../exercises/02-sharing-data-between-widgets-milestone-1.md#step-3-assemble-the-parent-widget-tree)

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        ShoppingHeader(cartCount: cartCount),
        ProductList(onAdd: _addToCart),
      ],
    ),
  );
}
```

`ShoppingHeader` receives the value; `ProductList` receives the update callback. Their respective descendants use those inputs without owning a second copy of shared state.

## Final milestone assessment — Answer guide

[Back to final assessment](../exercises/02-sharing-data-between-widgets-milestone-1.md#final-milestone-assessment)

1. **4 items.** The count starts at 2 and two presses each add one.
2. **ShoppingPage.** It owns the mutable State field and `_addToCart()`.
3. **Callback path:** ShoppingPage passes `_addToCart` to ProductList, which passes the reference to AddToCartButton. The button invokes it when pressed.
4. **Value path:** After `setState()` updates the parent count, ShoppingPage rebuilds and passes it to ShoppingHeader, which forwards it to CartBadge.
5. **Single source of truth:** Independent counters can diverge. Keeping the count in one parent means the display and action branches depend on the same authoritative value.

## Complete implementation

The full example—including the app entry point, state owner, intermediate widgets, button, and badge—is in [02-shopping-cart-milestone-1.dart](02-shopping-cart-milestone-1.dart). This is an additional reference, not a requirement for reading the individual answers.

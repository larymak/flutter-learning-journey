# Lesson 02 — Sharing Data Between Widgets

**Stage:** 3 — State Management  
**Scope:** Milestone 1 — Sharing values and callbacks through intermediate widgets

[Practice workbook](exercises/02-sharing-data-between-widgets-milestone-1.md) · [Separate solutions](solutions/02-sharing-data-between-widgets-milestone-1.md) · [Runnable shopping cart example](solutions/02-shopping-cart-milestone-1.dart)

## Learning objectives

By the end of this milestone, you should be able to:

- Identify the nearest common widget that should own shared state.
- Distinguish *owning* state from *receiving* or *forwarding* a value.
- Pass values down two or more widget levels using required constructor arguments.
- Forward a `VoidCallback` through an intermediate widget without invoking it.
- Explain the sequence from a button press to an updated sibling widget.
- Use `setState()` to update the source of truth and rebuild dependent widgets.
- Compose the separate communication paths inside a parent `build()` method.

## 1. One owner, two branches

A shopping screen contains two branches that need to coordinate:

```text
ShoppingPage (owns cartCount and _addToCart)
├── ShoppingHeader
│   └── CartBadge (displays cartCount)
└── ProductList
    └── AddToCartButton (requests an update)
```

The **AddToCartButton** triggers the action, but that does not make it the state owner. **CartBadge** displays the current count, but that does not make it the owner either. Their nearest common ancestor, **ShoppingPage**, can hold one authoritative `cartCount` and coordinate both branches.

When choosing a state owner, ask: *Which widgets use the data? Which widget changes it? What is their nearest common ancestor?*

## 2. Passing a value down: ShoppingPage → ShoppingHeader → CartBadge

A widget receives immutable configuration through its constructor:

```dart
class ShoppingHeader extends StatelessWidget {
  final int cartCount;

  const ShoppingHeader({
    super.key,
    required this.cartCount,
  });

  @override
  Widget build(BuildContext context) {
    return CartBadge(cartCount: cartCount);
  }
}
```

In `ShoppingPage.build()`, the parent provides the current value:

```dart
ShoppingHeader(cartCount: cartCount),
```

`ShoppingHeader` forwards the received value, even though it doesn't display the count itself. It does **not** create another independent mutable counter.

`cartCount: cartCount` has two roles:

- **Left:** The child's named constructor parameter.
- **Right:** The existing value in the surrounding widget.

Inside a widget `children: [...]` list, end each element with a comma, not a semicolon. Outside a list, a standalone expression statement can end with a semicolon.

### What is prop drilling?

**Prop drilling** means passing data through intermediate widgets to reach a deeper descendant. It is normal in a small tree, but extensive forwarding across many layers can become cumbersome.

## 3. Passing callback references down: ShoppingPage → ProductList → AddToCartButton

`VoidCallback` is a function type that takes **no parameters** and returns **void**.

The intermediate widget receives the callback as a constructor parameter and passes the same reference to its child:

```dart
class ProductList extends StatelessWidget {
  final VoidCallback onAdd;

  const ProductList({
    super.key,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AddToCartButton(onAdd: onAdd);
  }
}
```

The parent provides its update method:

```dart
ProductList(onAdd: _addToCart),
```

The button connects that reference to a user interaction:

```dart
ElevatedButton(
  onPressed: onAdd,
  child: const Text('Add to Cart'),
)
```

**Passing vs. invoking:**

- `_addToCart` is a **function reference**; passing it does not execute it.
- `_addToCart()` **calls** the function immediately.
- The callback reference moves **downward** through constructor arguments; invoking it in a descendant causes the parent's method to run.

The intermediate `ProductList` does not need to know how the cart count is stored or updated.

## 4. Updating parent-owned state

The parent State object owns the count and the update method:

```dart
int cartCount = 0;

void _addToCart() {
  setState(() {
    cartCount++;
  });
}
```

`cartCount++` changes the stored value by one. The callback passed to `setState()` runs synchronously; Flutter marks the State object for rebuilding afterward. Child widgets can then receive refreshed constructor values.

Do not maintain separate mutable cart counts inside `AddToCartButton`, `ProductList`, `ShoppingHeader`, or `CartBadge` just to mirror the same value.

## 5. The complete update sequence

Assume `cartCount` starts at `2`. One button press results in this logical sequence:

1. The user presses `AddToCartButton`.
2. The button invokes the callback forwarded from `ShoppingPage` through `ProductList`.
3. `_addToCart()` updates the parent's `cartCount` using `setState()`.
4. Flutter rebuilds `ShoppingPage`; its `build()` passes the current count to `ShoppingHeader`.
5. `ShoppingHeader` forwards the value to `CartBadge`, which displays it.

After two presses, the count becomes `4`. The header and badge do not independently increment anything; they receive the state owner's current value.

## 6. Combining both paths in the parent

Within `_ShoppingPageState`, the parent can compose the two branches:

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

The **value path** is `ShoppingPage → ShoppingHeader → CartBadge`. The **callback path** is `ShoppingPage → ProductList → AddToCartButton`. The parent connects both branches through one State object.

See the [complete runnable example](solutions/02-shopping-cart-milestone-1.dart) for the surrounding widget declarations and `MaterialApp` entry point. The example uses Flutter's Material library; adjust the import to your project's supported Material package when necessary.

## 7. When to use this pattern

Constructor-based data and callback forwarding is well suited for a small widget hierarchy, where the relationships remain understandable. For a much larger tree, consider whether callbacks/values are being forwarded through too many unrelated widgets; later lessons introduce broader state-management approaches.

## Check your understanding

- Who owns `cartCount` when two sibling branches depend on it?
- Why doesn't `ShoppingHeader` need its own mutable counter?
- What does `final VoidCallback onAdd` mean?
- Does forwarding `onAdd` run the function?
- Why does the badge receive a different number only after the parent changes state and rebuilds?

**Next:** Work through the [exercise workbook](exercises/02-sharing-data-between-widgets-milestone-1.md) before opening the separate solutions.

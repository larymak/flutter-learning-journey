# Lesson 02 — Milestone 1: Practice Workbook

**Topic:** Sharing data and callbacks between Flutter widgets  
**Prerequisite:** [Lesson notes](../02-sharing-data-between-widgets.md)

Work through the exercises sequentially. Write your own answers before selecting the **View solution** link. All solution material is stored in a separate file; this workbook intentionally contains no completed answers.

## Setup: The shopping cart widget tree

```text
ShoppingPage
├── ShoppingHeader
│   └── CartBadge
└── ProductList
    └── AddToCartButton
```

`ShoppingPage` needs a cart count shared between a button branch and a display branch.

## Exercise 2.1 — Choose the state owner

**Goal:** Determine who should own data used by multiple branches.

**Task:**

1. Identify which of the five widgets should own the mutable `cartCount`.
2. Explain why the button that triggers an update is not necessarily the state owner.
3. Describe how the owner would coordinate the button and the badge.

**Acceptance criteria:** Name the correct common ancestor and explain *one source of truth*, a child-triggered callback, and data passed to the display widget.

[View solution to Exercise 2.1](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-21-choose-the-state-owner)

## Exercise 2.2 — Forward data through an intermediate widget

**Goal:** Explain how data reaches a grandchild.

Assume `ShoppingPage → ShoppingHeader → CartBadge`, and the header does not display the count itself.

**Task:**

1. Decide whether `ShoppingHeader` needs to receive `cartCount`.
2. Explain whether it should create its own independently updated count or forward the parent's value.
3. Explain why your approach keeps the badge consistent with the rest of the screen.

**Acceptance criteria:** Clearly distinguish passing a received field from independently owning mutable state.

[View solution to Exercise 2.2](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-22-forward-data-through-an-intermediate-widget)

## Exercise 2.3 — Pass `cartCount` through three widget levels

**Goal:** Implement a chain of constructor arguments carrying the same count.

### Step 1 — Declare `ShoppingHeader`

Create an intentionally incomplete `ShoppingHeader` that:

- Extends `StatelessWidget`.
- Declares `final int cartCount`.
- Has a `const` constructor with `super.key` and `required this.cartCount`.

Do not write `build()` yet.

[View solution to Exercise 2.3, Step 1](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-23-step-1-shoppingheader-field-and-constructor)

### Step 2 — Forward the value to `CartBadge`

Assume `CartBadge` has a required named integer argument, `cartCount`.

Write **only** `ShoppingHeader.build()` so it returns a `CartBadge` receiving the header's existing value.

[View solution to Exercise 2.3, Step 2](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-23-step-2-forward-count-to-cartbadge)

### Step 3 — Supply the value from the parent

Assume `ShoppingPage` has `int cartCount = 3;` in its State object.

Write **only** the `ShoppingHeader` constructor call for a `children: [...]` list. Pass the existing variable dynamically, and include list-element punctuation. Do not hardcode `3`.

[View solution to Exercise 2.3, Step 3](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-23-step-3-pass-count-from-shoppingpage)

## Exercise 2.4 — Forward callbacks through three widget levels

**Goal:** Make a descendant button able to invoke a method owned by its ancestor.

### Step 1 — Declare `ProductList`

Create an intentionally incomplete `ProductList` that:

- Extends `StatelessWidget`.
- Declares `final VoidCallback onAdd`.
- Uses a `const` constructor with `super.key` and `required this.onAdd`.

Do not write `build()` yet.

[View solution to Exercise 2.4, Step 1](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-24-step-1-productlist-callback-field-and-constructor)

### Step 2 — Forward the callback

Assume `AddToCartButton` already declares a required named `VoidCallback onAdd` parameter.

Write **only** `ProductList.build()` so it returns `AddToCartButton`, forwarding the received callback without invoking it.

[View solution to Exercise 2.4, Step 2](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-24-step-2-forward-the-callback)

### Step 3 — Supply the parent's update method

Assume `_ShoppingPageState` has a method named `_addToCart` that takes no arguments and returns `void`.

Write **only** the `ProductList` instantiation for a `children` list. Provide the method *reference*, not the result of calling it.

[View solution to Exercise 2.4, Step 3](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-24-step-3-provide-the-parent-callback)

## Exercise 2.5 — Complete the state-update cycle

**Goal:** Connect the child event to a parent state change and a refreshed badge.

### Step 1 — Order the events

Put these **shuffled** events in the correct order:

- **A:** `CartBadge` receives the updated value through `ShoppingHeader`.
- **B:** The user presses `AddToCartButton`.
- **C:** `ShoppingPage` rebuilds and supplies the current count to `ShoppingHeader`.
- **D:** The forwarded callback invokes the parent's `_addToCart()`.
- **E:** `_addToCart()` increments the parent's count using `setState()`.

**Acceptance criteria:** Clearly distinguish updating state from rebuilding with that state.

[View solution to Exercise 2.5, Step 1](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-25-step-1-order-the-update-cycle)

### Step 2 — Implement the update method

Assume `_ShoppingPageState` already has:

```dart
int cartCount = 0;
```

Write only a `void _addToCart()` method that accepts no parameters and increments the existing count by exactly one inside `setState()`.

[View solution to Exercise 2.5, Step 2](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-25-step-2-implement-_addtocart)

### Step 3 — Assemble the parent widget tree

Assume `_ShoppingPageState` already has `cartCount` and `_addToCart`, and that the two intermediary widgets from earlier exercises are defined.

Write **only** the `build()` method. It must return `Scaffold` with `body: Column(...)` containing, in order:

1. `ShoppingHeader`, receiving the dynamic count.
2. `ProductList`, receiving the function reference.

[View solution to Exercise 2.5, Step 3](../solutions/02-sharing-data-between-widgets-milestone-1.md#exercise-25-step-3-compose-shoppingpagebuild)

## Final milestone assessment

Assume `cartCount` starts at `2` and the user presses **Add to Cart** twice.

1. What count should `CartBadge` display?
2. Which widget owns and updates the count?
3. How does the button invoke the method defined in the parent?
4. How does the updated count reach the badge?
5. Why is one shared counter preferable to independently maintained counters in the button and badge?

**Success criterion:** Explain the two communication paths and the single source of truth in your own words.

[View final assessment answers](../solutions/02-sharing-data-between-widgets-milestone-1.md#final-milestone-assessment-answer-guide)

## Optional implementation practice

Build the complete Shopping Cart using the pieces from Exercises 2.3–2.5. Add the missing `ShoppingPage`, `CartBadge`, and `AddToCartButton` classes and an app entry point. The [separate runnable solution](../solutions/02-shopping-cart-milestone-1.dart) is available after you attempt it.

Run from a Flutter project with a compatible Material import, and check that each button press increases the badge count once.

// Lesson 02, Milestone 1 — Runnable Shopping Cart example.
// Place this code into a Flutter app's lib/main.dart to run it standalone.
// If your project's supported Material library is the standalone material_ui
// package, replace the import below with:
// import 'package:material_ui/material_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ShoppingCartExampleApp());
}

class ShoppingCartExampleApp extends StatelessWidget {
  const ShoppingCartExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ShoppingPage(),
    );
  }
}

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  int cartCount = 0;

  void _addToCart() {
    setState(() {
      cartCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: Column(
        children: [
          ShoppingHeader(cartCount: cartCount),
          ProductList(onAdd: _addToCart),
        ],
      ),
    );
  }
}

class ShoppingHeader extends StatelessWidget {
  final int cartCount;

  const ShoppingHeader({super.key, required this.cartCount});

  @override
  Widget build(BuildContext context) {
    return CartBadge(cartCount: cartCount);
  }
}

class CartBadge extends StatelessWidget {
  final int cartCount;

  const CartBadge({super.key, required this.cartCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text('Items in cart: $cartCount'),
    );
  }
}

class ProductList extends StatelessWidget {
  final VoidCallback onAdd;

  const ProductList({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return AddToCartButton(onAdd: onAdd);
  }
}

class AddToCartButton extends StatelessWidget {
  final VoidCallback onAdd;

  const AddToCartButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAdd,
      child: const Text('Add to Cart'),
    );
  }
}

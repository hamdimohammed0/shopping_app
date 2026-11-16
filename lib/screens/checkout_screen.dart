

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubit/cart_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<CartCubit>().state;
    final total = context.watch<CartCubit>().total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];

                  return ListTile(
                    title: Text(item.product.title),
                    subtitle: Text(
                      'Quantity: ${item.quantity}',
                    ),
                    trailing: Text(
                      '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                    ),
                  );
                },
              ),
            ),

            const Divider(),

            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: cartItems.isEmpty
                  ? null
                  : () async {
                      await context.read<CartCubit>().clearCart();

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Order placed successfully!'),
                        ),
                      );

                      Navigator.pop(context);
                    },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
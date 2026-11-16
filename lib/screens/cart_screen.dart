import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/utils/confirm_dialog.dart';
import 'package:shopping_app/cubit/cart_cubit.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/screens/checkout_screen.dart';
import 'package:shopping_app/widgets/cart_item_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          BlocBuilder<CartCubit, List<CartItemModel>>(
            builder: (context, cartItems) {
              if (cartItems.isEmpty) {
                return const SizedBox();
              }

              return IconButton(
                onPressed: () async {
                  final isClear = await showConfirmDialog(
                    context: context,
                    title: 'Clear Cart',
                    message: 'Are you sure you want to remove all products?',
                  );

                  if (isClear && context.mounted) {
                    context.read<CartCubit>().clearCart();
                  }
                },
                icon: const Icon(Icons.delete_sweep_outlined),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, List<CartItemModel>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty', style: TextStyle(fontSize: 18)),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];

                    return CartItemCard(item: item);
                  },
                ),
              ),

              _buildTotal(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTotal(BuildContext context) {
    final total = context.select((CartCubit cubit) => cubit.total);

    final itemCount = context.select((CartCubit cubit) => cubit.itemCount);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$itemCount items', style: const TextStyle(fontSize: 16)),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckoutScreen()),
              );
            },

            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}

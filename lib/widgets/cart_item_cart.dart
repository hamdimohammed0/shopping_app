import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/utils/confirm_dialog.dart';
import 'package:shopping_app/cubit/cart_cubit.dart';
import 'package:shopping_app/models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              item.product.image,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const SizedBox(
                  width: 80,
                  height: 80,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 80,
                  height: 80,
                  child: Icon(Icons.image_not_supported),
                );
              },
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  Text('\$${item.product.price.toStringAsFixed(2)}'),

                  const SizedBox(height: 4),

                  Text(
                    'Subtotal: \$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<CartCubit>().decreaseQuantity(
                            item.product.id,
                          );
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),

                      Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          context.read<CartCubit>().increaseQuantity(
                            item.product.id,
                          );
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () async {
                final shouldDelete = await showConfirmDialog(
                  context: context,
                  title: 'Remove Product',
                  message: 'Are you sure you want to remove this product?',
                );

                if (shouldDelete && context.mounted) {
                  context.read<CartCubit>().removeFromCart(item.product.id);
                }
              },
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

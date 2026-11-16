import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubit/favorite_cubit.dart';
import 'package:shopping_app/cubit/product_cubit.dart';
import 'package:shopping_app/cubit/product_state.dart';
import 'package:shopping_app/widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocBuilder<FavoriteCubit, Set<int>>(
        builder: (context, favoriteIds) {
          if (favoriteIds.isEmpty) {
            return const Center(
              child: Text('No favorites yet', style: TextStyle(fontSize: 18)),
            );
          }

          return BlocBuilder<ProductCubit, ProductState>(
            builder: (context, productState) {
              if (productState is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (productState is ProductError) {
                return Center(child: Text(productState.message));
              }

              if (productState is ProductSuccess) {
                final favoriteProducts = productState.products
                    .where((product) => favoriteIds.contains(product.id))
                    .toList();

                if (favoriteProducts.isEmpty) {
                  return const Center(
                    child: Text('No favorite products found'),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: favoriteProducts[index]);
                  },
                );
              }

              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}

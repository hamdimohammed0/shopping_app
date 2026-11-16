import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/product_model.dart';

class CartCubit extends Cubit<List<CartItemModel>> {
  CartCubit() : super([]) {
    loadCart();
  }

  Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    final items = List<CartItemModel>.from(state);

    final index = items.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      final item = items[index];

      items[index] = item.copyWith(quantity: item.quantity + quantity);
    } else {
      items.add(CartItemModel(product: product, quantity: quantity));
    }

    emit(items);

    await saveCart();
  }

  Future<void> increaseQuantity(int productId) async {
    final items = List<CartItemModel>.from(state);

    final index = items.indexWhere((item) => item.product.id == productId);

    if (index != -1) {
      final item = items[index];

      items[index] = item.copyWith(quantity: item.quantity + 1);
    }

    emit(items);

    await saveCart();
  }

  Future<void> decreaseQuantity(int productId) async {
    final items = List<CartItemModel>.from(state);

    final index = items.indexWhere((item) => item.product.id == productId);

    if (index != -1) {
      final item = items[index];

      if (item.quantity > 1) {
        items[index] = item.copyWith(quantity: item.quantity - 1);
      } else {
        items.removeAt(index);
      }
    }

    emit(items);

    await saveCart();
  }

  Future<void> removeFromCart(int productId) async {
    final items = List<CartItemModel>.from(state);

    items.removeWhere((item) => item.product.id == productId);

    emit(items);

    await saveCart();
  }

  Future<void> clearCart() async {
    emit([]);
    await saveCart();
  }

  Future<void> saveCart() async {
    final sharf = await SharedPreferences.getInstance();

    final cart = state.map((item) => jsonEncode(item.toJson())).toList();

    await sharf.setStringList('cart', cart);
  }

  Future<void> loadCart() async {
    final sharf = await SharedPreferences.getInstance();

    final savedCart = sharf.getStringList('cart');

    if (savedCart == null) {
      return;
    }

    final items = savedCart.map((item) {
      final json = jsonDecode(item);
      return CartItemModel.fromJson(json as Map<String, dynamic>);
    }).toList();

    emit(items);
  }

  double get total {
    double result = 0;

    for (final item in state) {
      result += item.product.price * item.quantity;
    }

    return result;
  }

  int get itemCount {
    int count = 0;

    for (final item in state) {
      count += item.quantity;
    }

    return count;
  }
}


import 'package:shopping_app/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState{}
class ProductLoading extends ProductState{}
class ProductSuccess extends ProductState{
  final List<ProductModel> products;

  ProductSuccess({required this.products});
}

class ProductError extends ProductState{
  final String message;

  ProductError({required this.message});
}
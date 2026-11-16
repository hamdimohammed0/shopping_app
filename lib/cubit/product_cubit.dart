import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubit/product_state.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/repositories/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;
  ProductCubit(this.productRepository) : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());

    try {
      final products = await productRepository.getProduct();

      emit(ProductSuccess(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString().replaceFirst('Exception: ', '')));
    }
  }

  List<ProductModel> filtringProducts(
    List<ProductModel> product,
    String searchQuery,
  ) {
    return product.where((product) {
      return product.title.toLowerCase().contains(searchQuery) ||
          product.category.toLowerCase().contains(searchQuery);
    }).toList();
  }
}



import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/services/product_api_service.dart';

class ProductRepository {
  final ProductApiService productApiService;

  ProductRepository(
     this.productApiService
    );


    Future<List<ProductModel>> getProduct()async{
      final data = await productApiService.getProducts();

  
      return data.map((item) => ProductModel.fromJson(item)).toList();
    }
}
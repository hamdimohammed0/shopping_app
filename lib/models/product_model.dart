class ProductModel {
  final int id;
  final String title;
  final double price;
  final String image;
  final String category;
  final String description;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
  });
  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
  return ProductModel(
    id: json['id'] as int,
    title: json['title'] as String? ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    image: (json['image'] ?? json['thumbnail']) as String? ?? '',
    category: json['category'] as String? ?? '',
    description: json['description'] as String? ?? '',
  );
}
  
  Map<String, dynamic> toJson() {
  return {
    'id': id,
    'title': title,
    'price': price,
    'image': image,
    'category': category,
    'description': description,
  };
}

}
// file lib/models/product_model.dart
class ProductModel {
  final int? id;
  final createdAt;
  final String name;
  final String brand;
  final String description;
  final double price;
  final String image_path;

  ProductModel({
    this.id,
    required this.createdAt,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    required this.image_path,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'brand': brand,
      'description': description,
      'price': price,
      'image_path': image_path,
    };
  }

  // A method that converts a map into a ProductModel.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      brand: json['brand'],
      description: json['description'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image_path: json['image_path'],
    );
  }
}

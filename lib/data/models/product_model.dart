class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String rating;
  final String description;
  final String category;
  final String deliveryNote;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.description,
    required this.category,
    required this.deliveryNote,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price'] ?? '',
      rating: map['rating'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      deliveryNote: map['deliveryNote'] ?? '',
    );
  }
}

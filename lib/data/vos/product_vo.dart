import '../models/product_model.dart';

class ProductVO {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String rating;
  final String description;
  final String category;
  final String deliveryNote;

  ProductVO({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.description,
    required this.category,
    required this.deliveryNote,
  });

  factory ProductVO.fromModel(ProductModel model) {
    return ProductVO(
      id: model.id,
      name: model.name,
      imageUrl: model.imageUrl,
      price: model.price,
      rating: model.rating,
      description: model.description,
      category: model.category,
      deliveryNote: model.deliveryNote,
    );
  }
}

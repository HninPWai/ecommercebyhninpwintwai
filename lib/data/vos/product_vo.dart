import '../models/product_model.dart';

class ProductVO {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String rating;

  ProductVO({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });

  factory ProductVO.fromModel(ProductModel model) {
    return ProductVO(
      id: model.id,
      name: model.name,
      imageUrl: model.imageUrl,
      price: model.price,
      rating: model.rating,
    );
  }
}

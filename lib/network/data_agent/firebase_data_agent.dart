import '../../data/models/product_model.dart';
import '../../data/vos/product_vo.dart';
import '../api/firebase_api.dart';

class FirebaseDataAgent {
  final FirebaseAPI _firebaseAPI = FirebaseAPI();

  Future<List<ProductVO>> fetchProducts() async {
    var productData = await _firebaseAPI.getProducts();
    return productData.map((data) => ProductVO.fromModel(ProductModel.fromMap(data))).toList();
  }
}

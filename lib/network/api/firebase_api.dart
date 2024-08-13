import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAPI {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getProducts() async {
    var snapshot = await _firestore.collection('products').get();
    print('Retrieved ${snapshot.docs.length} products');
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

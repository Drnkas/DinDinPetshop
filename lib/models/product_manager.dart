import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dindin_petshop/models/product.dart';
import 'package:get/get.dart';

class ProductManager extends GetxController {

  ProductManager(){
    loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxList<Product> _allProducts = RxList<Product>();
  Rx<RxList<Product>> get allProducts => _allProducts.obs;

  Future<void> loadAllProducts() async {
    final QuerySnapshot<Map<String, dynamic>> snapProducts =
    await firestore.collection('products').get();

    _allProducts.assignAll(snapProducts.docs.map((doc) {
      return Product.fromFirestore(doc);
    }).toList());
  }

  Future<void> searchProducts(String query) async {
    try {
      final String lowerCaseQuery = query.toLowerCase();

      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('products')
          .orderBy('name')
          .startAt([lowerCaseQuery])
          .endAt(['$lowerCaseQuery\uf8ff'])
          .where('name', isEqualTo: query)
          .get();

      final List<Product> filteredProducts = snapshot.docs.map((doc) {
        return Product.fromFirestore(doc);
      }).toList();

      _allProducts.assignAll(_filterProducts(filteredProducts, query));
    } catch (error) {
      print('Error searching products: $error');
    }
  }

  List<Product> _filterProducts(List<Product> filteredProducts, String query) {
    return _allProducts.where((product) => product.name!.contains(query)).toList();
  }
}
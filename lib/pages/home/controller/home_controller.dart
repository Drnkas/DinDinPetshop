import 'package:get/get.dart';

import '../../../models/product_manager.dart';

class HomeController extends GetxController {
  final ProductManager _productManager = Get.find<ProductManager>();
  final RxString searchQuery = ''.obs;

  void setSearchQuery(String query) {
    searchQuery.value = query;
    if(searchQuery.value.isEmpty){
      _productManager.loadAllProducts();
    }
    _productManager.searchProducts(query);
  }
}

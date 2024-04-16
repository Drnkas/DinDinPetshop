import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dindin_petshop/models/cart_item_model.dart';
import 'package:dindin_petshop/models/product.dart';
import 'package:get/get.dart';

class CartManager extends GetxController {

  List<CartItem> items = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxList<Product> _allCartItems = RxList<Product>();
  Rx<RxList<Product>> get allCartItems => _allCartItems.obs;

  void addToCart(Product product){
    items.add(CartItem.fromProduct(product));
  }

  num get totalPrice {
    num total = 0;
    for (var item in items) {
      total += item.totalPrice();
    }
    return total;
  }

}
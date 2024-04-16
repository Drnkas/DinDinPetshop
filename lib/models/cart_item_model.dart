import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dindin_petshop/models/product.dart';

class CartItem {
  CartItem({required this.productId, required this.quantity, required this.product});

  CartItem.fromProduct(this.product)
      : productId = product.id,
        quantity = 1.0;

  factory CartItem.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return CartItem(
      productId: snapshot.id,
      quantity: data?['quantity'] as double?,
      product: Product.fromFirestore(snapshot),
    );
  }

  final FirebaseFirestore firestores = FirebaseFirestore.instance;

  String? productId;
  double? quantity;
  Product product;

  num get unitPrice {
    if (product == null) return 0;
    return product.price ?? 0;
  }

  num totalPrice() {
    if (quantity == null) return 0;
    return unitPrice * quantity!;
  }
}
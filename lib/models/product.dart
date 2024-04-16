import 'package:cloud_firestore/cloud_firestore.dart';

class Product{

  String? id;
  String? name;
  String? description;
  double? price;
  List<String>? images;

  Product({this.id, this.name, this.description, this.price, this.images});

  factory Product.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Product(
      id: snapshot.id,
      name: data?['name'] as String?,
      description: data?['description'] as String?,
      price: (data?['price'] as num?)?.toDouble(),
      images: List<String>.from(data?['images'] as List<dynamic>),
    );
  }

}
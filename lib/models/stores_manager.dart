import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dindin_petshop/models/store.dart';
import 'package:get/get.dart';

class StoresManager extends GetxController{

  StoresManager(){
    _loadStoresList();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Store> stores = <Store>[].obs;

  Future<void> _loadStoresList() async {
    final snapshot = await firestore.collection('stores').get();

    stores.assignAll(snapshot.docs.map((e) => Store.fromFirestore(e)).toList());
  }

}
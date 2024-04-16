import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dindin_petshop/firebase_options.dart';
import 'package:dindin_petshop/models/product_manager.dart';
import 'package:dindin_petshop/models/stores_manager.dart';
import 'package:dindin_petshop/pages_routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/cart_manager.dart';
import 'models/user_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(UserManager());
  Get.put(ProductManager());
  Get.put(StoresManager());
  Get.put(CartManager());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dindin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: PagesRoutes.signInRoute,
      getPages: AppPages.pages,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dindin_petshop/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../pages_routes/app_routes.dart';

class UserManager extends GetxController {

  UserManager() {
    Future.delayed(Duration.zero, () {
      _afterInitialization();
    });
  }

  Future<void> _afterInitialization() async {
    await loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Rx<UserApp?> userApp = Rx<UserApp?>(null);
  UserApp? get user => userApp.value;
  final RxBool loading = false.obs;

  Future<void> signIn(UserApp user) async {
    loading.value = true;
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      await loadCurrentUser(firebaseUser: result.user);

      loading.value = false;
    } on FirebaseAuthException {
      loading.value = false;
      rethrow;
    }
  }

  Future<void> signUp(UserApp user) async {
    loading.value = true;

    try {
      await auth.createUserWithEmailAndPassword(
          email: user.email!,
          password: user.password!
      );
      user.id = auth.currentUser!.uid;

      await user.saveData();
      loading.value = false;
    } on FirebaseAuthException {
      loading.value = false;
      rethrow;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> loadCurrentUser({User? firebaseUser}) async {
    User? currentUser = firebaseUser;
    if (firebaseUser == null) {
      currentUser = auth.currentUser;
    }

    if (currentUser != null) {
      final DocumentSnapshot<Map<String, dynamic>> docUser = await firestore.collection('users').doc(currentUser.uid).get();
      userApp.value = UserApp.fromFirestore(docUser);
      Get.toNamed(PagesRoutes.baseRoute);
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {

  UserApp({this.email, this.password, this.name, this.id});

  factory UserApp.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserApp(
      id: snapshot.id,
      name: data?['name'] as String?,
      email: data?['email'] as String?,
    );
  }

  String? id;
  String? name;
  String? email;
  String? password;

  String? confirmPass;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
   await  firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return{
      'name': name,
      'email': email
    };
  }
}
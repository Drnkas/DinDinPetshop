import 'package:dindin_petshop/pages/Auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_images.dart';
import '../base/base_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  //Todo arrumar essa joça
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user){
      if(user == null){

        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        });
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BaseScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          children: [
            Image.asset(
              AppImages.logo,
              fit: BoxFit.contain,
              width: 350,
              height: 350,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

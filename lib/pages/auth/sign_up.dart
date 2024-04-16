import 'package:dindin_petshop/config/app_colors.dart';
import 'package:dindin_petshop/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';
import '../../config/app_images.dart';
import '../../helpers/firebase_errors.dart';
import '../../models/user_manager.dart';
import '../../pages_routes/app_routes.dart';
import '../commom_widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final email = signal('');
  final name = signal('');
  final pass = signal('');
  final confirmPass = signal('');
  final confirmPassError = signal<String?>(null);
  final passError = signal<String?>(null);
  final emailError = signal<String?>(null);
  final nameError = signal<String?>(null);
  final UserApp user = UserApp();

  final UserManager userManager = Get.find<UserManager>();

  late final isValid = computed(() => name().isNotEmpty && email().isNotEmpty && pass().isNotEmpty && confirmPass().isNotEmpty);

  bool validateForm() {
    bool isValid = true;

    if(name().isEmpty){
      nameError.value = 'Nome inválido';
    }
    else if(name().trim().split(' ').length <= 1){
      nameError.value = 'Preencha seu Nome Completo';
      isValid = false;
    } else {
      nameError.value = null;
    }

    final RegExp regex = RegExp(r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");

    if (regex.hasMatch(email())) {
      emailError.value = null;
    } else {
      emailError.value = 'E-mail inválido';
      isValid = false;
    }

    if (pass().isEmpty) {
      passError.value = 'Senha inválida';
      isValid = false;
    } else if(pass().length < 6){
      passError.value = 'Erro! Mínimo 6 caracteres';
    } else {
      passError.value = null;
    }

    if (pass() != confirmPass.value) {
      confirmPassError.value = 'As senhas não correspondem';
      isValid = false;
    } else {
      confirmPassError.value = null;
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [

                  Image.asset(
                    AppImages.logo,
                    fit: BoxFit.contain,
                    width: 350,
                    height: 350,
                  ),

                  // Formulario
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Cadastro',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.fresca(
                                    textStyle: TextStyle(
                                      fontSize: 30,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            CustomTextField(
                              icon: Icons.person,
                              label: 'Nome Completo',
                              textError: nameError.watch(context),
                              onChanged: name.set,
                            ),

                            CustomTextField(
                              icon: Icons.email,
                              label: 'Email',
                              onChanged: email.set,
                              textError: emailError.watch(context),
                            ),

                            CustomTextField(
                              icon: Icons.lock,
                              label: 'Senha',
                              isSecret: true,
                              textError: passError.watch(context),
                              onChanged: pass.set,
                            ),
                            CustomTextField(
                              icon: Icons.lock,
                              label: 'Confirmar Senha',
                              isSecret: true,
                              textError: confirmPassError.watch(context),
                              onChanged: confirmPass.set,
                            ),

                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: () {
                                  isValid.watch(context) ? validateForm : null;
                                  if(validateForm()){

                                    final user = UserApp(
                                      name: name(),
                                      email: email(),
                                      password: pass(),
                                    );

                                    userManager.signUp(user).then((_) {
                                      Get.snackbar(
                                        'Sucesso',
                                        'Conta Criada :)',
                                        backgroundColor: Colors.green,
                                        snackPosition: SnackPosition.BOTTOM,
                                      );

                                      Get.toNamed(PagesRoutes.signInRoute);
                                    }).catchError((error) {
                                      String errorMessage = getErrorString(error.code);
                                      Get.snackbar(
                                        'Erro de autenticação',
                                        errorMessage,
                                        backgroundColor: Colors.red,
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    });
                                  }
                                },
                              child: const Text(
                                  'Criar Conta',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(PagesRoutes.signInRoute);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}

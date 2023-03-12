import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/config/custom_colors.dart';
import 'package:hiperpratico/src/pages/auth/controller/auth_controller.dart';
import 'package:hiperpratico/src/pages/auth/view/components/forgot_password_dialog.dart';
import 'package:hiperpratico/src/routes/app_pages.dart';
import 'package:hiperpratico/src/services/utils.services.dart';
import 'package:hiperpratico/src/services/validators.dart';

import '../../common_widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final utilServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor.shade900,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Nome do App
                    Padding(
                      padding: const EdgeInsets.fromLTRB(100, 50, 100, 10),
                      child: Image.asset('assets/app_images/logo_branca.png'),
                    ),
                    //Categoria de compras
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Supermercados'),
                            FadeAnimatedText('Farmácias'),
                            FadeAnimatedText('Hortifrutes'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Formulário
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 35,
                  horizontal: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //E-mail
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        validator: emailValidator,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: passwordValidator,
                      ),

                      //Botão de entrar
                      SizedBox(
                        height: 50,
                        child: GetX<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        String email = emailController.text;
                                        String password =
                                            passwordController.text;

                                        authController.signInController(
                                          email: email,
                                          password: password,
                                        );
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Entrar',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),

                      //Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                                context: context,
                                builder: (_) {
                                  return ForgotPasswordDialog(
                                    email: emailController.text,
                                  );
                                });
                            if (result ?? false) {
                              utilServices.showToast(
                                message:
                                    'Um link de recuperação de senha foi enviado para os eu email.',
                              );
                            }
                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          ),
                        ),
                      ),

                      //Divisor
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Botão de cadastro
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            side: const BorderSide(
                              width: 2,
                              color: Colors.orange,
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(PagesRoutes.signUpRoute);
                          },
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

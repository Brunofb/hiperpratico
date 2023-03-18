import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/pages/auth/controller/auth_controller.dart';
import 'package:hiperpratico/src/pages/common_widgets/custom_text_field.dart';
import 'package:hiperpratico/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do usuário',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOutController();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.name,
            icon: Icons.email,
            label: 'Nome',
          ),
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.email,
            icon: Icons.person,
            label: 'E-mail',
          ),
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.phone,
            icon: Icons.phone,
            label: 'Celular',
          ),
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
          ),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.orange,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text('Alterar senha'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Alterar senha',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CustomTextField(
                          controller: currentPasswordController,
                          icon: Icons.lock,
                          label: 'Senha Atual',
                          isSecret: true,
                          validator: passwordValidator,
                        ),
                        CustomTextField(
                          controller: newPasswordController,
                          icon: Icons.lock_clock_outlined,
                          label: 'Nova senha',
                          isSecret: true,
                          validator: passwordValidator,
                        ),
                        CustomTextField(
                          icon: Icons.lock_clock_outlined,
                          label: 'Confirmar nova senha',
                          isSecret: true,
                          validator: (password) {
                            final result = passwordValidator(password);
                            if (result != null) {
                              return result;
                            }
                            if (password != newPasswordController.text) {
                              return 'As senhas não são iguais!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 40,
                          child: Obx(() {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        authController.changePasswordController(
                                          password:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                        );
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Atualizar senha',
                                    ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

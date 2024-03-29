import 'package:get/get.dart';
import 'package:hiperpratico/src/constants/storage_keys.dart';
import 'package:hiperpratico/src/models/user_model.dart';
import 'package:hiperpratico/src/pages/auth/repository/auth_repository.dart';
import 'package:hiperpratico/src/pages/auth/result/auth_result.dart';
import 'package:hiperpratico/src/routes/app_pages.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }
    AuthResult result = await authRepository.validateToken(token);
    result.when(success: (user) {
      this.user = user;
      saveTokenAndProceedToBase();
    }, error: (message) {
      signOutController();
    });
  }

  void saveTokenAndProceedToBase() {
    utilsServices.saveLocalData(
      key: StorageKeys.token,
      data: user.token!,
    );
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> changePasswordController({
    required String password,
    required String newPassword,
  }) async {
    isLoading.value = true;
    final result = await authRepository.changePassword(
      email: user.email!,
      password: password,
      newPassword: newPassword,
      token: user.token!,
    );
    isLoading.value = false;

    if (result) {
      utilsServices.showToast(message: 'A senha foi atualizada com suecesso!');
      signOutController();
    } else {
      utilsServices.showToast(
        message: 'A senha atual está incorreta!',
        isError: true,
      );
    }
  }

  Future<void> resetPasswordController(String email) async {
    await authRepository.resetPassword(email);
  }

  Future<void> signOutController() async {
    user = UserModel();
    await utilsServices.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> singUpController() async {
    isLoading.value = true;
    final result = await authRepository.signUp(user);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> signInController({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result = await authRepository.signIn(
      email: email,
      password: password,
    );

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (error) {
        utilsServices.showToast(
          message: error,
          isError: true,
        );
      },
    );
  }
}

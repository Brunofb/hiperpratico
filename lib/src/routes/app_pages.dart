import 'package:get/get.dart';
import 'package:hiperpratico/src/pages/auth/view/sign_in_screen.dart';
import 'package:hiperpratico/src/pages/auth/view/sign_up_screen.dart';
import 'package:hiperpratico/src/pages/base/base_screen.dart';
import 'package:hiperpratico/src/pages/base/binding/navigation_binding.dart';
import 'package:hiperpratico/src/pages/cart/binding/cart_binding.dart';
import 'package:hiperpratico/src/pages/home/binding/home_binding.dart';
import 'package:hiperpratico/src/pages/orders/binding/orders_binding.dart';
import 'package:hiperpratico/src/pages/product/products_screen.dart';
import 'package:hiperpratico/src/pages/splash/splash_screen.dart';

abstract class PagesRoutes {
  static const String signInRoute = '/signin';
  static const String productRoute = '/product';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => ProductScreen(),
      name: PagesRoutes.productRoute,
    ),
    GetPage(
      page: () => const SplashScreen(),
      name: PagesRoutes.splashRoute,
    ),
    GetPage(
      page: () => SignInScreen(),
      name: PagesRoutes.signInRoute,
    ),
    GetPage(
      page: () => SignUpScreen(),
      name: PagesRoutes.signUpRoute,
    ),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
        OrdersBinding(),
      ],
    ),
  ];
}

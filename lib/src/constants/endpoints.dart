const String baseUrl = 'https://parseapi.back4app.com/functions/';

abstract class Endpoints {
  static String signin = '$baseUrl/login';
  static String signup = '$baseUrl/signup';
  static String validateToken = '$baseUrl/validate-token';
  static String changePassword = '$baseUrl/change-password';
  static String resetPassword = '$baseUrl/reset-password';
  static String getAllCategories = '$baseUrl/get-category-list';
  static String getAllProducts = '$baseUrl/get-product-list';
  static String getCarItems = '$baseUrl/get-cart-items';
  static String addItemToCart = '$baseUrl/add-item-to-cart';
  static String changeItemQuantity = '$baseUrl/modify-item-quantity';
  static String clearAllCart = '$baseUrl/delete-cart-items';
  static String checkout = '$baseUrl/checkout';
  static String getAllOrders = '$baseUrl/get-orders';
  static String getOrderItems = '$baseUrl/get-orders-items';
  static String getAllStories = '$baseUrl/get-store-list';
  static String getCategoriesStories = '$baseUrl/get-category-store-list';
}

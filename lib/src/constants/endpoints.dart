const String baseUrl = 'https://parseapi.back4app.com/functions/';

abstract class Endpoints{
  static String signin = '$baseUrl/login';
  static String signup = '$baseUrl/signup';
  static String changePassword = '$baseUrl/change-password';
  static String validateToken = '$baseUrl/validate-token';
}
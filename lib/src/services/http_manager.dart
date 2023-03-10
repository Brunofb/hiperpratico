import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    // Valores default para header
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'sbaHOMSZZVHbMzwLHZmn2M1Xi3xvNJuVjemE22SP',
        'X-Parse-REST-API-Key': 'inRiqmaDxNueGQXkmLw7foZzzKzNXEm18eFTEjQD',
      });

    Dio dio = Dio();

    try {
      Response response = await dio.request(url,
          options: Options(
            method: method,
            headers: defaultHeaders,
          ),
          data: body);
      return response.data;
    } on DioError catch (error) {
      return error.response?.data ?? {};
    } catch (error) {
      return {};
    }
  }
}

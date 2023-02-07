import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();
  final String baseUrl;

  DioClient({required this.baseUrl});
  Future<Response> get(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? progressCallback}) {
    try {
      final response = _dio.getUri(uri,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: progressCallback);
      return response;
    } on FormatException catch (e) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}

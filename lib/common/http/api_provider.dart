import 'package:dio/dio.dart';
import 'package:task/common/constant/api.dart';
import 'package:task/common/http/dio_client.dart';
import 'custom_exception.dart';


class ApiProvider {

  ApiProvider();

  Future<dynamic> get(
    Uri url,
  ) async {
    final DioClient dioClient = DioClient(
      baseUrl: baseUrl,
    );

    dynamic responseJson;

    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };

      final Response response = await dioClient.get(
        url,
        options: Options(
          headers: header,
        ),
      );
      responseJson = handleResponse(response: response);
    } on DioError catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  _handleErrorResponse(DioError e) async {
    if (e.toString().toLowerCase().contains("socketexception")) {
      throw NoInternetException('No Internet connection', 1000);
    } else {
      if (e.response != null) {
        return await handleResponse(response: e.response!);
      } else {
        throw FetchDataException(
          'An error occurred while fetching data.',
          e.response?.statusCode,
        );
      }
    }
  }

  handleResponse({required Response response}) {
    final Map<String, dynamic> res = response.data is Map
        ? response.data
        : (response.data is List)
            ? {"data": response.data}
            : {};

    final responseJson = <String, dynamic>{};
    responseJson['data'] = res;

    responseJson['statusCode'] = response.statusCode;

    if (response.statusCode == 200) {
      return responseJson;
    } else if (response.statusCode == 201) {
      return responseJson;
    } else if (response.statusCode == 204) {
      return responseJson;
    } else {
      throw Exception(response.statusCode);
    }
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';

class Apiservices {
  Dio dio = Dio();
  Future<Response> publicGet({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    log('PUBLIC GET URL: $url');

    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: {'Content-Type': 'application/json'},
          // Client errors (404 "user not found", etc.) are normal app
          // outcomes here, not exceptional failures, so treat anything
          // below 500 as a regular response instead of throwing.
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      log("STATUS CODE: ${response.statusCode}");
      log("RESPONSE DATA: ${response.data.toString()}");
      return response;
    } on DioException catch (e) {
      log("DIO ERROR: $e");
      return e.response ??
          Response(
            requestOptions: RequestOptions(path: url),
            statusCode: e.type == DioExceptionType.connectionError ? 0 : 408,
            data: {
              "message": {"message": e.message, "success": false},
            },
          );
    } catch (e, st) {
      log("UNEXPECTED ERROR: $e");
      log("STACKTRACE: $st");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 500,
        data: {
          "message": {"message": e.toString(), "success": false},
        },
      );
    }
  }
}

import 'package:dio/dio.dart';
import 'package:todo_app/src/core/params/auth/sign_up_request_params.dart';
import 'package:todo_app/src/core/resources/response_state.dart';
import 'package:todo_app/src/core/utils/constants.dart';
import 'package:todo_app/src/data/models/remote_token_data_model.dart';
import 'package:todo_app/src/data/models/user_data_model.dart';

class UserApiService {
  final Dio _dio;
  final String baseUrl;

  UserApiService(this._dio, {this.baseUrl = AppApi.kBaseUrl});

  Future<HttpResponse<RemoteTokenDataModel>> authenticateUser(
      String email, String password) async {
    _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    final result = await _dio.post(
      '$baseUrl/auth/login/',
      data: {
        'email': email,
        'password': password,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    final value = RemoteTokenDataModel.fromJson(result.data!);
    return HttpResponse(value, result);
  }

  Future<HttpResponse<UserDataModel>> signUp(SignUpRequestParams params) async {
    _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    final result = await _dio.post(
      '$baseUrl/users/',
      data: {
        'name': params.name,
        'password': params.password,
        'email': params.email,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    final value = UserDataModel.fromJson(result.data!);
    return HttpResponse(value, result);
  }
}

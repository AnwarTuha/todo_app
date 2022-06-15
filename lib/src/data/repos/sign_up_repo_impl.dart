import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo_app/src/core/params/auth/sign_up_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/data/datasources/remote/user_auth_api.dart';
import 'package:todo_app/src/domain/entities/user_data.dart';
import 'package:todo_app/src/domain/repositories/sign_up_repository.dart';

class SignUpRepoImpl implements SignUpRepository {
  final UserApiService _userAuthApi;

  const SignUpRepoImpl(this._userAuthApi);

  @override
  Future<DataState<UserData>> signUp(SignUpRequestParams params) async {
    try {
      final httpResponse = await _userAuthApi.signUp(params);

      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == 201) {
        return DataSuccess(httpResponse.data);
      }

      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}

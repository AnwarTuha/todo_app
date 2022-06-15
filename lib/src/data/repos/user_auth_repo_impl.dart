import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo_app/src/core/params/auth/auth_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/core/utils/constants.dart';
import 'package:todo_app/src/data/datasources/local/app_hive_service.dart';
import 'package:todo_app/src/data/datasources/remote/user_auth_api.dart';
import 'package:todo_app/src/domain/entities/remote_token_data.dart';
import 'package:todo_app/src/domain/repositories/user_auth_repository.dart';

import '../models/remote_token_data_model.dart';

class UserAuthRepoImpl implements UserAuthRepository {
  final UserApiService _userAuthApi;

  const UserAuthRepoImpl(this._userAuthApi);

  @override
  Future<DataState<RemoteTokenDataModel>> authenticateUser(
      UserAuthRequestParams params) async {
    try {
      final httpResponse =
          await _userAuthApi.authenticateUser(params.email, params.password);

      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == 201) {
        final RemoteTokenData remoteTokenData = httpResponse.data;

        ///SAVE TOKEN
        AppHiveService.instance.appTokenBox.put(
          AppValues.appTokenKey,
          remoteTokenData.appToken.token,
        );
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

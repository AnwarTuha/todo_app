import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

class AppApi {
  /// API
  /// https://mtodo-api.herokuapp.com/api/v1
  static const String kBaseUrl = 'https://mtodo-api.herokuapp.com/api/v1';

  static Future<CacheOptions> getDioCacheOptions() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final options = CacheOptions(
      // A default store is required for interceptor.
      store: HiveCacheStore(appDocPath),
      // Default.
      policy: CachePolicy.refresh,
      // Optional. Returns a cached response on error but for statuses 401 & 403.
      // hitCacheOnErrorExcept: [401, 403],
      // Optional. Overrides any HTTP directive to delete entry past this duration.
      maxStale: const Duration(days: 7),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.high,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended.
      allowPostMethod: false,
    );
    return options;
  }

  // static getAccessToken() {
  //   ///GET USER TOKEN
  //   String token =
  //   AppHiveService.instance.userBox.get(AppValues.loggedUserAccessTokenKey);
  //   return token;
  // }
}

class AppValues {
  //BOTTOM BAR
  static const double bottomBarActiveIconSize = 30;
  static const double bottomBarIconSize = 24;

  // HIVE BOX KEYS
  static const String appTokenKey = 'APP_TOKEN';

  // OTHERS
  static const double loadingWidgetSize = 60;
}

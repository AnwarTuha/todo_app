import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:todo_app/src/core/utils/constants.dart';
import 'package:todo_app/src/domain/entities/token.dart';

class AppHiveService {
  late Box<dynamic> appTokenBox;

  AppHiveService._privateConstructor();

  static final AppHiveService _instance = AppHiveService._privateConstructor();

  static AppHiveService get instance => _instance;

  /// OPEN HIVE BOXES
  initHiveBoxes() async {
    /// REGISTER HIVE ADAPTERS
    await initHiveAdapters();

    appTokenBox = await Hive.openBox<dynamic>(AppValues.appTokenKey);
  }

  Future<void> initHiveAdapters() async {
    //INIT HIVE
    Directory directory = await pathProvider.getApplicationSupportDirectory();
    Hive.init(directory.path);

    // REGISTER ADAPTERS
    Hive.registerAdapter(AppTokenAdapter());
  }
}

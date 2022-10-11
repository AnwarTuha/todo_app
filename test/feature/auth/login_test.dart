// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/src/data/datasources/local/app_hive_service.dart';
import 'package:todo_app/src/injector.dart';

import './step/i_enter_into_input_field.dart';
import './step/i_see.dart';
import './step/i_tap_button.dart';
import './step/im_is_not_logged_in.dart';
import './step/the_app_is_running.dart';

void main() {
  group('''User login''', () {
    testWidgets('''User is presented with login screen''', (tester) async {
      /// initialize dependencies
      await initializeDependencies();

      ///INIT HIVE BOXES
      await tester.runAsync(() => AppHiveService.instance.initHiveBoxes());
      await theAppIsRunning(tester);
      await imIsNotLoggedIn(tester);
      await iSee(tester, 'login_page');
      await iSee(tester, 'phone_number_field');
      await iSee(tester, 'password_field');
      await iSee(tester, 'submit');
    });
    testWidgets(
        '''Outline: User submits correct data to login successfully ("test@gmail.com", "helloThere@1234")''',
        (tester) async {
      await theAppIsRunning(tester);
      await iEnterIntoInputField(tester, "test@gmail.com", 0);
      await iEnterIntoInputField(tester, "helloThere@1234", 1);
      await iTapButton(tester, 'submit');
      await iSee(tester, 'home_page');
    });
    testWidgets(
        '''Outline: User submits with missing required parameters ("", "helloThere@1234")''',
        (tester) async {
      await theAppIsRunning(tester);
      await iSee(tester, 'submit');
      await iEnterIntoInputField(tester, "", 0);
      await iEnterIntoInputField(tester, "helloThere@1234", 1);
      await iTapButton(tester, 'submit');
      await iSee(tester, 'error_message');
    });
    testWidgets(
        '''Outline: User submits with missing required parameters ("test@gmail.com", "")''',
        (tester) async {
      await theAppIsRunning(tester);
      await iSee(tester, 'submit');
      await iEnterIntoInputField(tester, "test@gmail.com", 0);
      await iEnterIntoInputField(tester, "", 1);
      await iTapButton(tester, 'submit');
      await iSee(tester, 'error_message');
    });
  });
}

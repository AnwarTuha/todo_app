import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/src/core/utils/helpers.dart';

Future<void> imIsNotLoggedIn(WidgetTester tester) async {
  bool isUserLoggedIn = await AuthenticationUtils.isUserLoggedIn();
  expect(isUserLoggedIn, false);
}

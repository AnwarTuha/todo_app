import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iSee(WidgetTester tester, dynamic param1) async {
  expect(find.byKey(Key(param1)), findsOneWidget);
}

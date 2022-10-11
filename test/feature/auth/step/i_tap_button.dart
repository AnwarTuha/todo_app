import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iTapButton(WidgetTester tester, dynamic param1) async {
  await tester.tap(find.byKey(Key(param1)));
}

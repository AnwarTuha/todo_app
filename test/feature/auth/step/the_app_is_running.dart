import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(const TodoApp());
  await tester.pumpAndSettle();
}

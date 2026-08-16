import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saranya_rajagopalan_todo_app/main.dart';

void main() {
  testWidgets('Search screen renders search field and prompt', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('GitHub User Search'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(
      find.text('Search for a GitHub username to get started'),
      findsOneWidget,
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:terpiez/main.dart';

void main() {
  testWidgets('demo walkthrough works from stats through landscape navigation', (
    WidgetTester tester,
  ) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => binding.setSurfaceSize(null));

    await tester.pumpWidget(const TerpiezApp());
    await tester.pumpAndSettle();

    expect(find.text('Terpiez Captured'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('Days Played'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);

    await tester.tap(find.text('Finder'));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Nearest Terpiez: 250 meters'), findsOneWidget);

    await tester.tap(find.text('List'));
    await tester.pumpAndSettle();
    expect(find.text('Fire Terpiez'), findsOneWidget);
    expect(find.text('Water Terpiez'), findsOneWidget);
    expect(find.text('Grass Terpiez'), findsOneWidget);

    await tester.tap(find.text('Fire Terpiez'));
    await tester.pumpAndSettle();
    expect(find.text('Fire Terpiez'), findsWidgets);
    expect(find.byIcon(Icons.local_fire_department), findsWidgets);

    await binding.setSurfaceSize(const Size(844, 390));
    await tester.pumpAndSettle();
    expect(find.text('Fire Terpiez'), findsWidgets);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Water Terpiez'), findsOneWidget);

    await tester.tap(find.text('Finder'));
    await tester.pumpAndSettle();
    expect(find.text('Nearest Terpiez: 250 meters'), findsOneWidget);

    await tester.tap(find.text('Stats'));
    await tester.pumpAndSettle();
    expect(find.text('Terpiez Captured'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows tabs and switches between them', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TerpiezApp());

    expect(find.text('Terpiez'), findsOneWidget);
    expect(find.text('Stats'), findsOneWidget);
    expect(find.text('Finder'), findsOneWidget);
    expect(find.text('List'), findsOneWidget);
    expect(find.text('Terpiez Captured'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('Days Played'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);

    await tester.tap(find.text('Finder'));
    await tester.pumpAndSettle();
    expect(find.text('Nearest Terpiez: 250 meters'), findsOneWidget);

    await tester.tap(find.text('List'));
    await tester.pumpAndSettle();
    expect(find.text('Fire Terpiez'), findsOneWidget);
    expect(find.text('Water Terpiez'), findsOneWidget);
    expect(find.text('Grass Terpiez'), findsOneWidget);

    await tester.tap(find.text('Fire Terpiez'));
    await tester.pumpAndSettle();
    expect(find.text('Fire Terpiez'), findsWidgets);
    expect(find.byIcon(Icons.local_fire_department), findsWidgets);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Water Terpiez'), findsOneWidget);
  });

  testWidgets('stays readable in portrait orientation', (
    WidgetTester tester,
  ) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => binding.setSurfaceSize(null));

    await tester.pumpWidget(const TerpiezApp());
    await tester.pumpAndSettle();

    expect(find.text('Terpiez Captured'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.byType(TabBar), findsOneWidget);

    await tester.tap(find.text('Finder'));
    await tester.pumpAndSettle();
    expect(find.text('Nearest Terpiez: 250 meters'), findsOneWidget);

    await tester.tap(find.text('List'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fire Terpiez'));
    await tester.pumpAndSettle();

    expect(find.text('Fire Terpiez'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('stays readable in landscape orientation', (
    WidgetTester tester,
  ) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(const Size(844, 390));
    addTearDown(() => binding.setSurfaceSize(null));

    await tester.pumpWidget(const TerpiezApp());
    await tester.pumpAndSettle();

    expect(find.text('Terpiez Captured'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.byType(TabBar), findsOneWidget);

    await tester.tap(find.text('Finder'));
    await tester.pumpAndSettle();
    expect(find.text('Nearest Terpiez: 250 meters'), findsOneWidget);

    await tester.tap(find.text('List'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Water Terpiez'));
    await tester.pumpAndSettle();

    expect(find.text('Water Terpiez'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}

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
    expect(find.text('0'), findsNWidgets(2));
    expect(find.text('Days Played'), findsOneWidget);

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
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Fire Terpiez'), findsWidgets);
    expect(find.byIcon(Icons.local_fire_department), findsWidgets);

    await binding.setSurfaceSize(const Size(844, 390));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Fire Terpiez'), findsWidgets);

    tester.state<NavigatorState>(find.byType(Navigator)).pop();
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
    expect(find.text('0'), findsNWidgets(2));
    expect(find.text('Days Played'), findsOneWidget);

    await tester.tap(find.text('Finder'));
    await tester.pumpAndSettle();
    expect(find.text('Nearest Terpiez: 250 meters'), findsOneWidget);

    await tester.tap(find.text('List'));
    await tester.pumpAndSettle();
    expect(find.text('Fire Terpiez'), findsOneWidget);
    expect(find.text('Water Terpiez'), findsOneWidget);
    expect(find.text('Grass Terpiez'), findsOneWidget);

    await tester.tap(find.text('Fire Terpiez'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Fire Terpiez'), findsWidgets);
    expect(find.byIcon(Icons.local_fire_department), findsWidgets);

    tester.state<NavigatorState>(find.byType(Navigator)).pop();
    await tester.pumpAndSettle();
    expect(find.text('Water Terpiez'), findsOneWidget);
  });

  testWidgets('finder tap increments terpiez count in stats', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TerpiezApp());
    await tester.pumpAndSettle();

    expect(find.text('0'), findsNWidgets(2));

    await tester.tap(find.text('Finder'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tap map to catch a Terpiez'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Stats'));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('list item uses hero animation into details view', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TerpiezApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('List'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fire Terpiez'));
    await tester.pump(const Duration(milliseconds: 500));

    final heroes = tester.widgetList<Hero>(find.byType(Hero)).toList();
    expect(
      heroes.any((hero) => hero.tag == 'terpiez-icon-Fire Terpiez'),
      isTrue,
    );
    expect(find.byIcon(Icons.local_fire_department), findsWidgets);
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
    expect(find.text('0'), findsNWidgets(2));
    expect(find.byType(TabBar), findsOneWidget);

    await tester.tap(find.text('Finder'));
    await tester.pumpAndSettle();
    expect(find.text('Nearest Terpiez: 250 meters'), findsOneWidget);

    await tester.tap(find.text('List'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fire Terpiez'));
    await tester.pump(const Duration(milliseconds: 500));

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
    expect(find.text('0'), findsNWidgets(2));
    expect(find.byType(TabBar), findsOneWidget);

    await tester.tap(find.text('Finder'));
    await tester.pumpAndSettle();
    expect(find.text('Nearest Terpiez: 250 meters'), findsOneWidget);

    await tester.tap(find.text('List'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Water Terpiez'));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Water Terpiez'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}

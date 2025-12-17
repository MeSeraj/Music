import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_player/main.dart';

void main() {
  testWidgets('Music Player app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed.
    expect(find.text('Music Player'), findsOneWidget);

    // Verify that the empty state message is shown when no songs are added.
    expect(find.text('No songs in playlist'), findsOneWidget);

    // Verify that the add button is present.
    expect(find.byIcon(Icons.add), findsWidgets);
  });

  testWidgets('Home screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify the music note icon is displayed in empty state
    expect(find.byIcon(Icons.music_note), findsOneWidget);

    // Verify the Add Songs button is present
    expect(find.text('Add Songs'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:justsnap/main.dart';

void main() {
  testWidgets('JustSnap app opens home screen', (tester) async {
    await tester.pumpWidget(const JustSnapApp());
    expect(find.text('JustSnap'), findsWidgets);
    expect(find.byIcon(Icons.camera_alt_rounded), findsWidgets);
  });
}

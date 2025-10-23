// test/widget_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:telemetry_app/main.dart';

void main() {
  testWidgets('Telemetry app smoke test', (WidgetTester tester) async {

    await tester.pumpWidget(const TelemetryApp());

    expect(find.text('Telemetria'), findsOneWidget);
    expect(find.text('Iniciar Coleta'), findsOneWidget);
  });
}
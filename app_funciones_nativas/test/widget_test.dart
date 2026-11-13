import 'package:flutter_test/flutter_test.dart';

import 'package:app_funciones_nativas/main.dart';

void main() {
  testWidgets('shows the evidence registration screen', (tester) async {
    await tester.pumpWidget(const EvidenciaApp());

    expect(find.text('Evidencia de campo'), findsOneWidget);
    expect(find.text('Registrar Evidencia'), findsOneWidget);
    expect(find.text('Aún no hay evidencias'), findsOneWidget);
  });
}

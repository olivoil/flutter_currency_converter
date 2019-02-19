// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:currency/repositories/repositories.dart';
import 'package:currency/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // TODO(@olivoil): use mock client
    final RatesRepository rateRepository = RatesRepository(
        rateApiClient: RatesApiClient(
      httpClient: http.Client(),
    ));

    await tester.pumpWidget(App(rateRepository: rateRepository));

    expect(find.text('USD'), findsOneWidget);
    expect(find.text('MXN'), findsOneWidget);
  });
}

import 'package:flutter_boilerplate/app/widget/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders Page', (tester) async {
      await tester.pumpWidget(const App());
    });
  });
}

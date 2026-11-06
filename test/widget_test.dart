import 'package:flutter_test/flutter_test.dart';
import 'package:kartu_profil_digital/main.dart';
import 'package:kartu_profil_digital/services/pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Kartu Profil Digital smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await PrefService.init();
    await tester.pumpWidget(MyApp(prefs: prefs));
    expect(find.text('Kartu Profil Digital'), findsOneWidget);
  });
}

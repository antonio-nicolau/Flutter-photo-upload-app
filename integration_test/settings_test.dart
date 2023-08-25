import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wisy_image_uploader/src/app_widget.dart';
import 'package:wisy_image_uploader/src/modules/home/pages/home_page.dart';
import 'package:wisy_image_uploader/src/modules/settings/pages/settings_page.dart';
import 'package:wisy_image_uploader/src/modules/settings/widgets/language_selector_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SettingsPage Integration Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MyApp()),
    );
    expect(find.byType(HomePage), findsOneWidget);
    // Verify that there's settings Icon and user can navigate to settings
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);
    expect(find.byType(LanguageSelector), findsOneWidget);

    // Verify that current language is English
    expect(find.text('English'), findsOneWidget);

    // Change language to Spanish
    await tester.tap(find.byKey(const ValueKey('dropdown')));
    await tester.pumpAndSettle();
    final dropdownItem = find.text('Spanish').last;
    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    // Confirm that language was changed to spanish
    expect(find.text('Español'), findsOneWidget);
    expect(find.text('Idioma seleccionado: Español'), findsOneWidget);
  });
}

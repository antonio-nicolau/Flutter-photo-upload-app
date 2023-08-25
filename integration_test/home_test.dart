import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wisy_image_uploader/src/app_widget.dart';
import 'package:wisy_image_uploader/src/modules/camera/pages/camera_page.dart';
import 'package:wisy_image_uploader/src/modules/home/pages/home_page.dart';
import 'package:wisy_image_uploader/src/modules/home/state/home_state.dart';
import 'package:wisy_image_uploader/src/modules/home/widgets/loading_widget.dart';
import 'package:wisy_image_uploader/src/modules/home/widgets/photos_list_item_widget.dart';
import 'package:wisy_image_uploader/src/modules/settings/pages/settings_page.dart';
import '../test/mocks/mock_photos.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomePage Integration Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Simulate a successful data load
          allPhotosProvider.overrideWith((ref) {
            return Stream.value(mockPhotos);
          })
        ],
        child: const MyApp(),
      ),
    );
    expect(find.byType(HomePage), findsOneWidget);
    // Verify that the LoadingWidget is initially displayed
    expect(find.byType(LoadingWidget), findsOneWidget);
    await tester.pumpAndSettle();

    // Verify that all photos are displayed
    expect(find.byType(GridView), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(PhotosListItem), findsNWidgets(mockPhotos.length));

    // Verify that there's settings Icon and user can navigate to settings
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);

    // Verify that user can navigate to Camera screen
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(CameraPage), findsOneWidget);
  });
}

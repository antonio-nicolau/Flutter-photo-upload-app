import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_image_uploader/src/core/utils/extensions.dart';
import 'package:wisy_image_uploader/src/modules/home/state/home_state.dart';
import 'package:wisy_image_uploader/src/modules/home/widgets/empty_page.dart';
import 'package:wisy_image_uploader/src/modules/home/widgets/loading_widget.dart';
import 'package:wisy_image_uploader/src/modules/camera/pages/camera_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wisy_image_uploader/src/modules/home/widgets/photos_list_item_widget.dart';
import 'package:wisy_image_uploader/src/modules/settings/pages/settings_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(allPhotosProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              context.goTo(const SettingsPage());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: photosAsync.when(
        data: (photos) {
          if (photos.isEmpty) return const EmptyCards();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return PhotosListItem(photo: photo);
            },
          );
        },
        error: (error, _) {
          return Center(child: Text(AppLocalizations.of(context)!.error_loading_photos));
        },
        loading: () {
          return const LoadingWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goTo(const CameraPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

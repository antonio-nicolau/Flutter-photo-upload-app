import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_image_uploader/src/modules/home/state/home_state.dart';
import 'package:wisy_image_uploader/src/modules/home/widgets/empty_page.dart';
import 'package:wisy_image_uploader/src/modules/home/widgets/image_preview_widget.dart';
import 'package:wisy_image_uploader/src/modules/new_image/new_image_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(allPhotosProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: photosAsync.when(
        data: (photos) {
          if (photos.isEmpty) return const EmptyCards();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: ImagePreview(photo.url),
                        );
                      },
                    );
                  },
                  child: Image.network(photo.url));
            },
          );
        },
        error: (error, _) {
          return const Center(child: Text('Error loading photos'));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NewImagePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

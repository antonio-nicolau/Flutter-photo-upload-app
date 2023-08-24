import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_image_uploader/src/modules/home/state/home_state.dart';
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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return Image.network(photo.url);
              },
            );
          },
          error: (error, _) {
            return const Center(child: Text('Error loading photos'));
          },
          loading: () => const Center(child: CircularProgressIndicator())),
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

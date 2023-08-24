import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/services/photos.service.interface.dart';
import 'package:wisy_image_uploader/src/modules/camera/services/remote_storage.service.interface.dart';

enum UploadState { failed, loading, success, none }

final imageUploadingProvider = StateProvider.autoDispose<UploadState>((ref) {
  return UploadState.none;
});

class UploadImageButton extends ConsumerWidget {
  const UploadImageButton({super.key, required this.file});

  final File file;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploading = ref.watch(imageUploadingProvider);

    void upload() async {
      if (uploading == UploadState.loading || uploading == UploadState.success) return;

      ref.read(imageUploadingProvider.notifier).state = UploadState.loading;
      final downloadUrl = await ref.read(remoteStorageProvider).upload(file);

      if (downloadUrl != null) {
        final photo = Photo(
          name: file.uri.pathSegments.last.split('.').first,
          url: downloadUrl,
        );
        if (!context.mounted) return;
        await ref.read(photosServiceProvider).create(photo);
        ref.read(imageUploadingProvider.notifier).state = UploadState.success;
      }
    }

    return Container(
      height: 50,
      color: Colors.white,
      child: ElevatedButton(
        onPressed: upload,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
        ),
        child: Text(
          switch (uploading) {
            UploadState.loading => 'Uploading...',
            UploadState.success => 'Done',
            _ => 'Click to upload',
          },
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

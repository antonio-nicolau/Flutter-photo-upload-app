import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/services/photos.service.dart';
import 'package:wisy_image_uploader/src/modules/new_image/services/remote_storage.service.interface.dart';

class NewImagePage extends ConsumerWidget {
  const NewImagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: CameraAwesomeBuilder.awesome(
        bottomActionsBuilder: (state) {
          state.captureState$.listen((event) async {
            if (event == null) return;
            if (event.status != MediaCaptureStatus.success) return;

            final file = File(event.filePath);

            final downloadUrl = await ref.read(remoteStorageProvider).upload(file);

            if (downloadUrl != null) {
              final photo = Photo(
                name: file.uri.pathSegments.last.split('.').first,
                url: downloadUrl,
              );
              ref.read(photosServiceProvider).create(photo);
            }
          });

          return AwesomeBottomActions(
            state: state,
            right: Container(),
            left: AwesomeCameraSwitchButton(
              state: state,
              scale: 1.0,
              onSwitchTap: (state) {
                state.switchCameraSensor(
                  aspectRatio: state.sensorConfig.aspectRatio,
                );
              },
            ),
          );
        },
        saveConfig: SaveConfig.photo(pathBuilder: () => _createFile()),
      ),
    );
  }

  Future<String> _createFile() async {
    final fileName = '${getRandString()}.jpg';
    final Directory extDir = await getApplicationDocumentsDirectory();

    final file = await File('${extDir.path}/$fileName').create();
    return File(file.path).path;
  }

  String getRandString() {
    var random = Random.secure();
    var values = List<int>.generate(15, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}

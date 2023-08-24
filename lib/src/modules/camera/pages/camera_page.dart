import 'dart:io';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wisy_image_uploader/src/core/utils/functions.dart';

class CameraPage extends ConsumerWidget {
  const CameraPage({super.key});

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

            showPreviewPage(
              context: context,
              file: file,
              showUploadButton: true,
            );
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
}

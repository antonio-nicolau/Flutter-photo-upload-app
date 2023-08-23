import 'dart:io';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:better_open_file/better_open_file.dart';

class NewImagePage extends StatelessWidget {
  const NewImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(
          pathBuilder: () async {
            final Directory extDir = await getTemporaryDirectory();
            final testDir = await Directory(
              '${extDir.path}/camerawesome.jpg',
            ).create(recursive: true);
            return testDir.path;
          },
        ),
        onMediaTap: (mediaCapture) {
          OpenFile.open(mediaCapture.filePath);
        },
      ),
    );
  }
}

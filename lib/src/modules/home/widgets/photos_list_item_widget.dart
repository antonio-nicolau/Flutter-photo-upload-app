import 'package:flutter/material.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/utils/functions.dart';
import 'package:wisy_image_uploader/src/modules/home/widgets/loading_widget.dart';

class PhotosListItem extends StatelessWidget {
  const PhotosListItem({super.key, required this.photo});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPreviewPage(context: context, url: photo.url);
      },
      child: Image.network(
        photo.url,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const LoadingWidget();
        },
      ),
    );
  }
}

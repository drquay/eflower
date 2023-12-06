import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableAssetImageScreen extends StatelessWidget {
  final String path;

  ZoomableAssetImageScreen({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Expanded(
          child: ZoomableAssetImageView(path: path),
        ),
      ],
    );
  }
}
class ZoomableAssetImageView extends StatelessWidget {
  final String path;

  ZoomableAssetImageView({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: PhotoView(
        imageProvider: AssetImage(path),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2.0,
      ),
    );
  }
}

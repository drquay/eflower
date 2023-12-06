import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableNetworkImageScreen extends StatelessWidget {
  final String imageUrl;

  ZoomableNetworkImageScreen({Key? key, required this.imageUrl}) : super(key: key);

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
          child: ZoomableNetworkImageView(imageUrl: imageUrl),
        ),
      ],
    );
  }
}
class ZoomableNetworkImageView extends StatelessWidget {
  final String imageUrl;

  ZoomableNetworkImageView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: PhotoView(
        imageProvider: NetworkImage(imageUrl),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2.0,
      ),
    );
  }
}

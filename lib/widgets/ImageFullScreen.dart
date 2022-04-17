import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageFullScreen extends StatelessWidget {
  final String imageURL;
  // In the constructor, require a Todo.
  ImageFullScreen({required this.imageURL});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: imageURL == ""
                ? Image.asset(
                    "assets/icons/edit_image.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                    color: Colors.black,
                  )
                : imageURL.startsWith("https")
                    ? CachedNetworkImage(
                        imageUrl: imageURL,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => ImageIcon(
                            AssetImage("assets/icons/edit_image.png")),
                      )
                    : Image.file(
                        File(imageURL),
                      ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

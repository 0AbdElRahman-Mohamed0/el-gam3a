import 'package:cached_network_image/cached_network_image.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowPicturePopUp extends StatelessWidget {
  final String image;
  final String tag;
  ShowPicturePopUp({this.image, this.tag});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: '$tag',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: '$image',
                height: 400,
                width: 300,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => LoadingWidget(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

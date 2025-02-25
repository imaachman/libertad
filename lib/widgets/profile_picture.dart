import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePicture extends ConsumerWidget {
  final String imageFilePath;
  final double? iconSize;
  final double? borderWidth;

  const ProfilePicture({
    super.key,
    required this.imageFilePath,
    this.iconSize,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: borderWidth ?? 8),
          borderRadius: BorderRadius.circular(200),
        ),
        child: imageFilePath.isEmpty
            ? Icon(
                Icons.person,
                size: iconSize ?? 100,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.file(
                  File(imageFilePath),
                  fit: BoxFit.fitHeight,
                ),
              ),
      ),
    );
  }
}

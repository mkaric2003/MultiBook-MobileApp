import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickedImagePreview extends StatefulWidget {
  const PickedImagePreview({
    super.key,
    required this.imagePath,
    required this.fit,
    required this.fallback,
  });

  final String? imagePath;
  final BoxFit fit;
  final Widget fallback;

  @override
  State<PickedImagePreview> createState() => _PickedImagePreviewState();
}

class _PickedImagePreviewState extends State<PickedImagePreview> {
  Future<Uint8List>? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(covariant PickedImagePreview oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.imagePath != widget.imagePath) {
      _loadImage();
    }
  }

  void _loadImage() {
    _imageBytes = widget.imagePath == null
        ? null
        : XFile(widget.imagePath!).readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    if (_imageBytes == null) {
      return widget.fallback;
    }

    return FutureBuilder<Uint8List>(
      future: _imageBytes,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return widget.fallback;
        }

        return Image.memory(
          snapshot.data!,
          width: double.infinity,
          height: double.infinity,
          fit: widget.fit,
          gaplessPlayback: true,
          errorBuilder: (_, _, _) => widget.fallback,
        );
      },
    );
  }
}

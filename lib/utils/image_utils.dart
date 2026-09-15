import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> compressImage(
  XFile image, {
  int minWidth = 1080,
  int minHeight = 1080,
  int quality = 42,
}) async {
  final originalBytes = await image.readAsBytes();

  try {
    final compressedBytes = await FlutterImageCompress.compressWithList(
      originalBytes,
      minWidth: minWidth,
      minHeight: minHeight,
      quality: quality,
      format: CompressFormat.webp,
    );

    if (compressedBytes.isEmpty ||
        compressedBytes.lengthInBytes >= originalBytes.lengthInBytes) {
      return originalBytes;
    }

    log(
      'Image compressed from ${originalBytes.lengthInBytes} to ${compressedBytes.lengthInBytes} bytes '
      '(${((1 - compressedBytes.lengthInBytes / originalBytes.lengthInBytes) * 100).round()}% smaller).',
      name: 'ImageUtils',
    );
    return compressedBytes;
  } catch (error, stackTrace) {
    log(
      'Image compression failed. Using original image bytes.',
      name: 'ImageUtils',
      error: error,
      stackTrace: stackTrace,
    );
    return originalBytes;
  }
}

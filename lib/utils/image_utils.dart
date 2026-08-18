import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> compressImage(XFile image) async {
  final originalBytes = await image.readAsBytes();

  try {
    final compressedBytes = await FlutterImageCompress.compressWithList(
      originalBytes,
      minWidth: 1600,
      minHeight: 1600,
      quality: 60,
      format: CompressFormat.webp,
    );

    if (compressedBytes.isEmpty) {
      return originalBytes;
    }

    log(
      'Image compressed from ${originalBytes.lengthInBytes} to ${compressedBytes.lengthInBytes} bytes.',
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

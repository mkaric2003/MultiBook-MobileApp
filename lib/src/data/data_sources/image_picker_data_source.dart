import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

abstract class ImagePickerDataSource {
  Future<XFile?> pickImage({required ImageSource source});

  Future<List<XFile>> pickImages();

  Future<XFile?> retrieveLostImage();
}

@LazySingleton(as: ImagePickerDataSource)
class ImagePickerDataSourceImpl implements ImagePickerDataSource {
  ImagePickerDataSourceImpl() : _imagePicker = ImagePicker();

  final ImagePicker _imagePicker;

  @override
  Future<XFile?> pickImage({required ImageSource source}) {
    return _imagePicker.pickImage(source: source);
  }

  @override
  Future<List<XFile>> pickImages() => _imagePicker.pickMultiImage();

  @override
  Future<XFile?> retrieveLostImage() async {
    final response = await _imagePicker.retrieveLostData();

    if (response.isEmpty) {
      return null;
    }

    if (response.file != null) {
      return response.file;
    }

    final files = response.files;
    return files == null || files.isEmpty ? null : files.first;
  }
}

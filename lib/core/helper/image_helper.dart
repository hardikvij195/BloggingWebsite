import 'package:image_picker/image_picker.dart';

// import '../constants/colors.dart';
// import '../utils/global_variables.dart';

/// image helper for performing different operation on image
class ImageHelper {
  factory ImageHelper() {
    return _singleton;
  }

  ImageHelper._internal();

  static final ImageHelper _singleton = ImageHelper._internal();

  /// for selecting image from gallery or camera
  // ignore: avoid_positional_boolean_parameters
  Future<XFile?> selectImage(bool selectFromGallery,
      {int? imageQuality}) async {
    final imagePicker = ImagePicker();
    if (selectFromGallery) {
      return imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
      );
    } else {
      return imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
      );
    }
  }
}

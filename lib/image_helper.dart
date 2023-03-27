import 'dart:io' show Directory, File;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

// import '../constants/colors.dart';
import '../file_extension.dart';
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
  Future<XFile?> selectImage(bool selectFromGallery, {int? imageQuality}) async {
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

  Future<File?> selectImage1({int? imageQuality}) async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowedExtensions: ['jpg', 'png']);

    if (result != null) {
      final File file = File(result.files.single.path!);
      return file;
    } else {
      return null;
    }
  }

  ///
  /// for uploading files to firebase storage
  ///
  /// using [folderName] of firebase storage
  Future<String> uploadImageFile({
    required File image,
    required String folderName,
    String? imageFileName,
  }) async {
    final uuid = imageFileName ?? const Uuid().v4();
    final storageRef = FirebaseStorage.instance.ref('$folderName/$uuid.${image.fileType}');
    final uploadTaskSnapshot = await storageRef.putFile(image);

    final imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
  }

  ///
  /// for uploading image to firebase storage with jpg extension
  ///
  /// using [folderName] of firebase storage
  Future<String> uploadImage({required File image, required String folderName}) async {
    final uuid = const Uuid().v4();
    final storageRef = FirebaseStorage.instance.ref('$folderName/$uuid.jpg');
    final uploadTaskSnapshot = await storageRef.putFile(image);

    final imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
  }

  ///
  /// for uploading image to firebase storage with jpg extension using [Uint8List]
  ///
  /// using [folderName] of firebase storage
  Future<String> uploadImageUsingUint8List({
    required Uint8List uint8list,
    required String folderName,
  }) async {
    final uuid = const Uuid().v4();
    final storageRef = FirebaseStorage.instance.ref('$folderName/$uuid.png');
    final uploadTaskSnapshot = await storageRef.putData(uint8list);

    final imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
  }

  ///
  /// for uploading image to firebase storage with jpg extension using [Uint8List]
  ///
  /// using [folderName] of firebase storage
  Future<String> uploadVideoUsingUint8List({
    required File file,
    required String folderName,
  }) async {
    final uuid = const Uuid().v4();
    final storageRef = FirebaseStorage.instance.ref('$folderName/$uuid.mp4');
    final uploadTaskSnapshot = await storageRef.putFile(file);

    final imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
  }

  ///
  /// for deleting file from specific url in firebase storage
  Future<void> deleteFileUsingUrl({required String url}) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
    } on Exception catch (_) {}
    return;
  }

  ///
  /// method for getting size of the image in MB
  ///
  /// get [File] as argument
  double getFileSizeInMB(File file) {
    return double.parse((file.lengthSync() / 1000000).toStringAsFixed(2));
  }

  //-------------Cropping Image---------------------------------------//
  Future<File?> cropImage({
    required File imgFile,
    required CropStyle cropStyle,
    required CropAspectRatio aspectRatio,
    required int compressQuality,
    required CropAspectRatioPreset cropAspectRatioPreset,
    required bool lockRatio,
  }) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      cropStyle: cropStyle,
      aspectRatioPresets: [cropAspectRatioPreset],
      aspectRatio: aspectRatio,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 50,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'MingleWise',
            /* statusBarColor: globalDateOrPro ? AppColors.darkOrange : AppColors.darkPurple,
            toolbarColor: globalDateOrPro ? AppColors.darkOrange : AppColors.darkPurple, */
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: lockRatio),
        IOSUiSettings(
          title: 'MingleWise',
        ),
      ],
    );
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

//---------------Image Compression-------------------------//
  Future<File?> compressFile(File file) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final uuid = const Uuid().v4();
    final filePath = '$tempPath/$uuid.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      filePath,
      quality: 50,
    );

    // final size = getFileSizeInMB(result!);
    // print("Dp Compressed Size $size");
    return result;
  }

  Future<File?> unit8ListToFile(Uint8List uint8list) async {
    final Directory tempDir = await getTemporaryDirectory();
    final uuid = const Uuid().v4();
    final filePath = '${tempDir.path}/$uuid.jpg';
    return File(filePath).writeAsBytes(uint8list);
  }
}

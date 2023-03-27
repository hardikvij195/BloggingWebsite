import 'dart:io' show FileSystemEntity;

extension FileExtention on FileSystemEntity {
  /// for getting file name
  String get fileName {
    return path.split('/').last;
  }

  /// for getting file type
  String get fileType {
    return path.split('/').last.split('.').last;
  }
}

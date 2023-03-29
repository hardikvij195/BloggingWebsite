import 'dart:io';

class BlogsImageModel {
  BlogsImageModel({
    this.imgUrl,
    this.imgFile,
    this.imgType,
  });

  factory BlogsImageModel.fromMap(Map<String, dynamic> data) {
    return BlogsImageModel(
        imgUrl: data['imgUrl'] as String? ?? "",
        imgType: data['imgType'] as String? ?? "");
  }

  String? imgUrl;
  File? imgFile;
  String? imgType;

  BlogsImageModel copyWith({String? imgUrl, File? imgFile, String? imgType}) {
    return BlogsImageModel(
        imgFile: imgFile ?? this.imgFile,
        imgUrl: imgUrl ?? this.imgUrl,
        imgType: imgType ?? this.imgType);
  }
}

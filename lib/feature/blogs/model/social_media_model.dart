class SocialMediaModel {
  SocialMediaModel(
      {required this.socialMediaImage, required this.socialMediaNameOrUrl});

  factory SocialMediaModel.fromMap({required Map data}) {
    return SocialMediaModel(
      socialMediaImage: data['socialMediaImage'] as String,
      socialMediaNameOrUrl: data['socialMediaNameOrUrl'] as String,
    );
  }

  String socialMediaImage;

  String socialMediaNameOrUrl;
}

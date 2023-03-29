import 'package:cloud_firestore/cloud_firestore.dart';

import 'social_media_model.dart';

class BloggerProfileModel {
  BloggerProfileModel(
      {required this.imgUrl,
      required this.name,
      required this.userName,
      required this.bloggerId,
      required this.aboutMe,
      required this.socialMediaLinks,
      required this.createdAt,
      required this.followersCount,
      required this.doc});

  factory BloggerProfileModel.fromMap({
    required DocumentSnapshot snap,
  }) {
    final data = snap.data()! as Map;

    final createdAt = (data['createdAt'] as Timestamp).toDate();

    return BloggerProfileModel(
      doc: snap,
      name: data["name"].toString(),
      aboutMe: data["aboutMe"].toString(),
      socialMediaLinks: List<Map>.from(data['socialMediaLinks'] as List)
          .map(
            (e) => SocialMediaModel.fromMap(data: e),
          )
          .toList(),
      createdAt: createdAt,
      bloggerId: snap.id,
      followersCount: data["followersCount"] as int,
      imgUrl: data["imgUrl"].toString(),
      userName: data["userName"].toString(),
    );
  }

  final String imgUrl;
  final String name;
  final String userName;
  final String bloggerId;
  final String aboutMe;
  final List<SocialMediaModel> socialMediaLinks;
  final DateTime createdAt;
  final int followersCount;

  /// post [DocumentSnapshot]
  final DocumentSnapshot doc;
}

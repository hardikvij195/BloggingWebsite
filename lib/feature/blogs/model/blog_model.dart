import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  BlogModel(
      {required this.blogId,
      required this.thumbNail,
      required this.headline,
      required this.content,
      required this.readTime,
      required this.bloggerUid,
      required this.bloggerImgUrl,
      required this.bloggerName,
      required this.tags,
      required this.createdAt,
      required this.blogViewers,
      required this.blogLikes,
      required this.blogComments,
      required this.followersCount,
      required this.sawBlog,
      required this.doc,
      required this.shareLink,
      required this.isPublished,
      required this.showThumbNailAtFirstLine,
      required this.savedBlog,
      required this.wordCount,
      required this.imagesCount,
      required this.linksCount,
      required this.ytVideosCount,
      required this.textOnlyContent,
      required this.bloggerUserName});

  factory BlogModel.fromMap({
    required DocumentSnapshot snap,
    required bool sawBlog,
    required bool savedBlog,
  }) {
    final data = snap.data()! as Map;

    final createdAt = (data['createdAt'] as Timestamp).toDate();

    return BlogModel(
        doc: snap,
        thumbNail: data["thumbNail"].toString(),
        headline: data["headline"].toString(),
        content: data["content"].toString(),
        readTime: data["readTime"].toString(),
        bloggerUid: data["bloggerUid"].toString(),
        bloggerImgUrl: data["bloggerImgUrl"].toString(),
        bloggerName: data["bloggerName"].toString(),
        bloggerUserName: data["bloggerUserName"].toString(),
        tags: List<String>.from(data['tags'] as List),
        createdAt: createdAt,
        wordCount: data["wordCount"] as int,
        imagesCount: data["imagesCount"] as int,
        linksCount: data["linksCount"] as int,
        ytVideosCount: data["ytVideosCount"] as int,
        blogViewers: data["blogViewers"] as int,
        blogLikes: data["blogLikes"] as int,
        blogComments: data["blogComments"] as int,
        followersCount: data["followersCount"] as int,
        blogId: snap.id.toString(),
        sawBlog: sawBlog,
        shareLink: data["shareLink"] as String,
        isPublished: data["isPublished"] as bool,
        showThumbNailAtFirstLine: data["showThumbNailAtFirstLine"] as bool,
        savedBlog: savedBlog,
        textOnlyContent: data["textOnlyContent"] as String);
  }

  final String blogId;
  final String thumbNail;
  final String headline;
  final String content;
  final String readTime;
  final List<String> tags;
  final String bloggerUid;
  final String bloggerImgUrl;
  final String bloggerName;
  final String bloggerUserName;
  final DateTime createdAt;
  final int blogViewers;
  final int blogLikes;
  final int blogComments;
  final int followersCount;
  final bool sawBlog;
  final String shareLink;
  final bool isPublished;
  final bool showThumbNailAtFirstLine;
  final bool savedBlog;
  late final int wordCount;
  late final int imagesCount;
  late final int linksCount;
  late final int ytVideosCount;
  final String textOnlyContent;

  /// post [DocumentSnapshot]
  final DocumentSnapshot doc;

  Map<String, dynamic> savedAndPinnedBlogsToMap() {
    return {
      "thumbNail": thumbNail,
      "headline": headline,
      "content": content,
      "readTime": readTime,
      "bloggerUid": bloggerUid,
      "bloggerName": bloggerName,
      "bloggerImgUrl": bloggerImgUrl,
      "bloggerUserName": bloggerUserName,
      "tags": tags,
      "blogId": blogId,
      "createdAt": Timestamp.now(),
      "wordCount": wordCount,
      "imagesCount": imagesCount,
      "linksCount": linksCount,
      "ytVideosCount": ytVideosCount,
      "blogViewers": blogViewers,
      "blogLikes": blogLikes,
      "blogComments": blogComments,
      "followersCount": followersCount,
      "shareLink": shareLink,
      "isPublished": isPublished,
      "showThumbNailAtFirstLine": showThumbNailAtFirstLine,
      "textOnlyContent": textOnlyContent,
    };
  }

  Map<String, dynamic> increaseViewCountToMap() {
    final viewCount = blogViewers + 1;
    return {
      "thumbNail": thumbNail,
      "headline": headline,
      "content": content,
      "readTime": readTime,
      "bloggerUid": bloggerUid,
      "bloggerName": bloggerName,
      "bloggerImgUrl": bloggerImgUrl,
      "bloggerUserName": bloggerUserName,
      "tags": tags,
      "blogId": blogId,
      "createdAt": Timestamp.now(),
      "wordCount": wordCount,
      "imagesCount": imagesCount,
      "linksCount": linksCount,
      "ytVideosCount": ytVideosCount,
      "blogViewers": viewCount,
      "blogLikes": blogLikes,
      "blogComments": blogComments,
      "followersCount": followersCount,
      "shareLink": shareLink,
      "isPublished": isPublished,
      "showThumbNailAtFirstLine": showThumbNailAtFirstLine,
      "textOnlyContent": textOnlyContent,
    };
  }

  Map<String, dynamic> increaseLikeCountToMap() {
    final likedCount = blogLikes + 1;
    return {
      "thumbNail": thumbNail,
      "headline": headline,
      "content": content,
      "readTime": readTime,
      "bloggerUid": bloggerUid,
      "bloggerName": bloggerName,
      "bloggerImgUrl": bloggerImgUrl,
      "bloggerUserName": bloggerUserName,
      "tags": tags,
      "blogId": blogId,
      "createdAt": Timestamp.now(),
      "wordCount": wordCount,
      "imagesCount": imagesCount,
      "linksCount": linksCount,
      "ytVideosCount": ytVideosCount,
      "blogViewers": blogViewers,
      "blogLikes": likedCount,
      "blogComments": blogComments,
      "followersCount": followersCount,
      "shareLink": shareLink,
      "isPublished": isPublished,
      "showThumbNailAtFirstLine": showThumbNailAtFirstLine,
      "textOnlyContent": textOnlyContent,
    };
  }

  BlogModel copyWith({
    int? noOfViews,
    int? noOfLikes,
    int? noOfComments,
    int? noOfFollowers,
    bool? publishedOrNot,
  }) {
    return BlogModel(
        doc: doc,
        thumbNail: thumbNail,
        headline: headline,
        content: content,
        readTime: readTime,
        bloggerUid: bloggerUid,
        bloggerImgUrl: bloggerImgUrl,
        bloggerName: bloggerName,
        tags: tags,
        createdAt: createdAt,
        blogViewers: noOfViews ?? blogViewers,
        blogLikes: noOfLikes ?? blogLikes,
        blogComments: noOfComments ?? blogComments,
        followersCount: noOfFollowers ?? followersCount,
        blogId: blogId,
        sawBlog: sawBlog,
        shareLink: shareLink,
        isPublished: publishedOrNot ?? isPublished,
        showThumbNailAtFirstLine: showThumbNailAtFirstLine,
        wordCount: wordCount,
        imagesCount: imagesCount,
        linksCount: linksCount,
        ytVideosCount: ytVideosCount,
        savedBlog: savedBlog,
        bloggerUserName: bloggerUserName,
        textOnlyContent: textOnlyContent);
  }
}
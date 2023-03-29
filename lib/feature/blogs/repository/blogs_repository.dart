import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../../core/services/dynamic_link_services.dart';
import '../model/blog_model.dart';
import '../model/blogger_profile_model.dart';
import '../model/social_media_model.dart';

class BlogsRepository {
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  //-----------------Upload Blogger Dp to firebase------------------//
  Future<String> uploadBloggerDpToStorage(File file) async {
    final bloggerDp = const Uuid().v4();
    final metadata = SettableMetadata(contentType: "image/jpeg");
    final storageRef = FirebaseStorage.instance.ref('BloggerProfile/$_uid');
    final uploadTask =
        await storageRef.child("$bloggerDp.jpg").putFile(file, metadata);
    final url = uploadTask.ref.getDownloadURL();
    return url;
  }

//-------Upload Blogger Data to Firebase--------------------------------------------//
  Future<void> uploadBloggerDataToFirebase(String imgUrl, String name,
      String aboutMe, List<SocialMediaModel> socialMediaLinks) async {
    List<Map> socialMediaMapList = [];
    String userName = "";
    int followersCount = 0;
    for (final i in socialMediaLinks) {
      socialMediaMapList.add({
        "socialMediaImage": i.socialMediaImage,
        "socialMediaNameOrUrl": i.socialMediaNameOrUrl
      });
    }
    final proUserDoc =
        await FirebaseFirestore.instance.collection("ProUsers").doc(_uid).get();
    final data = proUserDoc.data()!;
    userName = data["userName"] as String? ?? "";
    followersCount = data["followersCount"] as int? ?? 0;
    await FirebaseFirestore.instance
        .collection("BloggerProfile")
        .doc(_uid)
        .set({
      "imgUrl": imgUrl,
      "name": name,
      "bloggerId": _uid,
      "aboutMe": aboutMe,
      "socialMediaLinks": socialMediaMapList,
      "createdAt": Timestamp.now(),
      "userName": userName,
      "followersCount": followersCount,
    });
  }

  //-------Update Blogger Data to Firebase--------------------------------------------//
  Future<void> updateBloggerDataToFirebase(String imgUrl, String name,
      String aboutMe, List<SocialMediaModel> socialMediaLinks) async {
    final List<Map> socialMediaMapList = [];
    String userName = "";
    int followersCount = 0;
    for (final i in socialMediaLinks) {
      socialMediaMapList.add({
        "socialMediaImage": i.socialMediaImage,
        "socialMediaNameOrUrl": i.socialMediaNameOrUrl
      });
    }
    final proUserDoc =
        await FirebaseFirestore.instance.collection("ProUsers").doc(_uid).get();
    final data = proUserDoc.data()!;
    userName = data["userName"] as String? ?? "";
    followersCount = data["followersCount"] as int? ?? 0;
    await FirebaseFirestore.instance
        .collection("BloggerProfile")
        .doc(_uid)
        .update({
      "imgUrl": imgUrl,
      "name": name,
      "bloggerId": _uid,
      "aboutMe": aboutMe,
      "socialMediaLinks": socialMediaMapList,
      "createdAt": Timestamp.now(),
      "userName": userName,
      "followersCount": followersCount,
    });
  }

  Future<List<BlogModel>> getBlogsPublishedByAuthor(
      {required String uid, DocumentSnapshot? startDoc}) async {
    final list = <BlogModel>[];

    Query query = FirebaseFirestore.instance
        .collection('Blogs')
        .where("bloggerUid", isEqualTo: uid)
        .where("isPublished", isEqualTo: true)
        .orderBy("createdAt", descending: true);

    if (startDoc != null) {
      query = query.startAfterDocument(startDoc);
    }

    final res = await query.limit(5).get();

    for (final i in res.docs) {
      final sawBlog = await getViewedBlogFromFirebase(i.id);
      final savedBlog = await getSavedBlogFromFirebase(i.id);
      list.add(
          BlogModel.fromMap(snap: i, sawBlog: sawBlog, savedBlog: savedBlog));
    }

    return list;
  }

  //-------Get All Blogs--------------------------------------------//
  Future<List<BlogModel>> getAllBlogs({DocumentSnapshot? startDoc}) async {
    final list = <BlogModel>[];
    final res = await FirebaseFirestore.instance
        .collection('Blogs')
        .where("isPublished", isEqualTo: true)
        .get();
    for (final i in res.docs) {
      list.add(BlogModel.fromMap(snap: i, sawBlog: false, savedBlog: false));
    }
    return list;
  }

  Future<List<BlogModel>> getDraftsBlogs() async {
    final list = <BlogModel>[];
    final res = await FirebaseFirestore.instance
        .collection('BloggerProfile')
        .doc(_uid)
        .collection("Drafts")
        .get();
    for (final i in res.docs) {
      list.add(BlogModel.fromMap(snap: i, sawBlog: false, savedBlog: false));
    }
    return list;
  }

  //BloggerProfile -> collection
  //bloggerId -> doc (current user id) -> then drafts/trash collection

  Future<void> addSavedBlogsInFirebase(
      BlogModel model, String collection) async {
    await FirebaseFirestore.instance
        //.collection("root")
        //.doc(_uid)
        .collection(collection)
        .doc(model.blogId)
        .set(model.savedAndPinnedBlogsToMap());
  }

  Future<List<BlogModel>> getTrashBlogs() async {
    final list = <BlogModel>[];
    final res = await FirebaseFirestore.instance
        .collection('BloggerProfile')
        .doc(_uid)
        .collection("Trash")
        .get();
    for (final i in res.docs) {
      list.add(BlogModel.fromMap(snap: i, sawBlog: false, savedBlog: false));
    }
    return list;
  }

  //-------Check Saved Blog is present From Firebase--------------------------------------------//
  Future<bool> getSavedBlogFromFirebase(String blogId) async {
    return (await FirebaseFirestore.instance
            /* .collection("root")
            .doc(_uid) */
            .collection("SavedArticles")
            .doc(blogId)
            .get())
        .exists;
  }

  //-------Check Viewed Blog is present From Firebase--------------------------------------------//
  Future<bool> getViewedBlogFromFirebase(String blogId) async {
    return (await FirebaseFirestore.instance
            /* .collection("root")
            .doc(_uid) */
            .collection("ViewedArticles")
            .doc(blogId)
            .get())
        .exists;
  }

  //-------Publish Blogs that has already been unpublished in firebase--------------------------------------------//
  Future<void> publishBlogInFirebase(BlogModel model, List<String> tags) async {
    final batch = FirebaseFirestore.instance.batch();

    final batchDoc =
        FirebaseFirestore.instance.collection("Blogs").doc(model.blogId);

    final batchDocExists = (await batchDoc.get()).exists;

    if (batchDocExists) {
      batch.update(batchDoc, {"isPublished": true});
    } else {
      final shareLink = await dynamicLinkServices.createBlogsDynamicLink(
          blogId: model.blogId);
      batch
        ..delete(FirebaseFirestore.instance
            .collection("BloggerProfile")
            .doc(_uid)
            .collection("Drafts")
            .doc(model.blogId))
        ..set(batchDoc, model.savedAndPinnedBlogsToMap())
        ..update(batchDoc,
            {"isPublished": true, "tags": tags, "shareLink": shareLink});
    }

    await batch.commit();
  }

  //-----------------Upload Thumbnail to firebase------------------//
  Future<String> uploadThumbnailToStorage(File file) async {
    final thumbNail = const Uuid().v4();
    final metadata = SettableMetadata(contentType: "image/jpeg");
    final storageRef = FirebaseStorage.instance.ref('Blogs/$_uid');
    final uploadTask =
        await storageRef.child("$thumbNail.jpg").putFile(file, metadata);
    final url = uploadTask.ref.getDownloadURL();
    return url;
  }

  //-----------------Upload Images to firebase------------------//
  Future<String> uploadImagesToStorage(File file) async {
    final image = const Uuid().v4();
    final metadata = SettableMetadata(contentType: "image/jpeg");
    final storageRef = FirebaseStorage.instance.ref('Blogs/$_uid/Images');
    final uploadTask =
        await storageRef.child("$image.jpg").putFile(file, metadata);
    final url = uploadTask.ref.getDownloadURL();
    return url;
  }

  //-------Create draft doc in Firebase--------------------------------------------//
  Future<String> createBlogDoc(
      BloggerProfileModel model, String headline) async {
    String draftId = "";
    await FirebaseFirestore.instance
        .collection("BloggerProfile")
        .doc(_uid)
        .collection("Drafts")
        .add({
      "createdAt": Timestamp.now(),
      "bloggerUid": _uid,
      "bloggerName": model.name,
      "bloggerImgUrl": model.imgUrl,
      "bloggerUserName": model.userName,
      "followersCount": model.followersCount,
      if (headline.isNotEmpty) "headline": headline
    }).then((value) {
      draftId = value.id;
    });
    return draftId;
  }

  //-------Add Headline/Thumbnail in Firebase--------------------------------------------//
  Future<void> addHeadlineOrThumbNailForBlog(
      String headline, String thumbNail, String draftId) async {
    await FirebaseFirestore.instance
        .collection("BloggerProfile")
        .doc(_uid)
        .collection("Drafts")
        .doc(draftId)
        .update({
      if (headline.isNotEmpty) "headline": headline,
      if (thumbNail.isNotEmpty) "thumbNail": thumbNail,
    });
  }

  //-------Add Content To the blog--------------------------------------------//
  Future<void> addContentToBlog(
    String draftId,
    String content,
    int wordCount,
    int imageCount,
    int linkCount,
    int ytVideosCount,
    String textOnlyContent,
  ) async {
    await FirebaseFirestore.instance
        .collection("BloggerProfile")
        .doc(_uid)
        .collection("Drafts")
        .doc(draftId)
        .update({
      "content": content,
      "wordCount": wordCount,
      "imagesCount": imageCount,
      "linksCount": linkCount,
      "ytVideosCount": ytVideosCount,
      "textOnlyContent": textOnlyContent,
    });
  }

  //-------Update Headline/Thumbnail in Firebase--------------------------------------------//
  Future<void> updateHeadlineOrThumbNailForBlog(
      String draftId,
      String headline,
      String thumbNail,
      // ignore: avoid_positional_boolean_parameters
      bool showThumbNailAtFirstLine) async {
    await FirebaseFirestore.instance
        .collection("BloggerProfile")
        .doc(_uid)
        .collection("Drafts")
        .doc(draftId)
        .update({
      "headline": headline,
      "thumbNail": thumbNail,
      "showThumbNailAtFirstLine": showThumbNailAtFirstLine
    });
  }

  //-------Add Read Time For blog in Firebase--------------------------------------------//
  Future<void> addReadTimeForBlog(String draftId, int readTime) async {
    await FirebaseFirestore.instance
        .collection("BloggerProfile")
        .doc(_uid)
        .collection("Drafts")
        .doc(draftId)
        .update({
      "readTime": readTime,
    });
  }

  Future<BlogModel> getBlogDetailsFromFirebase(String blogId) async {
    final blogDoc =
        await FirebaseFirestore.instance.collection('Blogs').doc(blogId).get();
    final sawBlog = await getViewedBlogFromFirebase(blogDoc.id);
    final savedBlog = await getSavedBlogFromFirebase(blogDoc.id);
    return BlogModel.fromMap(
        snap: blogDoc, sawBlog: sawBlog, savedBlog: savedBlog);
  }

  //-------Check Specific Blogger profile is present From Firebase--------------------------------------------//
  Future<bool> getSpecificBloggerProfileFromFirebase(String uid) async {
    return (await FirebaseFirestore.instance
            .collection("BloggerProfile")
            .doc(uid)
            .get())
        .exists;
  }

  //-------Get Blogger Profile Model is present From Firebase--------------------------------------------//
  Future<BloggerProfileModel> getBloggerProfileDetailsFromFirebase(
      String bloggerId) async {
    final doc = await FirebaseFirestore.instance
        .collection("BloggerProfile")
        .doc(bloggerId)
        .get();
    return BloggerProfileModel.fromMap(snap: doc);
  }

  //-------Move Article to Drafts from firebase--------------------------------------------//
  Future<void> moveBlogToDraftsOrTrash(
      String bloggerId, BlogModel model, bool draftsOrTrash) async {
    final batch = FirebaseFirestore.instance.batch();

    if (!draftsOrTrash) {
      batch.delete(FirebaseFirestore.instance
          .collection("BloggerProfile")
          .doc(bloggerId)
          .collection("Drafts")
          .doc(model.blogId));
    }
    batch.set(
        FirebaseFirestore.instance
            .collection("BloggerProfile")
            .doc(bloggerId)
            .collection(draftsOrTrash ? "Drafts" : "Trash")
            .doc(model.blogId),
        model.savedAndPinnedBlogsToMap());

    await batch.commit();
  }

  //-------Get Draft Details from firebase--------------------------------------------//
  Future<BlogModel> getDraftDetailsFromFirebase(String draftId) async {
    final blogDoc = await FirebaseFirestore.instance
        .collection("BloggerProfile")
        .doc(_uid)
        .collection("Drafts")
        .doc(draftId)
        .get();
    return BlogModel.fromMap(snap: blogDoc, sawBlog: true, savedBlog: true);
  }
}

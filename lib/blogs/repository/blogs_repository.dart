import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../model/blog_model.dart';

class BlogsRepository {
  //final _uid = FirebaseAuth.instance.currentUser!.uid;

  //-------Get All Blogs--------------------------------------------//
  Future<List<BlogModel>> getAllBlogs() async {
    final list = <BlogModel>[];
    final res = await FirebaseFirestore.instance.collection('Blogs').get();
    for (final i in res.docs) {
      list.add(BlogModel.fromMap(snap: i, sawBlog: false, savedBlog: false));
    }
    return list;
  }

  Future<List<BlogModel>> getDraftsBlogs() async {
    final list = <BlogModel>[];
    final res = await FirebaseFirestore.instance.collection('Drafts').get();
    for (final i in res.docs) {
      list.add(BlogModel.fromMap(snap: i, sawBlog: false, savedBlog: false));
    }
    return list;
  }

  //BloggerProfile -> collection
  //bloggerId -> doc (current user id) -> then drafts/trash collection

  Future<void> addSavedBlogsInFirebase(BlogModel model, String collection) async {
    await FirebaseFirestore.instance
        //.collection("root")
        //.doc(_uid)
        .collection(collection)
        .doc(model.blogId)
        .set(model.savedAndPinnedBlogsToMap());
  }

  Future<List<BlogModel>> getTrashBlogs() async {
    final list = <BlogModel>[];
    final res = await FirebaseFirestore.instance.collection('Trash').get();
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

  //-----------------Upload Thumbnail to firebase------------------//
  Future<String> uploadThumbnailToStorage(File file) async {
    final thumbNail = const Uuid().v4();
    final metadata = SettableMetadata(contentType: "image/jpeg");
    //final storageRef = FirebaseStorage.instance.ref('Blogs/$_uid');
    final storageRef = FirebaseStorage.instance.ref('Blogs/');
    final uploadTask =
        await storageRef.child("$thumbNail.jpg").putFile(file, metadata);
    final url = uploadTask.ref.getDownloadURL();
    return url;
  }

  //publish blog to Blogs collection
  Future<String> publishBlogInBlogs() async {
    await FirebaseFirestore.instance
      .collection("Blogs")
      .doc(draftId)
      .update({
        "createdAt" : Timestamp.now(),
        /* "bloggerUid" : _uid,
        "bloggerName": model.name,
        "bloggerImgUrl": model.imgUrl */
      });
    return draftId;
  }

  String draftId = "";
  //-------Creating id for blog in Firebase--------------------------------------------//
  Future<String> createIdForBlog() async {
    await FirebaseFirestore.instance
      /* .collection("BloggerProfile")
      .doc(_uid) */
      .collection("Drafts")
      .add({
        "createdAt" : Timestamp.now(),
        /* "bloggerUid" : _uid,
        "bloggerName": model.name,
        "bloggerImgUrl": model.imgUrl */
      }).then((value){
        draftId = value.id;
      });
    return draftId;
  }

  //add headline or thumbNail in firebase
  Future<void> createAndAddHeadlineOrThumbNailForBlog(String headline, String thumbNail) async {
    await FirebaseFirestore.instance
      /* .collection("BloggerProfile")
      .doc(_uid) */
      .collection("Drafts")
      .doc(draftId)
      .update({
        "blogId" : draftId,
        "showThumbNailAtFirstLine": true,
        if (headline.isNotEmpty) "headline": headline,
        if (thumbNail.isNotEmpty) "thumbNail": thumbNail,
      });
  }

  //-------Add Content To the blog--------------------------------------------//
  Future<void> addContentToBlog(String blogId, String content, String textOnlyContent) async {
    RegExp regExp = RegExp(" ");
    final wordCount = regExp.allMatches(textOnlyContent).length + 1;
    await FirebaseFirestore.instance.collection("Drafts").doc(draftId).update({
      "content": content,
      "wordCount" : wordCount,
      "textOnlyContent" : textOnlyContent
    });
  }

  Future<void> addLinkCount(int ytVideosCount, int linksCount) async {
    await FirebaseFirestore.instance.collection("Drafts").doc(draftId).update({
      "ytVideosCount": ytVideosCount,
      "linksCount" : linksCount,
    });
  }

  Future<void> addImagesCount(int imagesCount) async {
    await FirebaseFirestore.instance.collection("Drafts").doc(draftId).update({
      "imagesCount": imagesCount,
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

  moveBlogToDraftsOrTrash(String bloggerId, BlogModel model, bool draftsOrTrash) {}
}

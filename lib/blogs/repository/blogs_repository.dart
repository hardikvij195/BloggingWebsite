import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/blog_model.dart';

class BlogsRepository {
  //-------Get All Blogs--------------------------------------------//
  Future<List<BlogModel>> getAllBlogs() async {
    final list = <BlogModel>[];
    final res = await FirebaseFirestore.instance.collection('Blogs').get();
    for (final i in res.docs) {
      list.add(BlogModel.fromMap(snap: i, sawBlog: false, savedBlog: false));
    }
    return list;
  }
}

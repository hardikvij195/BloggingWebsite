// ignore_for_file: avoid_positional_boolean_parameters

import 'package:mobx/mobx.dart';
import '../model/blog_model.dart';
import '../repository/blogs_repository.dart';

part 'blogs_store.g.dart';

class BlogsStore = _BlogsStore with _$BlogsStore;

abstract class _BlogsStore with Store {
  final _blogsRepository = BlogsRepository();

  ///To get the latest blogs list initially from firebase
  Future<void> init() async {
    await getBlogsList();
  }

  @observable
  bool fetchingBlogs = false;

  @observable
  ObservableList<BlogModel> blogsList = ObservableList.of([]);

  ///To get the blogs data from firebase initially
  @action
  Future<void> getBlogsList() async {
    fetchingBlogs = true;
    blogsList.clear();
    final list = await _blogsRepository.getAllBlogs();
    for (int i = 0; i < list.length; i++) {
      if (list[i].isPublished) {
        blogsList.add(list[i]);
      }
    }
    fetchingBlogs = false;
  }
}

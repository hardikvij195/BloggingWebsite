// ignore_for_file: avoid_positional_boolean_parameters

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import '../model/blog_model.dart';
import '../model/blogs_image_model.dart';
import '../repository/blogs_repository.dart';

part 'blogs_store.g.dart';

class BlogsStore = _BlogsStore with _$BlogsStore;

abstract class _BlogsStore with Store {
  final _blogsRepository = BlogsRepository();

  ///To get the latest blogs list initially from firebase
  Future<void> init() async {
    await getBlogsList();
    await getDraftsBlogsList();
    await getTrashBlogsList();
  }

  @observable
  bool fetchingBlogs = false;

  @observable
  bool fetchingDraftsBlogs = false;

  @observable
  bool fetchingTrashBlogs = false;
  
  @observable
  bool uploadingBlogThumbNail = false;

  @observable
  bool isPublishClicked = false;

  @observable
  BlogsImageModel blogThumbNail = BlogsImageModel();

  @observable
  ObservableList<BlogModel> blogsList = ObservableList.of([]);

  @observable
  ObservableList<BlogModel> draftsBlogsList = ObservableList.of([]);

  @observable
  ObservableList<BlogModel> trashBlogsList = ObservableList.of([]);

  ///To load the data in firebase
  @observable
  bool savedOrNot = false;

  ///To show error when loading data
  @observable
  bool showErrorWhenLoadingData = false;

  ///To get the blog id when u add headline or thumbNail
  @observable
  String blogUid = "";


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
  
  //To get the draft blogs data from firebase
  @action
  Future<void> getDraftsBlogsList() async {
    fetchingDraftsBlogs = true;
    final list = await _blogsRepository.getDraftsBlogs();
      draftsBlogsList..clear()..addAll(list);
    fetchingDraftsBlogs = false;
  }

  //To get the trash blogs data from firebase
  @action
  Future<void> getTrashBlogsList() async {
    fetchingTrashBlogs = true;
    final list = await _blogsRepository.getTrashBlogs();
      trashBlogsList..clear()..addAll(list);
    fetchingTrashBlogs = false;
  }

  ///To add the saved blogs
  @action
  Future<void> addSavedBlogsInFirebase(BlogModel model, String collection) async {
    await _blogsRepository.addSavedBlogsInFirebase(model, collection);
  }

  @action
  Future<void> createIdForBlog() async {
    try {
      savedOrNot = true;
      blogUid = await _blogsRepository
          .createIdForBlog();
      savedOrNot = false;
      
    } on Exception catch (_) {
      showErrorWhenLoadingData = true;
    }
  }

  //add headline or thumbNail to blog
  @action
  Future<void> createAndAddHeadlineOrThumbNailForBlog(String headline, String thumbNail) async {
    try {
      savedOrNot = true;
      String thumbNailUrl;
      /* if (thumbNail != null) {
        thumbNailUrl = await _blogsRepository
            .uploadThumbnailToStorage(thumbNail);
      } */
      await _blogsRepository.createAndAddHeadlineOrThumbNailForBlog(headline, thumbNail);
      savedOrNot = false;
    } on Exception catch (_) {
      showErrorWhenLoadingData = true;
    }
  }

  //add content to blog
  @action
  Future<void> addContentToBlog(String content, String textOnlyContent) async {
    try {
      savedOrNot = true;
      await _blogsRepository.addContentToBlog(blogUid, content, textOnlyContent);
      savedOrNot = false;
    } on Exception catch (_) {
      showErrorWhenLoadingData = true;
    }
  }

  //add images count to blog
  @action
  Future<void> addLinkCount(int ytVideosCount, int linksCount) async {
    try {
      savedOrNot = true;
      await _blogsRepository.addLinkCount(ytVideosCount, linksCount);
      savedOrNot = false;
    } on Exception catch (_) {
      showErrorWhenLoadingData = true;
    }
  }

  //add links to blog
  @action
  Future<void> addImagesCount(int imagesCount) async {
    try {
      savedOrNot = true;
      await _blogsRepository.addImagesCount(imagesCount);
      savedOrNot = false;
    } on Exception catch (_) {
      showErrorWhenLoadingData = true;
    }
  }

  //-------Move Article to Drafts from firebase--------------------------------------------//
  Future<void> moveBlogToDraftsOrTrash(
      String bloggerId, BlogModel model, bool draftsOrTrash) async {
    await FirebaseFirestore.instance
        // .collection("BloggerProfile")
        // .doc(bloggerId)
        .collection(draftsOrTrash ? "Drafts" : "Trash")
        .doc(model.blogId)
        .set(model.savedAndPinnedBlogsToMap());
  }

  ///To move the blog to drafts/trash
  @action
  Future<void> moveArticleToDraftsOrTrash(
      String bloggerId, String blogId, bool draftsOrTrash) async {
    final model = await _blogsRepository.getBlogDetailsFromFirebase(blogId);
    await _blogsRepository.moveBlogToDraftsOrTrash(
        bloggerId, model, draftsOrTrash);
  }

  bool get blogThumbNailUploading {
    if (isPublishClicked) {
      if (uploadingBlogThumbNail == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

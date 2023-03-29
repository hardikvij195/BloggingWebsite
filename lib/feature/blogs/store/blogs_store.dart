// ignore_for_file: avoid_positional_boolean_parameters, library_private_types_in_public_api

import 'dart:io';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:mobx/mobx.dart';

import '../../../core/helper/firebase_helper.dart';
import '../model/blog_model.dart';
import '../model/blogger_profile_model.dart';
import '../model/blogs_image_model.dart';
import '../model/social_media_model.dart';
import '../repository/blogs_repository.dart';

part 'blogs_store.g.dart';

class BlogsStore = _BlogsStore with _$BlogsStore;

abstract class _BlogsStore with Store {
  final _blogsRepository = BlogsRepository();

  ///To get the latest blogs list initially from firebase
  Future<void> init() async {
    await getBlogsList();
  }

  String missingNameOrUrlForSocialMedia(int index) {
    switch (index) {
      case 0:
        return "Facebook";
      case 1:
        return "Instagram";
      case 2:
        return "Twitter";
      case 3:
        return "LinkedIn";
    }
    return "";
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
    draftsBlogsList
      ..clear()
      ..addAll(list);
    fetchingDraftsBlogs = false;
  }

  //To get the trash blogs data from firebase
  @action
  Future<void> getTrashBlogsList() async {
    fetchingTrashBlogs = true;
    final list = await _blogsRepository.getTrashBlogs();
    trashBlogsList
      ..clear()
      ..addAll(list);
    fetchingTrashBlogs = false;
  }

  ///To add the saved blogs
  @action
  Future<void> addSavedBlogsInFirebase(
      BlogModel model, String collection) async {
    await _blogsRepository.addSavedBlogsInFirebase(model, collection);
  }

  ///To get the social media links list
  @observable
  ObservableList<SocialMediaModel> socialMediaList = ObservableList.of([]);

  @observable
  bool uploadingData = true;

  //-------------upload blogger dp starts-------------------------------------------//
  @observable
  BlogsImageModel bloggerDp = BlogsImageModel();

  @observable
  bool uploadingBloggerDp = false;

  @observable
  bool isSubmitClicked = false;

  @computed
  bool get bloggerDpUploading {
    if (isSubmitClicked) {
      if (uploadingBloggerDp == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

//-------------upload blogger dp ends-------------------------------------------//

  ///To get the blogger name
  @observable
  String bloggerName = "";

  ///To get blogger desc
  @observable
  String aboutMe = "";

  ///To upload the blogger data in firebase
  @action
  Future<void> uploadBloggerDetails(File? imgFile, String dpUrl) async {
    String url = "";
    if (imgFile == null) {
      url = dpUrl;
    } else {
      url = await _blogsRepository.uploadBloggerDpToStorage(imgFile);
    }

    await _blogsRepository.uploadBloggerDataToFirebase(
        url, bloggerName, aboutMe, socialMediaList);
  }

  ///To update the blogger data in firebase
  @action
  Future<void> updateBloggerDetails(
      File? imgFile, String dpUrl, String bloggerName, String aboutMe) async {
    String url = "";
    if (imgFile == null) {
      url = dpUrl;
    } else {
      url = await _blogsRepository.uploadBloggerDpToStorage(imgFile);
    }

    await _blogsRepository.updateBloggerDataToFirebase(
        url, bloggerName, aboutMe, socialMediaList);
  }

  @observable
  bool fetchingPinnedAndArticlesPublishedByAuthor = false;

  @observable
  ObservableList<BlogModel> latestArticlesByAuthorList = ObservableList.of([]);

  ///To get the pinned and latest article by author
  @action
  Future<void> getPinnedAndLatestArticlesByAuthor(String uid) async {
    fetchingPinnedAndArticlesPublishedByAuthor = true;
    final list = await _blogsRepository.getBlogsPublishedByAuthor(uid: uid);
    latestArticlesByAuthorList
      ..clear()
      ..addAll(list);
    fetchingPinnedAndArticlesPublishedByAuthor = false;
  }

  /// for getting pagination state
  @observable
  bool publishedBlogsPagination = false;

  /// for getting more published blogs
  @action
  Future<void> getMorePublishedBlogs(String uid) async {
    if (!publishedBlogsPagination) {
      publishedBlogsPagination = true;

      try {
        final list = await _blogsRepository.getBlogsPublishedByAuthor(
          uid: uid,
          startDoc: latestArticlesByAuthorList.last.doc,
        );
        latestArticlesByAuthorList.addAll(list);
      } finally {
        publishedBlogsPagination = false;
      }
    }
  }

  //-------------create/edit article start-------------------------------------------//

  ///To get the draft id when u add headline or thumbNail
  String draftId = "";

  ///To get the word count based on the content added
  int wordCount = 0;

  ///To get the images count when images are getting added
  int imageCount = 0;

  ///To get the links count when links are getting added
  int linksCount = 0;

  ///To get the yt videos count when yt videos are getting added
  int ytVideosCount = 0;

  ///To add the link to this text
  String addLinkToText = "";

  ///Url of [addLinkToText]
  String linkUrl = "";

  ///Url of yt
  String youtubeUrl = "";

  ///To show error text when some other link is added instead of yt video link
  @observable
  bool showErrorText = false;

  ///To load the data in firebase
  @observable
  bool savedOrNot = false;

  ///To get the last known time
  @observable
  DateTime lastKnownTime = DateTime.now();

  ///To get how many mins passed since last update in string
  @observable
  String timePassed = "";

  ///To show error when loading data
  @observable
  bool showErrorWhenLoadingData = false;

  ///To lock/unlock the blog section
  @observable
  bool isLocked = false;

  ///Uploading images to firebase storage
  @observable
  bool uploadingImages = false;

  ///To show thumbnail or not at the start
  @observable
  bool showThumbNailAtTheStart = false;

  ///To get the tags list
  @observable
  ObservableList<String> tagsList = ObservableList.of([]);

  @observable
  bool makeBlogPublished = false;

  @observable
  bool checkBlogInternetConn = false;

  @observable
  bool uploadingHeadlineAndThumbNail = false;

  @observable
  bool slowInternetConn = false;

  @observable
  bool creatingBlogDoc = false;

  @action
  Future<void> createBlog(BloggerProfileModel model, String headline) async {
    draftId = await _blogsRepository.createBlogDoc(model, headline);
  }

  @action
  Future<void> addHeadlineOrThumbNailForBlog(String headline,
      File? thumNailFile, String thumbNail, BloggerProfileModel model) async {
    String thumbNailUrl = "";
    try {
      uploadingHeadlineAndThumbNail = true;
      if (thumNailFile != null) {
        thumbNailUrl =
            await _blogsRepository.uploadThumbnailToStorage(thumNailFile);
      } else {
        thumbNailUrl = thumbNail;
      }
      if (draftId.isEmpty) {
        await createBlog(model, headline);
      }
      await _blogsRepository.addHeadlineOrThumbNailForBlog(
          headline, thumbNailUrl, draftId);
      uploadingHeadlineAndThumbNail = false;
      slowInternetConn = false;
    } on Exception catch (_) {
      showErrorWhenLoadingData = true;
    }
  }

  @action
  Future<void> addContentToBlog(String content, String textOnlyContent) async {
    try {
      savedOrNot = true;
      await _blogsRepository.addContentToBlog(draftId, content, wordCount,
          imageCount, linksCount, ytVideosCount, textOnlyContent);
      lastKnownTime = DateTime.now();
      savedOrNot = false;
    } on Exception catch (_) {
      showErrorWhenLoadingData = true;
    }
  }

  ///To add read time and get the drafts data from its coll
  @action
  Future<BlogModel> getDraftArticlesData() async {
    return _blogsRepository.getDraftDetailsFromFirebase(draftId);
  }

  ///To add read time and get the drafts data from its coll
  @action
  Future<BlogModel> addReadTimeAndGetDraftArticlesData() async {
    final readTime = (wordCount / 200).round();
    await _blogsRepository.addReadTimeForBlog(draftId, readTime);
    return getDraftArticlesData();
  }

  ///To upload the images to firebase storage
  @action
  Future<void> uploadImage(File file, HtmlEditorController controller) async {
    try {
      uploadingImages = true;
      final url = await _blogsRepository.uploadImagesToStorage(file);
      controller.insertNetworkImage(url);
      imageCount++;
      lastKnownTime = DateTime.now();
      uploadingImages = false;
    } on Exception catch (_) {
      showErrorWhenLoadingData = true;
    }
  }

  ///To update the headline and thumbnail
  @action
  Future<void> updateHeadlineOrThumbNailForBlog(
      String headline, File? thumNailFile, String thumbNail) async {
    String thumbNailUrl = "";
    try {
      uploadingHeadlineAndThumbNail = true;
      if (thumNailFile != null) {
        thumbNailUrl =
            await _blogsRepository.uploadThumbnailToStorage(thumNailFile);
      } else {
        thumbNailUrl = thumbNail;
      }
      await _blogsRepository.updateHeadlineOrThumbNailForBlog(
          draftId, headline, thumbNailUrl, showThumbNailAtTheStart);
      uploadingHeadlineAndThumbNail = false;
      slowInternetConn = false;
    } on Exception catch (_) {
      showErrorWhenLoadingData = true;
    }
  }

  @action
  void disposeCreateArticleVariables() {
    draftId = "";
    wordCount = 0;
    imageCount = 0;
    linksCount = 0;
    ytVideosCount = 0;
    addLinkToText = "";
    linkUrl = "";
    youtubeUrl = "";
    showErrorText = false;
    savedOrNot = false;
    lastKnownTime = DateTime.now();
    timePassed = "";
    showErrorWhenLoadingData = false;
    isLocked = false;
    uploadingImages = false;
    showThumbNailAtTheStart = false;
    uploadingHeadlineAndThumbNail = false;
    slowInternetConn = false;
  }

//-------------create/edit article article ends-------------------------------------------//

  //-------Move Article to Drafts from firebase--------------------------------------------//

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

  ///To navigate to blogger info once created
  @observable
  bool bloggerInfo = false;

  @observable
  bool fetchingBlogProfile = false;

  BloggerProfileModel? model;

  ///To get the blogger details
  @action
  Future<void> getBloggerDetails() async {
    fetchingBlogProfile = true;
    try {
      if (bloggerInfo) {
        model = await _blogsRepository
            .getBloggerProfileDetailsFromFirebase(getUserUid());
      } else {
        final blogProfileExists = await _blogsRepository
            .getSpecificBloggerProfileFromFirebase(getUserUid());
        if (blogProfileExists) {
          bloggerInfo = true;
          model = await _blogsRepository
              .getBloggerProfileDetailsFromFirebase(getUserUid());
        } else {
          bloggerInfo = false;
        }
      }
    } finally {
      fetchingBlogProfile = false;
    }
  }
}

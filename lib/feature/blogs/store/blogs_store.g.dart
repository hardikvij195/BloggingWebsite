// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blogs_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BlogsStore on _BlogsStore, Store {
  Computed<bool>? _$bloggerDpUploadingComputed;

  @override
  bool get bloggerDpUploading => (_$bloggerDpUploadingComputed ??=
          Computed<bool>(() => super.bloggerDpUploading,
              name: '_BlogsStore.bloggerDpUploading'))
      .value;

  late final _$fetchingBlogsAtom =
      Atom(name: '_BlogsStore.fetchingBlogs', context: context);

  @override
  bool get fetchingBlogs {
    _$fetchingBlogsAtom.reportRead();
    return super.fetchingBlogs;
  }

  @override
  set fetchingBlogs(bool value) {
    _$fetchingBlogsAtom.reportWrite(value, super.fetchingBlogs, () {
      super.fetchingBlogs = value;
    });
  }

  late final _$fetchingDraftsBlogsAtom =
      Atom(name: '_BlogsStore.fetchingDraftsBlogs', context: context);

  @override
  bool get fetchingDraftsBlogs {
    _$fetchingDraftsBlogsAtom.reportRead();
    return super.fetchingDraftsBlogs;
  }

  @override
  set fetchingDraftsBlogs(bool value) {
    _$fetchingDraftsBlogsAtom.reportWrite(value, super.fetchingDraftsBlogs, () {
      super.fetchingDraftsBlogs = value;
    });
  }

  late final _$fetchingTrashBlogsAtom =
      Atom(name: '_BlogsStore.fetchingTrashBlogs', context: context);

  @override
  bool get fetchingTrashBlogs {
    _$fetchingTrashBlogsAtom.reportRead();
    return super.fetchingTrashBlogs;
  }

  @override
  set fetchingTrashBlogs(bool value) {
    _$fetchingTrashBlogsAtom.reportWrite(value, super.fetchingTrashBlogs, () {
      super.fetchingTrashBlogs = value;
    });
  }

  late final _$uploadingBlogThumbNailAtom =
      Atom(name: '_BlogsStore.uploadingBlogThumbNail', context: context);

  @override
  bool get uploadingBlogThumbNail {
    _$uploadingBlogThumbNailAtom.reportRead();
    return super.uploadingBlogThumbNail;
  }

  @override
  set uploadingBlogThumbNail(bool value) {
    _$uploadingBlogThumbNailAtom
        .reportWrite(value, super.uploadingBlogThumbNail, () {
      super.uploadingBlogThumbNail = value;
    });
  }

  late final _$isPublishClickedAtom =
      Atom(name: '_BlogsStore.isPublishClicked', context: context);

  @override
  bool get isPublishClicked {
    _$isPublishClickedAtom.reportRead();
    return super.isPublishClicked;
  }

  @override
  set isPublishClicked(bool value) {
    _$isPublishClickedAtom.reportWrite(value, super.isPublishClicked, () {
      super.isPublishClicked = value;
    });
  }

  late final _$blogThumbNailAtom =
      Atom(name: '_BlogsStore.blogThumbNail', context: context);

  @override
  BlogsImageModel get blogThumbNail {
    _$blogThumbNailAtom.reportRead();
    return super.blogThumbNail;
  }

  @override
  set blogThumbNail(BlogsImageModel value) {
    _$blogThumbNailAtom.reportWrite(value, super.blogThumbNail, () {
      super.blogThumbNail = value;
    });
  }

  late final _$blogsListAtom =
      Atom(name: '_BlogsStore.blogsList', context: context);

  @override
  ObservableList<BlogModel> get blogsList {
    _$blogsListAtom.reportRead();
    return super.blogsList;
  }

  @override
  set blogsList(ObservableList<BlogModel> value) {
    _$blogsListAtom.reportWrite(value, super.blogsList, () {
      super.blogsList = value;
    });
  }

  late final _$draftsBlogsListAtom =
      Atom(name: '_BlogsStore.draftsBlogsList', context: context);

  @override
  ObservableList<BlogModel> get draftsBlogsList {
    _$draftsBlogsListAtom.reportRead();
    return super.draftsBlogsList;
  }

  @override
  set draftsBlogsList(ObservableList<BlogModel> value) {
    _$draftsBlogsListAtom.reportWrite(value, super.draftsBlogsList, () {
      super.draftsBlogsList = value;
    });
  }

  late final _$trashBlogsListAtom =
      Atom(name: '_BlogsStore.trashBlogsList', context: context);

  @override
  ObservableList<BlogModel> get trashBlogsList {
    _$trashBlogsListAtom.reportRead();
    return super.trashBlogsList;
  }

  @override
  set trashBlogsList(ObservableList<BlogModel> value) {
    _$trashBlogsListAtom.reportWrite(value, super.trashBlogsList, () {
      super.trashBlogsList = value;
    });
  }

  late final _$socialMediaListAtom =
      Atom(name: '_BlogsStore.socialMediaList', context: context);

  @override
  ObservableList<SocialMediaModel> get socialMediaList {
    _$socialMediaListAtom.reportRead();
    return super.socialMediaList;
  }

  @override
  set socialMediaList(ObservableList<SocialMediaModel> value) {
    _$socialMediaListAtom.reportWrite(value, super.socialMediaList, () {
      super.socialMediaList = value;
    });
  }

  late final _$uploadingDataAtom =
      Atom(name: '_BlogsStore.uploadingData', context: context);

  @override
  bool get uploadingData {
    _$uploadingDataAtom.reportRead();
    return super.uploadingData;
  }

  @override
  set uploadingData(bool value) {
    _$uploadingDataAtom.reportWrite(value, super.uploadingData, () {
      super.uploadingData = value;
    });
  }

  late final _$bloggerDpAtom =
      Atom(name: '_BlogsStore.bloggerDp', context: context);

  @override
  BlogsImageModel get bloggerDp {
    _$bloggerDpAtom.reportRead();
    return super.bloggerDp;
  }

  @override
  set bloggerDp(BlogsImageModel value) {
    _$bloggerDpAtom.reportWrite(value, super.bloggerDp, () {
      super.bloggerDp = value;
    });
  }

  late final _$uploadingBloggerDpAtom =
      Atom(name: '_BlogsStore.uploadingBloggerDp', context: context);

  @override
  bool get uploadingBloggerDp {
    _$uploadingBloggerDpAtom.reportRead();
    return super.uploadingBloggerDp;
  }

  @override
  set uploadingBloggerDp(bool value) {
    _$uploadingBloggerDpAtom.reportWrite(value, super.uploadingBloggerDp, () {
      super.uploadingBloggerDp = value;
    });
  }

  late final _$isSubmitClickedAtom =
      Atom(name: '_BlogsStore.isSubmitClicked', context: context);

  @override
  bool get isSubmitClicked {
    _$isSubmitClickedAtom.reportRead();
    return super.isSubmitClicked;
  }

  @override
  set isSubmitClicked(bool value) {
    _$isSubmitClickedAtom.reportWrite(value, super.isSubmitClicked, () {
      super.isSubmitClicked = value;
    });
  }

  late final _$bloggerNameAtom =
      Atom(name: '_BlogsStore.bloggerName', context: context);

  @override
  String get bloggerName {
    _$bloggerNameAtom.reportRead();
    return super.bloggerName;
  }

  @override
  set bloggerName(String value) {
    _$bloggerNameAtom.reportWrite(value, super.bloggerName, () {
      super.bloggerName = value;
    });
  }

  late final _$aboutMeAtom =
      Atom(name: '_BlogsStore.aboutMe', context: context);

  @override
  String get aboutMe {
    _$aboutMeAtom.reportRead();
    return super.aboutMe;
  }

  @override
  set aboutMe(String value) {
    _$aboutMeAtom.reportWrite(value, super.aboutMe, () {
      super.aboutMe = value;
    });
  }

  late final _$fetchingPinnedAndArticlesPublishedByAuthorAtom = Atom(
      name: '_BlogsStore.fetchingPinnedAndArticlesPublishedByAuthor',
      context: context);

  @override
  bool get fetchingPinnedAndArticlesPublishedByAuthor {
    _$fetchingPinnedAndArticlesPublishedByAuthorAtom.reportRead();
    return super.fetchingPinnedAndArticlesPublishedByAuthor;
  }

  @override
  set fetchingPinnedAndArticlesPublishedByAuthor(bool value) {
    _$fetchingPinnedAndArticlesPublishedByAuthorAtom.reportWrite(
        value, super.fetchingPinnedAndArticlesPublishedByAuthor, () {
      super.fetchingPinnedAndArticlesPublishedByAuthor = value;
    });
  }

  late final _$latestArticlesByAuthorListAtom =
      Atom(name: '_BlogsStore.latestArticlesByAuthorList', context: context);

  @override
  ObservableList<BlogModel> get latestArticlesByAuthorList {
    _$latestArticlesByAuthorListAtom.reportRead();
    return super.latestArticlesByAuthorList;
  }

  @override
  set latestArticlesByAuthorList(ObservableList<BlogModel> value) {
    _$latestArticlesByAuthorListAtom
        .reportWrite(value, super.latestArticlesByAuthorList, () {
      super.latestArticlesByAuthorList = value;
    });
  }

  late final _$publishedBlogsPaginationAtom =
      Atom(name: '_BlogsStore.publishedBlogsPagination', context: context);

  @override
  bool get publishedBlogsPagination {
    _$publishedBlogsPaginationAtom.reportRead();
    return super.publishedBlogsPagination;
  }

  @override
  set publishedBlogsPagination(bool value) {
    _$publishedBlogsPaginationAtom
        .reportWrite(value, super.publishedBlogsPagination, () {
      super.publishedBlogsPagination = value;
    });
  }

  late final _$showErrorTextAtom =
      Atom(name: '_BlogsStore.showErrorText', context: context);

  @override
  bool get showErrorText {
    _$showErrorTextAtom.reportRead();
    return super.showErrorText;
  }

  @override
  set showErrorText(bool value) {
    _$showErrorTextAtom.reportWrite(value, super.showErrorText, () {
      super.showErrorText = value;
    });
  }

  late final _$savedOrNotAtom =
      Atom(name: '_BlogsStore.savedOrNot', context: context);

  @override
  bool get savedOrNot {
    _$savedOrNotAtom.reportRead();
    return super.savedOrNot;
  }

  @override
  set savedOrNot(bool value) {
    _$savedOrNotAtom.reportWrite(value, super.savedOrNot, () {
      super.savedOrNot = value;
    });
  }

  late final _$lastKnownTimeAtom =
      Atom(name: '_BlogsStore.lastKnownTime', context: context);

  @override
  DateTime get lastKnownTime {
    _$lastKnownTimeAtom.reportRead();
    return super.lastKnownTime;
  }

  @override
  set lastKnownTime(DateTime value) {
    _$lastKnownTimeAtom.reportWrite(value, super.lastKnownTime, () {
      super.lastKnownTime = value;
    });
  }

  late final _$timePassedAtom =
      Atom(name: '_BlogsStore.timePassed', context: context);

  @override
  String get timePassed {
    _$timePassedAtom.reportRead();
    return super.timePassed;
  }

  @override
  set timePassed(String value) {
    _$timePassedAtom.reportWrite(value, super.timePassed, () {
      super.timePassed = value;
    });
  }

  late final _$showErrorWhenLoadingDataAtom =
      Atom(name: '_BlogsStore.showErrorWhenLoadingData', context: context);

  @override
  bool get showErrorWhenLoadingData {
    _$showErrorWhenLoadingDataAtom.reportRead();
    return super.showErrorWhenLoadingData;
  }

  @override
  set showErrorWhenLoadingData(bool value) {
    _$showErrorWhenLoadingDataAtom
        .reportWrite(value, super.showErrorWhenLoadingData, () {
      super.showErrorWhenLoadingData = value;
    });
  }

  late final _$isLockedAtom =
      Atom(name: '_BlogsStore.isLocked', context: context);

  @override
  bool get isLocked {
    _$isLockedAtom.reportRead();
    return super.isLocked;
  }

  @override
  set isLocked(bool value) {
    _$isLockedAtom.reportWrite(value, super.isLocked, () {
      super.isLocked = value;
    });
  }

  late final _$uploadingImagesAtom =
      Atom(name: '_BlogsStore.uploadingImages', context: context);

  @override
  bool get uploadingImages {
    _$uploadingImagesAtom.reportRead();
    return super.uploadingImages;
  }

  @override
  set uploadingImages(bool value) {
    _$uploadingImagesAtom.reportWrite(value, super.uploadingImages, () {
      super.uploadingImages = value;
    });
  }

  late final _$showThumbNailAtTheStartAtom =
      Atom(name: '_BlogsStore.showThumbNailAtTheStart', context: context);

  @override
  bool get showThumbNailAtTheStart {
    _$showThumbNailAtTheStartAtom.reportRead();
    return super.showThumbNailAtTheStart;
  }

  @override
  set showThumbNailAtTheStart(bool value) {
    _$showThumbNailAtTheStartAtom
        .reportWrite(value, super.showThumbNailAtTheStart, () {
      super.showThumbNailAtTheStart = value;
    });
  }

  late final _$tagsListAtom =
      Atom(name: '_BlogsStore.tagsList', context: context);

  @override
  ObservableList<String> get tagsList {
    _$tagsListAtom.reportRead();
    return super.tagsList;
  }

  @override
  set tagsList(ObservableList<String> value) {
    _$tagsListAtom.reportWrite(value, super.tagsList, () {
      super.tagsList = value;
    });
  }

  late final _$makeBlogPublishedAtom =
      Atom(name: '_BlogsStore.makeBlogPublished', context: context);

  @override
  bool get makeBlogPublished {
    _$makeBlogPublishedAtom.reportRead();
    return super.makeBlogPublished;
  }

  @override
  set makeBlogPublished(bool value) {
    _$makeBlogPublishedAtom.reportWrite(value, super.makeBlogPublished, () {
      super.makeBlogPublished = value;
    });
  }

  late final _$checkBlogInternetConnAtom =
      Atom(name: '_BlogsStore.checkBlogInternetConn', context: context);

  @override
  bool get checkBlogInternetConn {
    _$checkBlogInternetConnAtom.reportRead();
    return super.checkBlogInternetConn;
  }

  @override
  set checkBlogInternetConn(bool value) {
    _$checkBlogInternetConnAtom.reportWrite(value, super.checkBlogInternetConn,
        () {
      super.checkBlogInternetConn = value;
    });
  }

  late final _$uploadingHeadlineAndThumbNailAtom =
      Atom(name: '_BlogsStore.uploadingHeadlineAndThumbNail', context: context);

  @override
  bool get uploadingHeadlineAndThumbNail {
    _$uploadingHeadlineAndThumbNailAtom.reportRead();
    return super.uploadingHeadlineAndThumbNail;
  }

  @override
  set uploadingHeadlineAndThumbNail(bool value) {
    _$uploadingHeadlineAndThumbNailAtom
        .reportWrite(value, super.uploadingHeadlineAndThumbNail, () {
      super.uploadingHeadlineAndThumbNail = value;
    });
  }

  late final _$slowInternetConnAtom =
      Atom(name: '_BlogsStore.slowInternetConn', context: context);

  @override
  bool get slowInternetConn {
    _$slowInternetConnAtom.reportRead();
    return super.slowInternetConn;
  }

  @override
  set slowInternetConn(bool value) {
    _$slowInternetConnAtom.reportWrite(value, super.slowInternetConn, () {
      super.slowInternetConn = value;
    });
  }

  late final _$creatingBlogDocAtom =
      Atom(name: '_BlogsStore.creatingBlogDoc', context: context);

  @override
  bool get creatingBlogDoc {
    _$creatingBlogDocAtom.reportRead();
    return super.creatingBlogDoc;
  }

  @override
  set creatingBlogDoc(bool value) {
    _$creatingBlogDocAtom.reportWrite(value, super.creatingBlogDoc, () {
      super.creatingBlogDoc = value;
    });
  }

  late final _$bloggerInfoAtom =
      Atom(name: '_BlogsStore.bloggerInfo', context: context);

  @override
  bool get bloggerInfo {
    _$bloggerInfoAtom.reportRead();
    return super.bloggerInfo;
  }

  @override
  set bloggerInfo(bool value) {
    _$bloggerInfoAtom.reportWrite(value, super.bloggerInfo, () {
      super.bloggerInfo = value;
    });
  }

  late final _$fetchingBlogProfileAtom =
      Atom(name: '_BlogsStore.fetchingBlogProfile', context: context);

  @override
  bool get fetchingBlogProfile {
    _$fetchingBlogProfileAtom.reportRead();
    return super.fetchingBlogProfile;
  }

  @override
  set fetchingBlogProfile(bool value) {
    _$fetchingBlogProfileAtom.reportWrite(value, super.fetchingBlogProfile, () {
      super.fetchingBlogProfile = value;
    });
  }

  late final _$getBlogsListAsyncAction =
      AsyncAction('_BlogsStore.getBlogsList', context: context);

  @override
  Future<void> getBlogsList() {
    return _$getBlogsListAsyncAction.run(() => super.getBlogsList());
  }

  late final _$getDraftsBlogsListAsyncAction =
      AsyncAction('_BlogsStore.getDraftsBlogsList', context: context);

  @override
  Future<void> getDraftsBlogsList() {
    return _$getDraftsBlogsListAsyncAction
        .run(() => super.getDraftsBlogsList());
  }

  late final _$getTrashBlogsListAsyncAction =
      AsyncAction('_BlogsStore.getTrashBlogsList', context: context);

  @override
  Future<void> getTrashBlogsList() {
    return _$getTrashBlogsListAsyncAction.run(() => super.getTrashBlogsList());
  }

  late final _$addSavedBlogsInFirebaseAsyncAction =
      AsyncAction('_BlogsStore.addSavedBlogsInFirebase', context: context);

  @override
  Future<void> addSavedBlogsInFirebase(BlogModel model, String collection) {
    return _$addSavedBlogsInFirebaseAsyncAction
        .run(() => super.addSavedBlogsInFirebase(model, collection));
  }

  late final _$uploadBloggerDetailsAsyncAction =
      AsyncAction('_BlogsStore.uploadBloggerDetails', context: context);

  @override
  Future<void> uploadBloggerDetails(File? imgFile, String dpUrl) {
    return _$uploadBloggerDetailsAsyncAction
        .run(() => super.uploadBloggerDetails(imgFile, dpUrl));
  }

  late final _$updateBloggerDetailsAsyncAction =
      AsyncAction('_BlogsStore.updateBloggerDetails', context: context);

  @override
  Future<void> updateBloggerDetails(
      File? imgFile, String dpUrl, String bloggerName, String aboutMe) {
    return _$updateBloggerDetailsAsyncAction.run(
        () => super.updateBloggerDetails(imgFile, dpUrl, bloggerName, aboutMe));
  }

  late final _$getPinnedAndLatestArticlesByAuthorAsyncAction = AsyncAction(
      '_BlogsStore.getPinnedAndLatestArticlesByAuthor',
      context: context);

  @override
  Future<void> getPinnedAndLatestArticlesByAuthor(String uid) {
    return _$getPinnedAndLatestArticlesByAuthorAsyncAction
        .run(() => super.getPinnedAndLatestArticlesByAuthor(uid));
  }

  late final _$getMorePublishedBlogsAsyncAction =
      AsyncAction('_BlogsStore.getMorePublishedBlogs', context: context);

  @override
  Future<void> getMorePublishedBlogs(String uid) {
    return _$getMorePublishedBlogsAsyncAction
        .run(() => super.getMorePublishedBlogs(uid));
  }

  late final _$createBlogAsyncAction =
      AsyncAction('_BlogsStore.createBlog', context: context);

  @override
  Future<void> createBlog(BloggerProfileModel model, String headline) {
    return _$createBlogAsyncAction.run(() => super.createBlog(model, headline));
  }

  late final _$addHeadlineOrThumbNailForBlogAsyncAction = AsyncAction(
      '_BlogsStore.addHeadlineOrThumbNailForBlog',
      context: context);

  @override
  Future<void> addHeadlineOrThumbNailForBlog(String headline,
      File? thumNailFile, String thumbNail, BloggerProfileModel model) {
    return _$addHeadlineOrThumbNailForBlogAsyncAction.run(() => super
        .addHeadlineOrThumbNailForBlog(
            headline, thumNailFile, thumbNail, model));
  }

  late final _$addContentToBlogAsyncAction =
      AsyncAction('_BlogsStore.addContentToBlog', context: context);

  @override
  Future<void> addContentToBlog(String content, String textOnlyContent) {
    return _$addContentToBlogAsyncAction
        .run(() => super.addContentToBlog(content, textOnlyContent));
  }

  late final _$getDraftArticlesDataAsyncAction =
      AsyncAction('_BlogsStore.getDraftArticlesData', context: context);

  @override
  Future<BlogModel> getDraftArticlesData() {
    return _$getDraftArticlesDataAsyncAction
        .run(() => super.getDraftArticlesData());
  }

  late final _$addReadTimeAndGetDraftArticlesDataAsyncAction = AsyncAction(
      '_BlogsStore.addReadTimeAndGetDraftArticlesData',
      context: context);

  @override
  Future<BlogModel> addReadTimeAndGetDraftArticlesData() {
    return _$addReadTimeAndGetDraftArticlesDataAsyncAction
        .run(() => super.addReadTimeAndGetDraftArticlesData());
  }

  late final _$uploadImageAsyncAction =
      AsyncAction('_BlogsStore.uploadImage', context: context);

  @override
  Future<void> uploadImage(File file, HtmlEditorController controller) {
    return _$uploadImageAsyncAction
        .run(() => super.uploadImage(file, controller));
  }

  late final _$updateHeadlineOrThumbNailForBlogAsyncAction = AsyncAction(
      '_BlogsStore.updateHeadlineOrThumbNailForBlog',
      context: context);

  @override
  Future<void> updateHeadlineOrThumbNailForBlog(
      String headline, File? thumNailFile, String thumbNail) {
    return _$updateHeadlineOrThumbNailForBlogAsyncAction.run(() => super
        .updateHeadlineOrThumbNailForBlog(headline, thumNailFile, thumbNail));
  }

  late final _$moveArticleToDraftsOrTrashAsyncAction =
      AsyncAction('_BlogsStore.moveArticleToDraftsOrTrash', context: context);

  @override
  Future<void> moveArticleToDraftsOrTrash(
      String bloggerId, String blogId, bool draftsOrTrash) {
    return _$moveArticleToDraftsOrTrashAsyncAction.run(() =>
        super.moveArticleToDraftsOrTrash(bloggerId, blogId, draftsOrTrash));
  }

  late final _$getBloggerDetailsAsyncAction =
      AsyncAction('_BlogsStore.getBloggerDetails', context: context);

  @override
  Future<void> getBloggerDetails() {
    return _$getBloggerDetailsAsyncAction.run(() => super.getBloggerDetails());
  }

  late final _$_BlogsStoreActionController =
      ActionController(name: '_BlogsStore', context: context);

  @override
  void disposeCreateArticleVariables() {
    final _$actionInfo = _$_BlogsStoreActionController.startAction(
        name: '_BlogsStore.disposeCreateArticleVariables');
    try {
      return super.disposeCreateArticleVariables();
    } finally {
      _$_BlogsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchingBlogs: ${fetchingBlogs},
fetchingDraftsBlogs: ${fetchingDraftsBlogs},
fetchingTrashBlogs: ${fetchingTrashBlogs},
uploadingBlogThumbNail: ${uploadingBlogThumbNail},
isPublishClicked: ${isPublishClicked},
blogThumbNail: ${blogThumbNail},
blogsList: ${blogsList},
draftsBlogsList: ${draftsBlogsList},
trashBlogsList: ${trashBlogsList},
socialMediaList: ${socialMediaList},
uploadingData: ${uploadingData},
bloggerDp: ${bloggerDp},
uploadingBloggerDp: ${uploadingBloggerDp},
isSubmitClicked: ${isSubmitClicked},
bloggerName: ${bloggerName},
aboutMe: ${aboutMe},
fetchingPinnedAndArticlesPublishedByAuthor: ${fetchingPinnedAndArticlesPublishedByAuthor},
latestArticlesByAuthorList: ${latestArticlesByAuthorList},
publishedBlogsPagination: ${publishedBlogsPagination},
showErrorText: ${showErrorText},
savedOrNot: ${savedOrNot},
lastKnownTime: ${lastKnownTime},
timePassed: ${timePassed},
showErrorWhenLoadingData: ${showErrorWhenLoadingData},
isLocked: ${isLocked},
uploadingImages: ${uploadingImages},
showThumbNailAtTheStart: ${showThumbNailAtTheStart},
tagsList: ${tagsList},
makeBlogPublished: ${makeBlogPublished},
checkBlogInternetConn: ${checkBlogInternetConn},
uploadingHeadlineAndThumbNail: ${uploadingHeadlineAndThumbNail},
slowInternetConn: ${slowInternetConn},
creatingBlogDoc: ${creatingBlogDoc},
bloggerInfo: ${bloggerInfo},
fetchingBlogProfile: ${fetchingBlogProfile},
bloggerDpUploading: ${bloggerDpUploading}
    ''';
  }
}

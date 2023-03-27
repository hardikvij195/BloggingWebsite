// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blogs_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BlogsStore on _BlogsStore, Store {
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

  late final _$blogUidAtom =
      Atom(name: '_BlogsStore.blogUid', context: context);

  @override
  String get blogUid {
    _$blogUidAtom.reportRead();
    return super.blogUid;
  }

  @override
  set blogUid(String value) {
    _$blogUidAtom.reportWrite(value, super.blogUid, () {
      super.blogUid = value;
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

  late final _$createIdForBlogAsyncAction =
      AsyncAction('_BlogsStore.createIdForBlog', context: context);

  @override
  Future<void> createIdForBlog() {
    return _$createIdForBlogAsyncAction.run(() => super.createIdForBlog());
  }

  late final _$createAndAddHeadlineOrThumbNailForBlogAsyncAction = AsyncAction(
      '_BlogsStore.createAndAddHeadlineOrThumbNailForBlog',
      context: context);

  @override
  Future<void> createAndAddHeadlineOrThumbNailForBlog(
      String headline, String thumbNail) {
    return _$createAndAddHeadlineOrThumbNailForBlogAsyncAction.run(() =>
        super.createAndAddHeadlineOrThumbNailForBlog(headline, thumbNail));
  }

  late final _$addContentToBlogAsyncAction =
      AsyncAction('_BlogsStore.addContentToBlog', context: context);

  @override
  Future<void> addContentToBlog(String content, String textOnlyContent) {
    return _$addContentToBlogAsyncAction
        .run(() => super.addContentToBlog(content, textOnlyContent));
  }

  late final _$addLinkCountAsyncAction =
      AsyncAction('_BlogsStore.addLinkCount', context: context);

  @override
  Future<void> addLinkCount(int ytVideosCount, int linksCount) {
    return _$addLinkCountAsyncAction
        .run(() => super.addLinkCount(ytVideosCount, linksCount));
  }

  late final _$addImagesCountAsyncAction =
      AsyncAction('_BlogsStore.addImagesCount', context: context);

  @override
  Future<void> addImagesCount(int imagesCount) {
    return _$addImagesCountAsyncAction
        .run(() => super.addImagesCount(imagesCount));
  }

  late final _$moveArticleToDraftsOrTrashAsyncAction =
      AsyncAction('_BlogsStore.moveArticleToDraftsOrTrash', context: context);

  @override
  Future<void> moveArticleToDraftsOrTrash(
      String bloggerId, String blogId, bool draftsOrTrash) {
    return _$moveArticleToDraftsOrTrashAsyncAction.run(() =>
        super.moveArticleToDraftsOrTrash(bloggerId, blogId, draftsOrTrash));
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
savedOrNot: ${savedOrNot},
showErrorWhenLoadingData: ${showErrorWhenLoadingData},
blogUid: ${blogUid}
    ''';
  }
}

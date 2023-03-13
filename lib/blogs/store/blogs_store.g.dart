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

  late final _$getBlogsListAsyncAction =
      AsyncAction('_BlogsStore.getBlogsList', context: context);

  @override
  Future<void> getBlogsList() {
    return _$getBlogsListAsyncAction.run(() => super.getBlogsList());
  }

  @override
  String toString() {
    return '''
fetchingBlogs: ${fetchingBlogs},
blogsList: ${blogsList}
    ''';
  }
}

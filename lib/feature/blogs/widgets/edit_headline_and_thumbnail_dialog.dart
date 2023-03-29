import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_website/feature/blogs/common/loading_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/helper/image_helper.dart';
import '../../../../core/helper/name_helper.dart';
import '../model/blog_model.dart';
import '../model/blogs_image_model.dart';
import '../store/blogs_store.dart';
import '../store/main_store.dart';

class EditHeadlineAndThumbNailDialog extends StatefulWidget {
  const EditHeadlineAndThumbNailDialog(
      {required this.model, required this.headline, Key? key})
      : super(key: key);
  final BlogModel model;
  final String headline;

  @override
  State<EditHeadlineAndThumbNailDialog> createState() =>
      _EditHeadlineAndThumbNailDialogState();
}

class _EditHeadlineAndThumbNailDialogState
    extends State<EditHeadlineAndThumbNailDialog> {
  late final model = widget.model;
  late final store = context.read<BlogsStore>();
  late final mainStore = context.read<MainStore>();
  final headLineController = TextEditingController();

  @override
  void initState() {
    headLineController.text = widget.headline;
    store
      ..blogThumbNail.imgUrl = model.thumbNail
      ..showThumbNailAtTheStart = model.showThumbNailAtFirstLine;
    super.initState();
  }

  @override
  void dispose() {
    headLineController.dispose();
    store.slowInternetConn = false;
    super.dispose();
  }

  void showActionSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
                final imgPath =
                    await ImageHelper().selectImage(true, imageQuality: 40);
                if (imgPath != null) {
                  store
                    ..uploadingBlogThumbNail = true
                    ..blogThumbNail = BlogsImageModel(
                      imgFile: File(
                        imgPath.path,
                      ),
                    )
                    ..uploadingBlogThumbNail = false;
                }
              },
              child: const Text(
                'Open Photos',
              )),
          CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
                final imgPath =
                    await ImageHelper().selectImage(false, imageQuality: 40);
                if (imgPath != null) {
                  store
                    ..uploadingBlogThumbNail = true
                    ..blogThumbNail = BlogsImageModel(
                      imgFile: File(
                        imgPath.path,
                      ),
                    )
                    ..uploadingBlogThumbNail = false;
                }
              },
              child: const Text(
                'Take Picture',
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Headline & Thumbnail',
                ),
                const SizedBox(height: 30),
                Observer(builder: (_) {
                  if (store.uploadingBlogThumbNail) {
                    return const LoadingScreen();
                  } else if (store.blogThumbNail.imgFile != null) {
                    return _UpdateBlogThumbNail(
                      imgFile: store.blogThumbNail.imgFile!,
                      actionSheet: showActionSheet,
                    );
                  } else {
                    return _ShowUploadedBlogThumbNail(
                      thumbNail: store.blogThumbNail.imgUrl ?? "",
                      actionSheet: showActionSheet,
                    );
                  }
                }),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment(-0.75, 0),
                  child: Text(
                    'Type the headline for your article',
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: headLineController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Please confirm your headline and thumbnail \nbefore you continue.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        height: 20,
                        width: 20,
                        child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Colors.transparent),
                          child: Observer(builder: (_) {
                            return Checkbox(
                              checkColor: Colors.white,
                              value: store.showThumbNailAtTheStart,
                              onChanged: (value) {
                                store.showThumbNailAtTheStart =
                                    !store.showThumbNailAtTheStart;
                              },
                            );
                          }),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Show thumbnail at beginning of \narticle",
                      ),
                    ],
                  ),
                ),
                Observer(builder: (_) {
                  if (store.slowInternetConn) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Text(
                        "Something went wrong. Please check your internet connection.",
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                const SizedBox(height: 30),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 92),
                    child: GestureDetector(
                      onTap: () async {
                        if (model.thumbNail.isEmpty &&
                            store.blogThumbNail.imgFile == null) {
                          await tost(
                              "Please add a thumbnail before proceeding furthur");
                        } else if (headLineController.text.trim().isEmpty ||
                            headLineController.text == "Untitled") {
                          await tost(
                              "Please add a headline before proceeding furthur");
                        } else {
                          await store
                              .updateHeadlineOrThumbNailForBlog(
                            headLineController.text.trim(),
                            store.blogThumbNail.imgFile,
                            model.thumbNail,
                          )
                              .timeout(
                            const Duration(seconds: 20),
                            onTimeout: () {
                              if (!mainStore.isInternetOn ||
                                  store.uploadingHeadlineAndThumbNail) {
                                store
                                  ..uploadingHeadlineAndThumbNail = false
                                  ..slowInternetConn = true;
                              }
                            },
                          );
                          if (!store.slowInternetConn) {
                            final updatedModel =
                                await store.getDraftArticlesData();
                            store.savedOrNot = false;
                            if (store.showErrorWhenLoadingData) {
                              store.uploadingHeadlineAndThumbNail = true;
                            } else {
                              // await Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => Provider.value(
                              //       value: store,
                              //       child: Provider.value(
                              //         value: blogsStore,
                              //         child: Provider.value(
                              //           value: trendingBlogsStore,
                              //           child: Provider.value(
                              //             value: latestBlogsStore,
                              //             child: Provider.value(
                              //               value: mostLikedBlogsStore,
                              //               child: Provider.value(
                              //                 value: myActivityStore,
                              //                 child: Provider.value(
                              //                   value: blogInfoStore,
                              //                   child: PreviewBlogScreen(
                              //                     model: updatedModel,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // );
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 44,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Center(
                          child: Observer(builder: (_) {
                            return Text(
                              store.slowInternetConn ? "Try Again" : 'Confirm',
                            );
                          }),
                        ),
                      ),
                    )),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        Observer(builder: (_) {
          if (store.uploadingHeadlineAndThumbNail) {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey[800],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        LoadingScreen(),
                        SizedBox(height: 20),
                        Text("Uploading Blog ThumbNail And Headline",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                decoration: TextDecoration.none)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        })
      ],
    );
  }
}

class _UpdateBlogThumbNail extends StatelessWidget {
  const _UpdateBlogThumbNail(
      {required this.imgFile, required this.actionSheet, Key? key})
      : super(key: key);
  final File imgFile;
  final VoidCallback actionSheet;
  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: Image.file(imgFile),
          ),
        ),
        Align(
          alignment: const Alignment(0.3, 0),
          child: GestureDetector(
            onTap: () {
              store.blogThumbNail
                ..imgFile = null
                ..imgUrl = null;
              store.blogThumbNail = store.blogThumbNail.copyWith(
                  imgFile: store.blogThumbNail.imgFile,
                  imgUrl: store.blogThumbNail.imgUrl);
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ShowUploadedBlogThumbNail extends StatelessWidget {
  const _ShowUploadedBlogThumbNail(
      {required this.thumbNail, required this.actionSheet, Key? key})
      : super(key: key);
  final String thumbNail;
  final VoidCallback actionSheet;
  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: thumbNail.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(25),
                    child: SvgPicture.asset(
                      "assets/svg/blogs/image.svg",
                      height: 50,
                      width: 50,
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: thumbNail,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider)),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/png/app/mwicon.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        Align(
          alignment: const Alignment(0.3, 0),
          child: GestureDetector(
            onTap: () {
              if (thumbNail.isEmpty) {
                actionSheet();
              } else {
                store.blogThumbNail
                  ..imgFile = null
                  ..imgUrl = null;
                store.blogThumbNail = store.blogThumbNail.copyWith(
                    imgFile: store.blogThumbNail.imgFile,
                    imgUrl: store.blogThumbNail.imgUrl);
              }
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: thumbNail.isEmpty ? Colors.red : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 1.5,
                      color:
                          thumbNail.isEmpty ? Colors.transparent : Colors.red)),
              child: Icon(
                thumbNail.isEmpty ? Icons.add : Icons.close,
                size: 12,
                color: thumbNail.isEmpty ? Colors.white : Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

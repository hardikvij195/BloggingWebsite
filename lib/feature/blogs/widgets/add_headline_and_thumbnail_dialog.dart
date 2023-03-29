import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_website/feature/blogs/common/loading_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/helper/image_helper.dart';
import '../model/blogs_image_model.dart';
import '../store/blogs_store.dart';
import '../store/main_store.dart';

class AddHeadlineAndThumbNailDialog extends StatefulWidget {
  const AddHeadlineAndThumbNailDialog(
      {required this.headLineController, required this.timerChange, Key? key})
      : super(key: key);
  final TextEditingController headLineController;
  final VoidCallback timerChange;
  @override
  State<AddHeadlineAndThumbNailDialog> createState() =>
      _AddHeadlineAndThumbNailDialogState();
}

class _AddHeadlineAndThumbNailDialogState
    extends State<AddHeadlineAndThumbNailDialog> {
  late final store = context.read<BlogsStore>();
  late final mainStore = context.read<MainStore>();
  bool tapped = false;

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
  void initState() {
    store.blogThumbNail
      ..imgFile = null
      ..imgUrl = null;
    super.initState();
  }

  @override
  void dispose() {
    store.slowInternetConn = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blogsStore = context.read<BlogsStore>();
    return Stack(
      children: [
        Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
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
                    return _UploadBlogThumbNail(
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
                    controller: widget.headLineController,
                    onTap: () {
                      if (!tapped) {
                        tapped = true;
                        widget.headLineController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset:
                                widget.headLineController.value.text.length);
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
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
                        await store
                            .addHeadlineOrThumbNailForBlog(
                          widget.headLineController.text.trim(),
                          store.blogThumbNail.imgFile,
                          "",
                          blogsStore.model!,
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
                          if (store.showErrorWhenLoadingData) {
                            store.slowInternetConn = true;
                          } else {
                            if (mounted) {
                              widget.timerChange();
                              Navigator.pop(context);
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
                              store.slowInternetConn ? "Try Again" : 'Ok',
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

class _UploadBlogThumbNail extends StatelessWidget {
  const _UploadBlogThumbNail({required this.actionSheet, Key? key})
      : super(key: key);
  final VoidCallback actionSheet;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              padding: const EdgeInsets.all(25),
              child: SvgPicture.asset(
                "assets/svg/blogs/image.svg",
                height: 50,
                width: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.3, 0),
          child: GestureDetector(
            onTap: actionSheet,
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

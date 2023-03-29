import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:internship_website/core/extension/date_time_extension.dart';
import 'package:internship_website/feature/blogs/common/loading_screen.dart';
import 'package:internship_website/feature/blogs/store/blogs_store.dart';
import 'package:internship_website/feature/blogs/store/main_store.dart';
import 'package:provider/provider.dart';

import '../../../core/helper/image_helper.dart';
import '../model/blog_model.dart';
import '../widgets/add_headline_and_thumbnail_dialog.dart';
import '../widgets/blog_dialogs.dart';
import '../widgets/edit_headline_and_thumbnail_dialog.dart';

class EditBlogScreen extends StatefulWidget {
  const EditBlogScreen({required this.model, Key? key}) : super(key: key);
  final BlogModel model;

  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  late final store = context.read<BlogsStore>();
  late final mainStore = context.read<MainStore>();
  late final model = widget.model;
  final controller = HtmlEditorController();
  final headLineController = TextEditingController();
  Timer? timer;

  void showActionSheet() {
    controller.clearFocus();
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
                  final file = File(imgPath.path);
                  await store.uploadImage(file, controller);
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
                  final file = File(imgPath.path);
                  await store.uploadImage(file, controller);
                }
              },
              child: const Text(
                'Take Picture',
              )),
        ],
      ),
    );
  }

  void initialiseTimer() {
    timer = Timer.periodic(
        DateTime.now().difference(store.lastKnownTime).inMinutes >= 1
            ? const Duration(minutes: 1)
            : const Duration(seconds: 1), (_) {
      store.timePassed = store.lastKnownTime.timeAgoSinceDate();
      if ((!mainStore.isInternetOn || store.savedOrNot) &&
          store.timePassed == "20s ago") {
        timer!.cancel();
        store.lastKnownTime = DateTime.now();
        showDialog(
          context: context,
          builder: (_) => const BlogErrorDialog(),
        ).whenComplete(() {
          store.showErrorWhenLoadingData = false;
          initialiseTimer();
        });
      }
    });
  }

  Future<void> previewBlog() async {
    store.makeBlogPublished = true;
    final model = await store.addReadTimeAndGetDraftArticlesData();
    if (timer != null) {
      timer!.cancel();
    }
    store.makeBlogPublished = false;
    await showDialog(
      context: context,
      builder: (_) => Provider.value(
        value: store,
        child: EditHeadlineAndThumbNailDialog(
          model: model,
          headline: headLineController.text.trim(),
        ),
      ),
    ).whenComplete(initialiseTimer);
  }

  @override
  void initState() {
    headLineController.text = model.headline;
    store
      ..draftId = model.blogId
      ..lastKnownTime = DateTime.now()
      ..wordCount = model.wordCount
      ..imageCount = model.imagesCount
      ..linksCount = model.linksCount
      ..ytVideosCount = model.ytVideosCount;
    initialiseTimer();
    super.initState();
  }

  @override
  void dispose() {
    headLineController.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    store
      ..disposeCreateArticleVariables()
      ..getDraftArticlesData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WillPopScope(
            onWillPop: () async {
              if (store.savedOrNot) {
                await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => Provider.value(
                      value: store, child: const LeavingBlogScreenDialog()),
                );
                return false;
              } else {
                return true;
              }
            },
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (store.savedOrNot) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => Provider.value(
                              value: store,
                              child: const LeavingBlogScreenDialog()),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  title: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => Provider.value(
                              value: store,
                              child: AddHeadlineAndThumbNailDialog(
                                headLineController: headLineController,
                                timerChange: () {
                                  store.lastKnownTime = DateTime.now();
                                },
                              ),
                            ),
                          );
                        },
                        child: Text(
                          headLineController.text,
                        ),
                      ),
                      Observer(builder: (_) {
                        if (!mainStore.isInternetOn || store.savedOrNot) {
                          if (!mainStore.isInternetOn) {
                            store
                              ..lastKnownTime = DateTime.now()
                              ..checkBlogInternetConn = true;
                          }
                          return const Text(
                            "Saving...",
                          );
                        } else {
                          if (store.checkBlogInternetConn) {
                            store
                              ..lastKnownTime = DateTime.now()
                              ..checkBlogInternetConn = false;
                          }
                          return Text(
                            "Saved ${store.timePassed}",
                          );
                        }
                      })
                    ],
                  ),
                  centerTitle: true,
                  elevation: 0,
                  actions: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.more_vert,
                          ),
                          onSelected: (val) async {
                            controller.clearFocus();
                            switch (val) {
                              case 1:
                                await previewBlog();
                                break;
                              case 2:
                                store.isLocked = !store.isLocked;
                                if (store.isLocked) {
                                  controller.disable();
                                } else {
                                  controller.enable();
                                }
                                break;
                              case 3:
                                controller.undo();
                                break;
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                value: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Publish",
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Observer(
                                      builder: (_) => Text(
                                            !store.isLocked ? "Lock" : "Unlock",
                                          )),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 3,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Undo",
                                  ),
                                ),
                              ),
                            ];
                          }),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                body: Stack(
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                    ),
                    HtmlEditor(
                      controller: controller,
                      htmlEditorOptions: const HtmlEditorOptions(
                          hint: "Type here to begin..."),
                      htmlToolbarOptions: HtmlToolbarOptions(
                        // buttonColor: Colors.white,
                        // buttonSelectedColor: Colors.white,
                        // buttonFillColor: const Color(0xff8C00E3),
                        // buttonHighlightColor: const Color(0xff8C00E3),
                        // dropdownIconColor: Colors.white,
                        // textStyle: const TextStyle(color: Colors.white),
                        defaultToolbarButtons: [
                          const FontSettingButtons(
                              fontName: false, fontSizeUnit: false),
                          const FontButtons(
                            clearAll: false,
                            strikethrough: false,
                            superscript: false,
                            subscript: false,
                          ),
                          const ColorButtons(highlightColor: false),
                          const ListButtons(listStyles: false),
                          const InsertButtons(
                              picture: false,
                              link: false,
                              video: false,
                              audio: false,
                              table: false,
                              hr: false),
                        ],
                        customToolbarButtons: [
                          GestureDetector(
                              onTap: showActionSheet,
                              child: const Icon(
                                Icons.image_outlined,
                                color: Colors.white,
                              )),
                          GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Provider.value(
                                    value: store,
                                    child: AddLinkToTextDialog(
                                      controller: controller,
                                    ),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                "assets/svg/blogs/link.svg",
                                color: Colors.white,
                              )),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Provider.value(
                                  value: store,
                                  child: AddYoutubeToBlog(
                                    controller: controller,
                                  ),
                                ),
                              ).whenComplete(() {
                                store.showErrorText = false;
                              });
                            },
                            child: SvgPicture.asset("assets/svg/blogs/yt.svg"),
                          ),
                        ],
                      ),
                      otherOptions: OtherOptions(
                          height: MediaQuery.of(context).size.height),
                      callbacks: Callbacks(onInit: () {
                        controller.setText(model.content);
                        // ignore: avoid_dynamic_calls
                        controller.editorController!.evaluateJavascript(
                            source:
                                "document.getElementsByClassName('note-editable')[0].style.backgroundColor='white';");
                      }, onChangeContent: (content) async {
                        if (content != null) {
                          if (content.isNotEmpty) {
                            final parseText = parse(content);
                            final parsedString = parse(parseText.body!.text)
                                .documentElement!
                                .text;
                            final textWithoutYtUrl =
                                parsedString.replaceAll(store.youtubeUrl, "");
                            final textWithoutAnyLinksUrl = textWithoutYtUrl
                                .replaceAll(store.addLinkToText, "");
                            final textWithoutAnySpaces = textWithoutAnyLinksUrl
                                .replaceAll(RegExp(r"\s+"), "");
                            store.wordCount = textWithoutAnySpaces.length;
                            if (store.imageCount > 0 &&
                                !content.contains("img src=")) {
                              store.imageCount--;
                            }
                            if (store.ytVideosCount > 0 &&
                                !content.contains("youtu")) {
                              store.ytVideosCount--;
                            }
                            if (store.linksCount > 0 &&
                                !content.contains("a href=")) {
                              store.linksCount--;
                            }
                            await store.addContentToBlog(
                                content, textWithoutAnyLinksUrl);
                            if (store.showErrorWhenLoadingData) {
                              await showDialog(
                                context: context,
                                builder: (_) => const BlogErrorDialog(),
                              ).whenComplete(
                                  () => store.showErrorWhenLoadingData = false);
                            }
                          }
                        }
                      }, onImageUploadError: (_, __, ___) {
                        showDialog(
                          context: context,
                          builder: (_) => const BlogErrorDialog(),
                        ).whenComplete(
                            () => store.showErrorWhenLoadingData = false);
                      }),
                    ),
                  ],
                )),
          ),
          Observer(builder: (_) {
            if (store.makeBlogPublished || store.uploadingImages) {
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
                        children: [
                          const LoadingScreen(),
                          const SizedBox(height: 20),
                          Observer(builder: (_) {
                            return Text(
                                store.uploadingImages
                                    ? "Uploading Images"
                                    : "Getting Blog Details",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    decoration: TextDecoration.none));
                          })
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
    );
  }
}

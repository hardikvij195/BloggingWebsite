// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_website/feature/blogs/common/loading_screen.dart';
import 'package:internship_website/feature/blogs/store/blogs_store.dart';
import 'package:provider/provider.dart';

import '../../../core/helper/image_helper.dart';
import '../../../core/helper/name_helper.dart';
import '../model/blogs_image_model.dart';
import '../model/social_media_model.dart';

class CreateBloggerProfileScreen extends StatelessWidget {
  const CreateBloggerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
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
                      ..uploadingBloggerDp = true
                      ..bloggerDp = BlogsImageModel(
                        imgFile: File(
                          imgPath.path,
                        ),
                      )
                      ..uploadingBloggerDp = false;
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
                      ..uploadingBloggerDp = true
                      ..bloggerDp = BlogsImageModel(
                        imgFile: File(
                          imgPath.path,
                        ),
                      )
                      ..uploadingBloggerDp = false;
                  }
                },
                child: const Text(
                  'Take Picture',
                )),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                toolbarHeight: 0,
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Observer(
                builder: (_) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              "Create Blog Profile",
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Observer(builder: (_) {
                        if (store.uploadingBloggerDp) {
                          return const Center(
                            child: LoadingScreen(),
                          );
                        } else {
                          return Center(
                            child: Stack(
                              children: [
                                if (store.bloggerDp.imgFile == null &&
                                    store.bloggerDp.imgUrl == null)
                                  SvgPicture.asset(
                                    "assets/svg/blogs/blog_profile.svg",
                                    height: 126,
                                    width: 126,
                                    color: Colors.black,
                                  )
                                else if (store.bloggerDp.imgFile != null)
                                  SizedBox(
                                    height: 126,
                                    width: 126,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          FileImage(store.bloggerDp.imgFile!),
                                    ),
                                  )
                                else
                                  CachedNetworkImage(
                                    imageUrl: store.bloggerDp.imgUrl!,
                                    imageBuilder: (context, imageProvider) =>
                                        SizedBox(
                                      width: 126,
                                      height: 126,
                                      child: CircleAvatar(
                                          backgroundImage: imageProvider),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      height: 20,
                                      width: 20,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/png/app/mwicon.png",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                Positioned(
                                  right: 0,
                                  top: 17,
                                  child: GestureDetector(
                                    onTap: showActionSheet,
                                    child: Container(
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                                offset: const Offset(0, 4),
                                                blurRadius: 4)
                                          ]),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      }),
                      const SizedBox(height: 40),
                      const Padding(
                        padding: EdgeInsets.only(left: 28),
                        child: Text(
                          "Blogger Name",
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: TextField(
                          onChanged: (value) {
                            store.bloggerName = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: 'This name will be visible on your blogs',
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.only(left: 28),
                        child: Text(
                          "About me",
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: TextField(
                          maxLines: 7,
                          onChanged: (value) {
                            store.aboutMe = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText:
                                'Give a little introduction about yourself',
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return Provider.value(
                                    value: store,
                                    child: const _CreateSocialMediaDialog(),
                                  );
                                });
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 17,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Add your social media links",
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (store.socialMediaList.isNotEmpty)
                        Observer(builder: (_) {
                          return ListView.separated(
                            itemCount: store.socialMediaList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            itemBuilder: (context, index) {
                              final model = store.socialMediaList[index];
                              return Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        model.socialMediaImage,
                                        height: 20,
                                        width: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          onChanged: (value) {
                                            store.socialMediaList
                                              ..removeAt(index)
                                              ..insert(
                                                  index,
                                                  SocialMediaModel(
                                                      socialMediaImage: model
                                                          .socialMediaImage,
                                                      socialMediaNameOrUrl:
                                                          value.trim()));
                                          },
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(bottom: 5),
                                            border: InputBorder.none,
                                            hintText:
                                                'Type your username or URL',
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          store.socialMediaList.removeAt(index);
                                        },
                                        child: const Icon(
                                          Icons.close,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 60),
                        child: Container(
                          height: 52,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: () async {
                              if (store.bloggerDp.imgFile == null &&
                                  store.bloggerDp.imgUrl == null) {
                                await tost("Please add a blogger dp");
                              } else if (store.bloggerName.isEmpty) {
                                await tost("Please enter a blogger name");
                              } else if (store.aboutMe.isEmpty) {
                                await tost("Please enter about me");
                              } else if (store.socialMediaList.isNotEmpty) {
                                for (int i = 0;
                                    i < store.socialMediaList.length;
                                    i++) {
                                  if (store.socialMediaList[i]
                                      .socialMediaNameOrUrl.isEmpty) {
                                    await tost(
                                        "Please enter the username or url for the ${store.missingNameOrUrlForSocialMedia(i)}");
                                    break;
                                  } else if (i ==
                                      store.socialMediaList.length - 1) {
                                    FocusScope.of(context).unfocus();
                                    store.isSubmitClicked = true;
                                  } else {
                                    continue;
                                  }
                                }
                              } else {
                                FocusScope.of(context).unfocus();
                                store.isSubmitClicked = true;
                              }
                            },
                            child: const Center(
                              child: Text(
                                'Submit',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Observer(builder: (_) {
            final lastPageLoader = store.uploadingData;
            if (store.isSubmitClicked) {
              if (store.bloggerDpUploading) {
                return _LoadingScreenForCreateBloggerProfile(
                    imgFile: store.bloggerDp.imgFile,
                    dpUrl: store.bloggerDp.imgUrl ?? "",
                    message: "Blogger Dp Uploading");
              } else {
                if (lastPageLoader) {
                  return _LoadingScreenForCreateBloggerProfile(
                      imgFile: store.bloggerDp.imgFile,
                      dpUrl: store.bloggerDp.imgUrl ?? "",
                      message: "Blogger Details Uploading");
                } else {
                  return const SizedBox();
                }
              }
            } else {
              return Container();
            }
          })
        ],
      ),
    );
  }
}

class _LoadingScreenForCreateBloggerProfile extends StatelessWidget {
  const _LoadingScreenForCreateBloggerProfile(
      {required this.imgFile,
      required this.dpUrl,
      required this.message,
      Key? key})
      : super(key: key);
  final File? imgFile;
  final String dpUrl;
  final String message;
  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
    Future<void> updateDataLocally() async {
      await store.uploadBloggerDetails(imgFile, dpUrl);
      store
        ..bloggerInfo = true
        ..uploadingData = false;
      Navigator.pop(context);
    }

    return Observer(builder: (_) {
      if (store.uploadingData) {
        updateDataLocally();
      }
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
              const Opacity(
                opacity: 0.7,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.black,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoadingScreen(),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

class _CreateSocialMediaDialog extends StatelessWidget {
  const _CreateSocialMediaDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
    final socialMediaImagesList = [
      "assets/svg/settings_sub_pages/fb.svg",
      "assets/svg/settings_sub_pages/insta.svg",
      "assets/sm/twitter.svg",
      "assets/sm/LinkedIn.svg",
    ];
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 30),
            itemCount: socialMediaImagesList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  store.socialMediaList.add(SocialMediaModel(
                      socialMediaImage: socialMediaImagesList[index],
                      socialMediaNameOrUrl: ""));
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  socialMediaImagesList[index],
                  height: 43,
                  width: 43,
                ),
              );
            },
          )),
    );
  }
}

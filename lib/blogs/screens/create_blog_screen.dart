import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:html/parser.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:html_parser_plus/html_parser_plus.dart';

class CreateBlogScreen extends StatefulWidget {
  final bool isEditable;
  final String uid;
  CreateBlogScreen({Key? key, required this.isEditable, required this.uid})
      : super(key: key);
  @override
  _CreateBlogScreenState createState() =>
      _CreateBlogScreenState(uid, isEditable);
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  var readUid, isEditable;
  _CreateBlogScreenState(this.readUid, this.isEditable);
  String result = '', headline = '', imgUrl = '', textOnlyResult = '', uid = '';
  late int i = 0,
      wordCount = 0,
      linksCount = 0,
      ytVideosCount = 0,
      ImagesCount = 0;
  bool flag = false, thumbnailUploaded = false;
  late var doc;
  final headingController = TextEditingController();
  final HtmlEditorController controller = HtmlEditorController();
  late double _distanceToField;
  late TextfieldTagsController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool save = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final firestoreInstance = FirebaseFirestore.instance;

    if (readUid != '') {
      getBlogInformation();
      controller.setText(result);
      uid = readUid;
    }

    return GestureDetector(
        onTap: () {
          if (!kIsWeb) {
            controller.clearFocus();
          }
          controller.setText(result);
        },
        child: Scaffold(
            key: _scaffoldKey,
            endDrawer: Drawer(
                width: size.width * 0.35,
                child: Column(
                  children: [
                    Text('Article overview'),
                    endDrawerValues("Words", wordCount),
                    endDrawerValues("Images", ImagesCount),
                    endDrawerValues("Links", linksCount),
                    endDrawerValues("YouTube videos", ytVideosCount),
                    Text('The read time for this article is estimated to be:'),
                    Text('${(wordCount / 200).round() + 1} minutes'),
                    tags(),
                    ElevatedButton(
                        onPressed: () {
                          saveBlog("Blogs");
                        },
                        child: Text('Publish'))
                  ],
                )),
            appBar: AppBar(
              title: Text('Write Blog'),
              elevation: 0,
              actions: [Text(save == true ? "Saving..." : "")],
            ),
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: imgUrl == ''
                              ? Image.asset('assets/noimage.jpg')
                              : Image.network(imgUrl),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              uid == ''
                                  ? {
                                      doc = firestoreInstance
                                          .collection("Drafts")
                                          .doc(),
                                      uid = doc.id,
                                    }
                                  : {};
                              uploadToStorage();
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 4, color: Colors.white),
                                    color: Colors.blue),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ]),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: headingController,
                          decoration: InputDecoration(
                              hintText: headline == ''
                                  ? 'Write your title'
                                  : headline,
                              border: InputBorder.none),
                        ),
                      ),
                      Container(height: 500, child: contentBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blueGrey),
                              onPressed: () {
                                controller.undo();
                              },
                              child: Text('Undo',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blueGrey),
                              onPressed: () {
                                controller.clear();
                              },
                              child: Text('Reset',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary),
                              onPressed: () async {
                                _scaffoldKey.currentState!.openEndDrawer();
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary),
                              onPressed: () {
                                controller.redo();
                              },
                              child: Text(
                                'Redo',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary),
                              onPressed: () {
                                saveBlog("Trash");
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))));
  }

  Widget contentBox() {
    return HtmlEditor(
      controller: controller,
      htmlEditorOptions: HtmlEditorOptions(
        hint: 'Type here to begin...',
        shouldEnsureVisible: true,
      ),
      htmlToolbarOptions: HtmlToolbarOptions(
        toolbarPosition: ToolbarPosition.aboveEditor, //by default
        toolbarType: ToolbarType.nativeScrollable, //by default
        onButtonPressed:
            (ButtonType type, bool? status, Function? updateStatus) {
          //print("button '${describeEnum(type)}' pressed, the current selected status is $status");
          return true;
        },
        onDropdownChanged: (DropdownType type, dynamic changed,
            Function(dynamic)? updateSelectedItem) {
          //print("dropdown '${describeEnum(type)}' changed to $changed");
          return true;
        },
        linkInsertInterceptor: (String text, String url, bool flag) {
          if (url.substring(0, 24) == 'https://www.youtube.com/') {
            ytVideosCount = ytVideosCount + 1;
          } else {
            linksCount = linksCount + 1;
          }
          return true;
        },
        mediaLinkInsertInterceptor: (String url, InsertFileType type) {
          setState(() {
            ImagesCount = ImagesCount + 1;
            result = result + "<img src='$url'";
          });
          return true;
        },

        mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
          /*print(file.name); //filename
          print(file.size); //size in bytes
          print(file.extension); //file extension (eg jpeg or mp4)*/
          setState(() {
            ImagesCount = ImagesCount + 1;
          });
          return true;
        },
      ),
      otherOptions: OtherOptions(height: 550),
      callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
        //print('html before change is $currentHtml');
      }, onChangeContent: (String? changed) async {
        //print('code updated to $changed \n');
        final firestoreInstance = FirebaseFirestore.instance;
        result = changed!;
        String text = result;
        getTextOnlyContent(text);
        saving();

        setState(() {
          RegExp regExp = RegExp(" ");
          wordCount = regExp.allMatches(textOnlyResult).length + 1;
        });

        uid == ''
            ? {
                doc = firestoreInstance.collection("Drafts").doc(),
                uid = doc.id,
              }
            : {};

        saveBlog("Drafts");
      }, onChangeCodeview: (String? changed) {
        //print('code changed to $changed');
      }, onChangeSelection: (EditorSettings settings) {
        //print('parent element is ${settings.parentElement}');
        //print('font name is ${settings.fontName}');
      }, onDialogShown: () {
        //print('dialog shown');
      }, onEnter: () {
        //print('enter/return pressed');
      }, onFocus: () {
        //print('editor focused');
      }, onBlur: () {
        //print('editor unfocused');
      }, onBlurCodeview: () {
        //print('codeview either focused or unfocused');
      }, onInit: () {
        controller.enable();
      },
          //this is commented because it overrides the default Summernote handlers
          /*onImageLinkInsert: (String? url) {
                    print(url ?? "unknown url");
                  },
                  onImageUpload: (FileUpload file) async {
                    print(file.name);
                    print(file.size);
                    print(file.type);
                    print(file.base64);
                  },*/
          onImageUploadError:
              (FileUpload? file, String? base64Str, UploadError error) {
        /*print(describeEnum(error));
            print(base64Str ?? '');*/
        if (file != null) {
          /*print(file.name);
              print(file.size);
              print(file.type);*/
        }
      }, onKeyDown: (int? keyCode) {
        //print('$keyCode key downed');
        //print('current character count: ${controller.characterCount}');
      }, onKeyUp: (int? keyCode) {
        //print('$keyCode key released');
      }, onMouseDown: () {
        //print('mouse downed');
      }, onMouseUp: () {
        //print('mouse released');
      }, onNavigationRequestMobile: (String url) {
        //print(url);
        return NavigationActionPolicy.ALLOW;
      }, onPaste: () {
        //print('pasted into editor');
      }, onScroll: () {
        //print('editor scrolled');
      }),
      plugins: [
        SummernoteAtMention(
            getSuggestionsMobile: (String value) {
              var mentions = <String>['test1', 'test2', 'test3'];
              return mentions
                  .where((element) => element.contains(value))
                  .toList();
            },
            mentionsWeb: ['test1', 'test2', 'test3'],
            onSelect: (String value) {
              //print(value);
            }),
      ],
    );
  }

  Widget tags() {
    return TextFieldTags(
      textfieldTagsController: _controller,
      initialTags: const [],
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (tag == 'php') {
          return 'No, please just no';
        } else if (_controller.getTags!.contains(tag)) {
          return 'you already entered that';
        }
        return null;
      },
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
        return ((context, sc, tags, onTagDelete) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                isDense: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 74, 137, 92),
                    width: 3.0,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 74, 137, 92),
                    width: 3.0,
                  ),
                ),
                hintText: _controller.hasTags ? '' : "Enter tags",
                errorText: error,
                prefixIconConstraints:
                    BoxConstraints(maxWidth: _distanceToField * 0.74),
                prefixIcon: tags.isNotEmpty
                    ? SingleChildScrollView(
                        controller: sc,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: tags.map((String tag) {
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              color: Color.fromARGB(255, 74, 137, 92),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    '#$tag',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    //print("$tag selected");
                                  },
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: Color.fromARGB(255, 233, 233, 233),
                                  ),
                                  onTap: () {
                                    onTagDelete(tag);
                                  },
                                )
                              ],
                            ),
                          );
                        }).toList()),
                      )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          );
        });
      },
    );
  }

  void saveBlog(String collection) {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance.collection(collection).doc(uid).set({
        "headline": headingController.text,
        "content": result,
        "createdAt": Timestamp.now(),
        "thumbNail": imgUrl,
        "blogViewers": 0,
        "followersCount": 0,
        "bloggerUserName": "",
        "wordCount": wordCount,
        "imagesCount": ImagesCount,
        "blogId": uid,
        "linksCount": linksCount,
        "ytVideosCount": ytVideosCount,
        "textOnlyContent": textOnlyResult,
        "bloggerName": "Apreksha Mathur",
        "bloggerImgUrl": "",
        "blogLikes": 0,
        "blogComments": 0,
        "isPublished": collection == "Blogs" ? true : false,
        "readTime": (wordCount / 200).round() + 1,
        "bloggerUid": "",
        "shareLink": "",
        "showThumbNailAtFirstLine": true,
        "tags": collection == "Blogs"
            ? _controller.hasTags
                ? _controller.getTags
                : []
            : [],
      });
      collection == "Blogs"
          ? firestoreInstance.collection("Drafts").doc(uid).delete()
          : {};
      collection == "Trash"
          ? firestoreInstance.collection("Drafts").doc(uid).delete()
          : {};
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Some Issue Occurred')));
    }
  }

  uploadToStorage() {
    FileUploadInputElement input = FileUploadInputElement()..accept = 'image/*';
    FirebaseStorage fs = FirebaseStorage.instance;
    input.click();
    input.onChange.listen((event) {
      final file = input.files?.first;
      final reader = FileReader();
      reader.readAsDataUrl(file!);
      reader.onLoadEnd.listen((event) async {
        var snapshot = await fs.ref().child('thumbnail/$uid').putBlob(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imgUrl = downloadUrl;
        });
      });
    });
  }

  getBlogInformation() {
    final res =
        FirebaseFirestore.instance.collection("Blogs").doc(readUid).get();
    res.then((value) {
      result = value.data()!["content"];
      headline = value.data()!["headline"];
      imgUrl = value.data()!["thumbnail"];
    });
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  void getTextOnlyContent(String text) {
    List getTextContent = [];
    final parseText = parse(text);
    final listOfElements = parseText.querySelectorAll("p");

    for (final i in listOfElements) {
      if (!i.innerHtml.contains("<a href=")) {
        final getOnlyText = _parseHtmlString(i.innerHtml);
        if (getOnlyText.isNotEmpty) {
          getTextContent.add(getOnlyText);
        }
      }
    }
    textOnlyResult = getTextContent.join(" ");
  }

  endDrawerValues(String heading, int value) {
    return Row(
      children: [Text('$heading\t'), Text('$value')],
    );
  }

  Future saving() {
    return Future.delayed(Duration(seconds: 2), () {
      setState(() {
        save = true;
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            save = false;
          });
        });
      });
    });
  }
}

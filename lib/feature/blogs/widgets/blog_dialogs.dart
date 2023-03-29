import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:internship_website/feature/blogs/store/blogs_store.dart';
import 'package:provider/provider.dart';

class BlogErrorDialog extends StatelessWidget {
  const BlogErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          const Text("Your Article is not saved"),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Something went wrong. Please check your \ninternet connection.",
              textAlign: TextAlign.center,
            ),
          ),
          const Text(
            "Any changes made in the article will be \nsaved when the issue is fixed.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 93),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Ok',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class LeavingBlogScreenDialog extends StatelessWidget {
  const LeavingBlogScreenDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          const Text(
            "Your Article is not saved",
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              "There are unsaved changes in your article",
            ),
          ),
          const Text(
            "Are you sure you want to leave without \nsaving?",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 93),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Ok',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..pop();
            },
            child: const Center(
              child: Text(
                'Leave',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class AddLinkToTextDialog extends StatelessWidget {
  const AddLinkToTextDialog({required this.controller, Key? key})
      : super(key: key);
  final HtmlEditorController controller;
  @override
  Widget build(BuildContext context) {
    late final store = context.read<BlogsStore>();
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: Center(
              child: Text(
                "Link To Text",
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Add Text Here",
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              onChanged: (value) {
                store.addLinkToText = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the text here',
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Add Link Here",
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              onChanged: (value) {
                store.linkUrl = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Paste the URI here',
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              controller.insertLink(
                store.addLinkToText,
                store.linkUrl,
                true,
              );
              store.linksCount++;
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 68),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Ok',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: Text(
                'Cancel',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class AddYoutubeToBlog extends StatelessWidget {
  const AddYoutubeToBlog({required this.controller, Key? key})
      : super(key: key);
  final HtmlEditorController controller;
  @override
  Widget build(BuildContext context) {
    late final store = context.read<BlogsStore>();
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: Center(
              child: Text(
                "Embed Youtube Video",
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Add link of the YouTube video",
            ),
          ),
          const SizedBox(height: 10),
          Observer(builder: (_) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextField(
                onChanged: (value) {
                  store.youtubeUrl = value;
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    errorText:
                        store.showErrorText ? "Please add youtube url" : null,
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    hintText: 'Paste the URI here'),
              ),
            );
          }),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              if (store.youtubeUrl.contains("youtu")) {
                controller.insertLink(
                  store.youtubeUrl,
                  store.youtubeUrl,
                  true,
                );
                store.ytVideosCount++;
                Navigator.pop(context);
              } else {
                store.showErrorText = true;
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 68),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Ok',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: Text(
                'Cancel',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

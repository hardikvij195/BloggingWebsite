import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:internship_website/loadingScreen.dart';
import 'package:provider/provider.dart';
import 'package:internship_website/blogs/store/blogs_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:internship_website/blogs/screens/read_blog_screen.dart';

class DraftsScreen extends StatefulWidget {
  const DraftsScreen({Key? key}) : super(key: key);

  @override
  State<DraftsScreen> createState() => _DraftsScreenState();
}

class _DraftsScreenState extends State<DraftsScreen> {
  late final store = context.read<BlogsStore>();
  late final size = MediaQuery.of(context).size;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drafts")),
      body: Observer(builder: (_) {
        if (store.fetchingDraftsBlogs) {
          return const LoadingScreen();
        } else if (store.draftsBlogsList.isEmpty) {
            return const Center(
              child: Text("There are no blogs available"),
            );
          } else {
              return const _DraftsBlogsWidget();
          }
        })
    );
  }
}

class _DraftsBlogsWidget extends StatelessWidget {
  const _DraftsBlogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: Observer(
        builder: (_) {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
              itemCount: store.draftsBlogsList.length,
              itemBuilder: (context, index) {
                final model = store.draftsBlogsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Provider.value(
                            value: store,
                            child: ReadBlog(model: model,),
                          )));
                  },
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            child: Image.network(model.thumbNail)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(model.headline == ''
                                  ? "No Title"
                                  : model.headline,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text(model.bloggerName,
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Html(
                          data: model.content,
                          style: {'#': Style(maxLines: 3)},
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship_website/feature/blogs/common/loading_screen.dart';
import 'package:internship_website/feature/blogs/screens/blog_info_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../store/blogs_store.dart';

class TrashScreen extends StatelessWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Trash"),
          actions: [
            TextButton(
                onPressed: () async {
                  final instance = FirebaseFirestore.instance;
                  final batch = instance.batch();
                  final res = await instance.collection('Trash').get();
                  for (final i in res.docs) {
                    batch.delete(i.reference);
                  }
                  await batch.commit();
                },
                child: const Text(
                  'Delete all',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Observer(builder: (_) {
          if (store.fetchingTrashBlogs) {
            return const LoadingScreen();
          } else if (store.trashBlogsList.isEmpty) {
            return const Center(
              child: Text("There are no blogs available"),
            );
          } else {
            return const _TrashBlogsWidget();
          }
        }));
  }
}

class _TrashBlogsWidget extends StatelessWidget {
  const _TrashBlogsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
    final size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        child: Observer(builder: (_) {
          return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: store.trashBlogsList.length,
              itemBuilder: (context, index) {
                final model = store.trashBlogsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Provider.value(
                              value: store,
                              child: BlogInfoScreen(
                                model: model,
                              ),
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
                        SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.network(model.thumbNail)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              model.headline == ''
                                  ? "No Title"
                                  : model.headline,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text(
                              model.bloggerName,
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        }));
  }
}

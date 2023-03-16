import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:internship_website/loadingScreen.dart';
import 'package:html/dom.dart' as dom;
import 'dart:html' as html;
import 'package:provider/provider.dart';
import 'package:internship_website/blogs/store/blogs_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:internship_website/blogs/screens/read_blog_screen.dart';

class TrashScreen extends StatefulWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  late final store = context.read<BlogsStore>();
  late final size = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trash"),
        actions: [
          TextButton(
              onPressed: () async{
                final instance = FirebaseFirestore.instance;
                final batch = instance.batch();
                final res = await instance.collection('Trash').get();
                for (final i in res.docs) {
                  batch.delete(i.reference);
                }
                await batch.commit();
              },
            child: const Text('Delete all', style: TextStyle(color: Colors.white),))
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
        })
    );
  }
}

class _TrashBlogsWidget extends StatelessWidget {
  const _TrashBlogsWidget({super.key});

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
            itemCount: store.trashBlogsList.length,
            itemBuilder: (context, index) {
              final model = store.trashBlogsList[index];
              return GestureDetector(
                onTap: (){
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
                      borderRadius: BorderRadius.circular(10)
                  ),
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
                          SizedBox(width: size.width*0.01,),
                          Text(model.bloggerName,
                              style: const TextStyle(color: Colors.grey),
                            )
                        ],
                      ),
                      Html(
                        data:model.content,
                        style: {
                          '#':Style(
                              maxLines: 3
                          )
                        },
                      )
                    ],
                  ),
                ),
              );
            });
        }
      )
    );
  }
}
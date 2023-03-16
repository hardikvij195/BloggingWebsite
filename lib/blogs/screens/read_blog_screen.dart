import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:internship_website/blogs/model/blog_model.dart';
// ignore: depend_on_referenced_packages
import 'package:html/dom.dart' as dom;
import 'package:internship_website/blogs/screens/edit_blog_screen.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter_mobx/flutter_mobx.dart';

class ReadBlog extends StatefulWidget {
  const ReadBlog({Key? key, required this.model})
      : super(key: key);
  final BlogModel model;
  @override
  State<ReadBlog> createState() => _ReadBlogState();
}

class _ReadBlogState extends State<ReadBlog> {
  late final model = widget.model;
  late final size = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drafts")),
      body:  SizedBox(
      height: size.height,
      child: Observer(
        builder: (_) {
          return Row(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: size.width * 0.6,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: Image.network(model.thumbNail),
                      ),
                      Text(
                        model.headline,
                        style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      Html(
                        data: model.content,
                        onLinkTap: (String? url,
                        RenderContext context,
                        Map<String, String> attributes,
                        dom.Element? element) {
                        //open URL in webview, or launch URL in browser, or any other logic here
                        html.window.open(url!, "_blank");
                      })
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/views.png",
                        height: 50,
                        width: 50,
                      ),
                      Text('${model.blogViewers} views')
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/likes.png",
                        height: 30,
                        width: 30,
                      ),
                      Text('    ${model.blogLikes} likes')
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/comments.png",
                        height: 30,
                        width: 30,
                      ),
                      Text('   ${model.blogComments} comments')
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditBlogScreen(
                      model: model)));
                    },
                    child: const Text('Edit'))
                ],
              )
            ],
          );
        }
      ),),
    );
  }
}
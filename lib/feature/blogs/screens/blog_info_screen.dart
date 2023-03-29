import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../model/blog_model.dart';
import '../store/blogs_store.dart';
import 'edit_blog_screen.dart';

class BlogInfoScreen extends StatelessWidget {
  const BlogInfoScreen({Key? key, required this.model}) : super(key: key);
  final BlogModel model;

  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Observer(builder: (_) {
          return Row(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  width: size.width * 0.6,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.network(model.thumbNail),
                      ),
                      Text(
                        model.headline,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      HtmlWidget(
                        model.content,
                        onTapUrl: (url) async {
                          if (await canLaunchUrlString(url)) {
                            await launchUrlString(url,
                                mode: LaunchMode.externalApplication);
                          }
                          return true;
                        },
                      ),
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
                            builder: (context) => Provider.value(
                                value: store,
                                child: EditBlogScreen(model: model))));
                      },
                      child: const Text('Edit'))
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}

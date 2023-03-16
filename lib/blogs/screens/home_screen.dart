import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:internship_website/blogs/screens/drafts_screen.dart';
import 'package:internship_website/blogs/screens/create_blog_screen.dart';
import 'package:internship_website/blogs/store/blogs_store.dart';
import 'package:internship_website/loadingScreen.dart';
import 'package:internship_website/login.dart';
import 'package:internship_website/profile.dart';
import 'package:internship_website/blogs/screens/trash_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final store = context.read<BlogsStore>();
  late final size = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 250,
                padding: const EdgeInsets.all(10),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [const Icon(Icons.search), const Text("search")],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Provider.value(
                                value: store..getTrashBlogsList(),
                                child: const TrashScreen(),
                              )));
                    },
                    child: const Text('Trash'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Provider.value(
                                value: store..getDraftsBlogsList(),
                                child: const DraftsScreen(),
                              )));
                    },
                    child: const Text('Drafts'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Provider.value(
                                value: store,
                                child: const CreateBlogScreen(),
                              )));
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Row(
                        children: [
                          Image.asset("assets/write.png"),
                          const Text(
                            'Write',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Profile()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 30,
                      width: 30,
                      child: Image.asset("assets/profile.jpg"),
                    ),
                  ),
                  TextButton(
                    child: const Text('Login'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Login()));
                    },
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Observer(builder: (_) {
            if (store.fetchingBlogs) {
              return LoadingScreen();
            } else if (store.blogsList.isEmpty) {
              return const Center(
                child: Text("There are no blogs available"),
              );
            } else {
              return const _BlogsWidget();
            }
          })
        ],
      ),
    ));
  }
}

class _BlogsWidget extends StatelessWidget {
  const _BlogsWidget();

  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
    final size = MediaQuery.of(context).size;
    return Observer(builder: (_) {
      return Expanded(
        child: ListView.builder(
            itemCount: store.blogsList.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final model = store.blogsList[index];
              return GestureDetector(
                onTap: () {},
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
                        child: Image.network(model.bloggerImgUrl),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.headline,
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
                      ),
                      Html(
                        data: model.content,
                        style: {'#': Style(maxLines: 3)},
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }
}

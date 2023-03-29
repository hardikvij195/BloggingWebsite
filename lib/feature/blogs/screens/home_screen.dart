import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:internship_website/feature/blogs/common/loading_screen.dart';
import 'package:internship_website/feature/blogs/screens/profile_details.dart';
import 'package:internship_website/feature/blogs/screens/trash_screen.dart';
import 'package:provider/provider.dart';

import '../store/blogs_store.dart';
import 'create_blog_screen.dart';
import 'drafts_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final store = context.read<BlogsStore>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Provider.value(
                            value: store,
                            child: const CreateBlogScreen(),
                          )));
                },
                child: SizedBox(
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
                      builder: (context) => const ProfileDetails()));
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
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Observer(builder: (_) {
            if (store.fetchingBlogs) {
              return const LoadingScreen();
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
                      SizedBox(
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
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }
}

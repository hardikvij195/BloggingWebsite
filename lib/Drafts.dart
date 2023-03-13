import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:internship_website/loadingScreen.dart';
import 'package:html/dom.dart' as dom;
import 'dart:html' as html;

import 'package:internship_website/readBlog.dart';

class Drafts extends StatefulWidget {
  const Drafts({Key? key}) : super(key: key);

  @override
  State<Drafts> createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  List contentArray = [],
      headlineArray = [],
      bloggerNameArray = [],
      uidArray = [],
      imgUrlArray = [];
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    getData();
    var size = MediaQuery.of(context).size;

    return loading == false
        ? Scaffold(
            appBar: AppBar(
              title: Text("Drafts"),
            ),
            body: Container(
              height: size.height * 0.9,
              child: ListView.builder(
                  itemCount: contentArray.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReadBlog(
                                collection: "Drafts", uid: uidArray[index])));
                      },
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                child: imgUrlArray[index] == null
                                    ? Image.asset("assets/noimage.jpg")
                                    : Image.network(imgUrlArray[index])),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  headlineArray[index] == null
                                      ? "No Title"
                                      : headlineArray[index],
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Text(
                                  bloggerNameArray[index] == null
                                      ? "Apreksha"
                                      : bloggerNameArray[index],
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Html(
                              data: contentArray[index],
                              style: {'#': Style(maxLines: 3)},
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ))
        : LoadingScreen();
  }

  void getData() async {
    final res = await FirebaseFirestore.instance.collection('Blogs').get();
    for (final i in res.docs) {
      if (!contentArray.contains((i.data()['textOnlyContent']))) {
        contentArray.add(i.data()['textOnlyContent']);
        if (i.data()['content'] != null) {
          loading = false;
        }
      }
      headlineArray.add(i.data()['headline']);
      bloggerNameArray.add(i.data()['bloggerName']);
      imgUrlArray.add(i.data()['thumbnail']);
      uidArray.add(i.id);
    }
  }
}

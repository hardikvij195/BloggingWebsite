import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:internship_website/WriteBlog.dart';
import 'package:internship_website/loadingScreen.dart';
import 'package:html/dom.dart' as dom;
import 'dart:html' as html;

class ReadBlog extends StatefulWidget {
  final String uid, collection;
  const ReadBlog({Key? key, required this.uid, required this.collection}) : super(key: key);

  @override
  State<ReadBlog> createState() => _ReadBlogState(uid, collection);
}

class _ReadBlogState extends State<ReadBlog> {
  var uid, collection;
  _ReadBlogState(this.uid, this.collection);
  var content, heading, createdAt, blogViewers, blogComments, blogLikes, imgUrl;
  bool loading=true, loaded=true;

  @override
  Widget build(BuildContext context) {
    getProductInformation();
    var size = MediaQuery.of(context).size;
    return loading == false? Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            SingleChildScrollView(
              child: Container(
                width: size.width*0.6,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: Image.network(imgUrl),
                    ),
                    Text(heading, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                    Html(
                      data: content,
                      onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                          //open URL in webview, or launch URL in browser, or any other logic here
                        html.window.open(url!,"_blank");
                      }
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Image.asset("assets/views.png", height: 50, width: 50,),
                    Text('$blogViewers views')
                  ],
                ),
                Row(
                  children: [
                    Image.asset("assets/likes.png", height: 30, width: 30,),
                    Text('    $blogLikes likes')
                  ],
                ),
                Row(
                  children: [
                    Image.asset("assets/comments.png", height: 30, width: 30,),
                    Text('   $blogComments comments')
                  ],
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WriteBlog(isEditable: true, uid: uid)));
                  },
                  child: Text('Edit'))
              ],
            )
          ],
        ),
      ),
    ): LoadingScreen();
  }

  getProductInformation(){
    final res = FirebaseFirestore.instance.collection(collection).doc(uid).get();
    res.then((value){
        content = value.data()!["content"];
        if(value.data()!["content"]!=null){
          loading = false;
        }
        heading = value.data()!["headline"];
        blogViewers = value.data()!["blogViewers"];
        blogLikes = value.data()!["blogLikes"];
        blogComments = value.data()!["blogComments"];
        imgUrl = value.data()!["thumbnail"];
        createdAt = value.data()!["createdAt"];
      });
  }
}

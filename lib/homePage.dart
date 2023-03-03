import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:internship_website/Drafts.dart';
import 'package:internship_website/WriteBlog.dart';
import 'package:internship_website/loadingScreen.dart';
import 'package:internship_website/login.dart';
import 'package:internship_website/profile.dart';
import 'package:internship_website/readBlog.dart';
import 'package:internship_website/trash.dart';
import 'package:readmore/readmore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List contentArray=[], headlineArray=[], bloggerNameArray=[], uidArray=[], imgUrlArray=[];
  bool loading=true;

  @override
  Widget build(BuildContext context){
    getData();
    var size = MediaQuery.of(context).size;
    //print(contentArray);

    return /*loading == false ?*/ Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250,
                  padding: EdgeInsets.all(10),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      Text("search")
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Trash()));
                      },
                      child: Text('Trash'),
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Drafts()));
                      },
                      child: Text('Drafts'),
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => WriteBlog(isEditable: false, uid: '',)));
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        child: Row(
                          children: [
                            Image.asset("assets/write.png"),
                            Text('Write', style: TextStyle(
                                color: Colors.black
                            ),)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile()));
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
                      child: Text('Login'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                      },
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: size.height*0.02,),
            Container(
              height: size.height*0.9,
              child: ListView.builder(
                itemCount: contentArray.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReadBlog(collection:"Blogs", uid: uidArray[index])));
                    },

                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: Image.network(imgUrlArray[index]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(headlineArray[index], style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(width: size.width*0.01,),
                                  Text(bloggerNameArray[index], style: TextStyle(
                                    color: Colors.grey
                                  ),)
                                ],
                              ),
                              Html(
                                data:contentArray[index],
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
                }),
            )
          ],
        ),
      )
    );// : LoadingScreen();
  }

  void getData() async {
    final res = await FirebaseFirestore.instance.collection('Blogs').get();
    for (final i in res.docs) {
      if(!contentArray.contains((i.data()['textOnlyContent']))){
        contentArray.add(i.data()['textOnlyContent']);
      }
      headlineArray.add(i.data()['headline']);
      bloggerNameArray.add(i.data()['bloggerName']);
      imgUrlArray.add(i.data()['thumbnail']);
      uidArray.add(i.id);
      /*if(i.data()!['content'] != null){
        loading = false;
      }*/
    }
  }
}

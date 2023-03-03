import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateBlogProfile extends StatefulWidget {
  const CreateBlogProfile({Key? key}) : super(key: key);

  @override
  State<CreateBlogProfile> createState() => _CreateBlogProfileState();
}

class _CreateBlogProfileState extends State<CreateBlogProfile> {
  var name, aboutMe, imageUrl, createdAt;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(child: Text('Create Blog Profile', style: TextStyle(color: Colors.black),)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset("assets/instagram.png"),
                  ),
                ),
                Positioned(
                  height: 35,
                  width: 35,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  )
                )
              ],
            ),
            Text('Blogger Name'),
            SizedBox(height: size.height*0.02,),
            Container(
              padding: EdgeInsets.all(7),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'This name will be visible on your blogs'
                ),
                onChanged: (value){
                  setState((){
                    name=value.trim();
                  });
                },
              ),
            ),
            SizedBox(height: size.height*0.05,),
            Text('About Me'),
            SizedBox(height: size.height*0.02,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)
              ),
              child: TextField(
                maxLines: 8,
                decoration: InputDecoration(
                  border: InputBorder.none,
                    hintText: 'Give a little introduction about yourself'
                ),
                onChanged: (value){
                  setState((){
                    aboutMe=value.trim();
                  });
                },
              ),
            ),
            SizedBox(height: size.height*0.02,),
            Center(
              child: InkWell(
                onTap: (){
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                      actions: <Widget>[
                        InkWell(
                          onTap: () => {},
                          child: Image.asset("assets/facebook.png", height: 50, width: 50,),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: Image.asset("assets/instagram.png", height: 50, width: 50,),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: Image.asset("assets/twitter.png", height: 50, width: 50,),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: Image.asset("assets/linkedin.png", height: 50, width: 50,),
                        ),
                    ],
                  ));
                },
                child: Container(
                  height: 50,
                  width: size.width*0.3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Add your social media')
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height*0.02,),
            /*Container(
              padding: EdgeInsets.all(7),
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)
              ),
              child: Image.asset('assets/instagram.png',),/*Row(
                children: [
                  Image.asset('assets/instagram.png',),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your username or URL'
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.highlight_remove_outlined),
                    onPressed: (){},
                  )
                ],
              ),*/
            ),*/
            ElevatedButton(
              onPressed: () {
                final firestoreInstance = FirebaseFirestore.instance;
                var firebaseUser = FirebaseAuth.instance.currentUser;
                firestoreInstance.collection("BlogProfile").add({
                      "aboutMe": aboutMe,
                      //"imageUrl": productPriceArray,
                      "name": name,
                      //"createdAt": total
                });
                print('saved');
              },
              child: Text('submit'))
          ],
        ),
      )
    );
  }
}

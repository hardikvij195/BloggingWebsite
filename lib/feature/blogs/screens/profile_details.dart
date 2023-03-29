import 'package:flutter/material.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        "assets/profile.jpg",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Column(
                      children: const [
                        Text(
                          'Apreksha Mathur',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@Apreksha',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: size.width * 0.6,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Title',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Text('description')
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

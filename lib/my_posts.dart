import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_blog/personal_post.dart';

class MyPosts extends StatefulWidget {
  DocumentSnapshot? documentSnapshot;
   MyPosts({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
    ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
     return currentUser == null
        ? Center(child: Text("sign in first"))
        : Scaffold(
          appBar: AppBar(
            elevation: 5,
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text("WE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              Text("BLOG", style: TextStyle(color: Color(0xFFAA00FF), fontWeight: FontWeight.bold),)
            ],
          ),
        ),
          ),
          body: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("post")
                    .where("user_id", isEqualTo: currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if ((snapshot.data?.docs.length ?? 0) > 0) {
                      return ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) => PersonalPost(
                          documentSnapshot: snapshot.data?.docs[index],
                        ),
                        itemCount: snapshot.data?.docs.length,
                        controller: scrollController,
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No Data",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: Text(
                        "Error Occured",
                      ),
                    );
                  }
                },
              ),
            ),
        );
  }


  }

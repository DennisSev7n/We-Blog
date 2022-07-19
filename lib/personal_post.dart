import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalPost extends StatefulWidget {
   DocumentSnapshot? documentSnapshot;
   PersonalPost({Key? key,  required this.documentSnapshot}) : super(key: key);

  @override
  State<PersonalPost> createState() => _PersonalPostState();
}

class _PersonalPostState extends State<PersonalPost> {

   var currentUser = FirebaseAuth.instance.currentUser;

  DocumentReference MyPosts = FirebaseFirestore.instance
      .collection('post')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                    color: Colors.deepPurpleAccent,
                  ),
                  IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("post")
                            .doc(widget.documentSnapshot!.id)
                            .delete();
                        setState(() {});
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.deepPurpleAccent)
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0, left: 5.0),
                    child: Container(
                      height: 100,
                      width: 200,
                      child: Image.network(
                        widget.documentSnapshot!["imgUrl"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Text(widget.documentSnapshot!["title"], style: TextStyle(
                      fontWeight: FontWeight.bold,
                      
                    ),),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
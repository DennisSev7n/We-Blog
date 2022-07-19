import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:we_blog/auth_screens/auth_page.dart';
import 'package:we_blog/auth_screens/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'home_page.dart';

class MainPage extends StatelessWidget {
  
  MainPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return HomePage();
        }else {
          return AuthPage();
        }
      }),
    );
  }
}
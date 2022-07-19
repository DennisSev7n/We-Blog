import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:we_blog/post_parameter.dart';
import 'package:we_blog/post_to_blog.dart';
import 'package:we_blog/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_blog/user_profile.dart';


class HomePage extends StatefulWidget {
  DocumentSnapshot? documentSnapshot;
   HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
 
  ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

           
 
       
 
 Future <dynamic> reFresh()async{
   return await  Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('post').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator() ,
              );
            }else{
              return
                
                ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) => CardUl(documentSnapshot: snapshot.data?.docs[index],),
                  controller: scrollController
                
              );
            }
          }
          ),
   );
 }


    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout),
          )
        ],
      ),

      //body

      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('post').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator() ,
              );
            }else{
              return LiquidPullToRefresh(
                color: Colors.deepPurple,
                backgroundColor: Colors.deepPurple[200],
                height: 100,
                animSpeedFactor: 2,
                showChildOpacityTransition: false,
                onRefresh: reFresh,
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) => CardUl(documentSnapshot: snapshot.data?.docs[index],),
                  controller: scrollController
                ),
              );
            }
          }
          ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PostBlog()));
      }, 
      backgroundColor: Colors.deepPurple,
      child: Icon(Icons.add),
      
       ),
      bottomNavigationBar: 
      
      BottomAppBar(
        
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                reFresh();
   },
   icon: Icon(Icons.home)),
              IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=> UserProfile(documentSnapshot:widget.documentSnapshot)));
              }, icon: Icon(Icons.person))
            ],
          ),),
        ),
      ),


    );
    
  }
}


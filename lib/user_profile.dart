import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_blog/home_page.dart';
import 'package:we_blog/my_posts.dart';
import 'package:we_blog/services/crud.dart';

class UserProfile extends StatefulWidget {
  DocumentSnapshot? documentSnapshot;
  UserProfile({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var currentUser = FirebaseAuth.instance.currentUser;


  DocumentReference userName = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);






  final ImagePicker _imagePicker = ImagePicker();

  CrudMethods crudMethods = CrudMethods();
   File? selectedImage;

   bool _isLoading = false;

  Future getImage() async{
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage =  File(image!.path);
    });
  }

  uploadBlog() async{
     void  _saveData(String imageUrl){
      
      String date = DateTime.now().toString();
      FirebaseFirestore.instance.collection('profilePic').add({
        'imgUrl' : imageUrl,
        
      }).whenComplete((){
        setState(() {
          _isLoading = false;
        });
print("postadded sucessfully");
   Navigator.pop(context);
      }).catchError((){
        setState(() {
          _isLoading =false;
        });
        print("error");
      });
    }
      if(selectedImage != null){

        setState(() {
          _isLoading = true;
        });
                String imageFilename = DateTime.now().millisecondsSinceEpoch.toString();
        final Reference storageReference = FirebaseStorage.instance.ref()
        .child('Images').child(imageFilename);

        final UploadTask uploadTask = storageReference.putFile(selectedImage!);
        
        uploadTask.then((TaskSnapshot taskSnapshot) {
          taskSnapshot.ref.getDownloadURL().then((imageUrl){
            _saveData(imageUrl);
          } );
        }).catchError((error){
          print("error");
        });
      }}

    
  
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
           ElevatedButton.icon(
            onPressed: (){
                       var route = MaterialPageRoute(
            builder: (BuildContext) =>
             MyPosts(documentSnapshot: widget.documentSnapshot));
        Navigator.push(context, route);
          }, 
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple
          ),
          
           icon: Icon(Icons.folder_shared),
            label: Text("My Posts")
          
          ), 
         
              
              
          
        ],
      ),
      body: SingleChildScrollView(
          child:
              
                 selectedImage != null ?  Center(
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Image.file(selectedImage!, fit: BoxFit.cover,),
                         SizedBox(
                           height: 20,
                         ),
                         Text("Email:" + currentUser!.email!, style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, 
                            ),),
                        Text("User Id:" + currentUser!.uid, style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16, 
                        ),),
                       
                       
                        
                      ],
                    ),
                  ) :  FutureBuilder(
                  future:  userName.get(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data();
          return                     Center(
                      // padding: EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: Column(
                          
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                             GestureDetector(
                               onTap: getImage,
                               child: Icon(Icons.add_a_photo)),
                             SizedBox(
                               height: 20,
                             ),
                               Text("Email:" + currentUser!.email!, style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, 
                            ),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("User Id:" + currentUser!.uid, style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, 
                            ),),
                
                              SizedBox(
                              height: 10,
                            ),
                
                           Text("First name: " + data['first name'], style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, 
                            ),),
                
                              SizedBox(
                              height: 10,
                            ),
                
                            Text("Last name: " + data['last name'], style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, 
                            ),),
                
                             SizedBox(
                              height: 10,
                            ),

                
                            
                           
                          ]
                   ),
                      ),
                              );
        }

                  return Container(
                    alignment: Alignment.center,
                    color: Colors.deepPurple,
                    child:
                    
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.deepPurple,
                        
                      ),
                    )
                    
                  );
                  }

                )

              )
      );
    
  }
}
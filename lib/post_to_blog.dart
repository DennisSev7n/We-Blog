
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'dart:io';
import 'package:intl/intl.dart';


import 'package:flutter/material.dart';

import 'package:we_blog/services/crud.dart';

class PostBlog extends StatefulWidget {
  const PostBlog({Key? key}) : super(key: key);

  @override
  State<PostBlog> createState() => _PostBlogState();
}

class _PostBlogState extends State<PostBlog> {
  late String authorName, title, desc ;
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
      
      String date = DateFormat('kk:mm').format(DateTime.now()).toString();
      FirebaseFirestore.instance.collection('post')..add({
        'imgUrl' : imageUrl,
        'desc': desc,
        'date': date,
        'title': title,
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'authorName': authorName
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
        //uploading image
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
      //  Reference firebaseStorageref =  FirebaseStorage.instance.ref()
      // .child('blogImages')
      // .child("${randomAlphaNumeric(9)}.jpg");
      

      

      // final StorageUploadTask = firebaseStorageref.putFile(selectedImage!);
      // var downloadUrl = await  ( await StorageUploadTask).ref.getDownloadURL();
      // print('this is url $downloadUrl');

      // Map<String, String> blogMap = {
      //   "imageUrl": downloadUrl,
      //   "authorName": authorName,
      //   "title": title,
      //   "description": desc
      // };
      // crudMethods.addData(blogMap).then((result) {
      
      } 

    
     
      
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
          ElevatedButton.icon(
            onPressed: (){
            uploadBlog();
          }, 
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple
          ),
          
           icon: Icon(Icons.file_upload,),
            label: Text("Upload")
          
          ), 
          
              
          //  Container(
              
          //     padding: EdgeInsets.symmetric(horizontal: 16),
             
          // ),
          
         
          
        ],
      ),

      //body

      body: _isLoading? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.deepPurple,
        ),
      ) 
      : SingleChildScrollView(
        child: Container(
          child:  Column(
            children: [
              SizedBox(
                height: 10,
              ),

              GestureDetector(
                onTap: getImage,
                child: selectedImage != null ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                   height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(selectedImage!, fit: BoxFit.cover,)),
                )
                 : Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Icon(Icons.add_a_photo),
                ),
              ),

              SizedBox(
                height: 8,
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                        hintText: "Author Name",
                      ),
                      onChanged: (val){
                        authorName = val;
                      },
                    ),
SizedBox(
  height: 10,
),
                      TextField(
                         keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
          autofocus: true,
     maxLines: null,
                      decoration: InputDecoration(
                        
                          filled: true,
                        hintText: "Title",
                      ),
                      onChanged: (val){
                        title = val;
                      },
                    ),
SizedBox(
  height: 10,
),

                      Container(
                        color: Colors.transparent,
                        height: 200,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
          autofocus: true,
     maxLines: null,
                        decoration: InputDecoration(
                          
                          hintText: "Description",
                         
                            filled: true,
                        ),
                        onChanged: (val){
                          desc = val;
                        },
                    ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ) ,

    );
  }
}
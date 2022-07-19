import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CrudMethods{
Future <void> addData(blogData) async{
  FirebaseFirestore.instance.collection('blogs').add(
    blogData
  ).catchError((e){
    print(e);
  }
  );
}
  

 getData() async{
    return await FirebaseFirestore.instance.collection("blogs").get();
  }
}



//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:random_string/random_string.dart';
// import 'dart:io';


// import 'package:flutter/material.dart';

// import 'package:we_blog/services/crud.dart';

// class PostBlog extends StatefulWidget {
//   const PostBlog({Key? key}) : super(key: key);

//   @override
//   State<PostBlog> createState() => _PostBlogState();
// }

// class _PostBlogState extends State<PostBlog> {
//   late String authorName, title, desc ;
//   final ImagePicker _imagePicker = ImagePicker();

//   CrudMethods crudMethods = CrudMethods();
//    File? selectedImage;

//    bool _isLoading = false;

//   Future getImage() async{
//     var image = await _imagePicker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       selectedImage =  File(image!.path);
//     });
  

   
//   }
//    uploadBlog() async{
//       if(selectedImage != null){

//         setState(() {
//           _isLoading = true;
//         });
//         //uploading image
        
//        Reference firebaseStorageref =  FirebaseStorage.instance.ref()
//       .child('blogImages')
//       .child("${randomAlphaNumeric(9)}.jpg");
      

      

//       final StorageUploadTask = firebaseStorageref.putFile(selectedImage!);
//       var downloadUrl = await  ( await StorageUploadTask).ref.getDownloadURL();
//       print('this is url $downloadUrl');

//       Map<String, String> blogMap = {
//         "imageUrl": downloadUrl,
//         "authorName": authorName,
//         "title": title,
//         "description": desc
//       };
//       crudMethods.addData(blogMap).then((result) {
//          Navigator.pop(context);
//       } );
     
//       }else{}
//     }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 5,
//         backgroundColor: Colors.deepPurple,
//         title: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
              
//               Text("WE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//               Text("BLOG", style: TextStyle(color: Color(0xFFAA00FF), fontWeight: FontWeight.bold),)
//             ],
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           GestureDetector(
//             onTap: (){
//              uploadBlog();
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Icon(Icons.file_upload))
//           )
//         ],
//       ),

//       //body

//       body: _isLoading? Container(
//         alignment: Alignment.center,
//         child: CircularProgressIndicator(
//           color: Colors.deepPurple,
//         ),
//       ) 
//       : Container(
//         child:  Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),

//             GestureDetector(
//               onTap: getImage,
//               child: selectedImage != null ? Container(
//                 margin: EdgeInsets.symmetric(horizontal: 16),
//                  height: 150,
//                 width: MediaQuery.of(context).size.width,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(6),
//                   child: Image.file(selectedImage!, fit: BoxFit.cover,)),
//               )
//                : Container(
//                 margin: EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(6)
//                 ),
//                 height: 150,
//                 width: MediaQuery.of(context).size.width,
//                 child: Icon(Icons.add_a_photo),
//               ),
//             ),

//             SizedBox(
//               height: 8,
//             ),

//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 6),
//               child: Column(
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(
//                       hintText: "Author Name",
//                     ),
//                     onChanged: (val){
//                       authorName = val;
//                     },
//                   ),

//                     TextField(
//                     decoration: InputDecoration(
//                       hintText: "Title",
//                     ),
//                     onChanged: (val){
//                       title = val;
//                     },
//                   ),


//                     TextField(
//                     decoration: InputDecoration(
//                       hintText: "Description",
                      
//                     ),
//                     onChanged: (val){
//                       desc = val;
//                     },
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ) ,

//     );
//   }
// }

///posts


//    DocumentSnapshot? blogsSnapshot;
//   CrudMethods crudMethods = CrudMethods();
//  Widget BlogsList(){
//    return Container(
//      child: Column(
//        children: [
//            StreamBuilder(
//         stream: FirebaseFirestore.instance.collection("blog").snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//           if (snapshot.hasData) {
//             if ((snapshot.data?.docs.length ?? 0) > 0) {
//             return ListView.builder(
//              itemCount: snapshot.data?.docs.length,
//            itemBuilder: (context, index){
//              return BlogsTile(
               
//                imgUrl: blogsSnapshot!['imageUrl'],
//                authorName: blogsSnapshot!['authorName'],
//                title: blogsSnapshot!['title'] ,
//                 description: blogsSnapshot!['description']
//                 );
//            });
//             }else {
//               return Center(
//                 child: Text(
//                   "No Data",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               );
//             }
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           }
        
//         ),
//        ]
//      )
//    );
       
//  }
     
//         @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     crudMethods.getData().then((value){
//       blogsSnapshot =value;
//     });
//   }



//
// class BlogsTile extends StatelessWidget {
//   String imgUrl, title, description, authorName;
//    BlogsTile({Key? key, required this.imgUrl, required this.authorName, 
// required this.title, required this.description}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: [
//           ClipRRect(
//              borderRadius: BorderRadius.circular(6),
//             child: Image.network(imgUrl)),
//           Container(
//             height: 150 ,
//             decoration: BoxDecoration(
//               color: Colors.black45.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(6)
//             ),
//           ),

//           Container(
//             child: Column(
//               children: [
//                 Text(title),
//                 Text(description),
//                 Text(authorName)
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
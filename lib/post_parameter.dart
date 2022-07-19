import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_blog/details_blog.dart';


class CardUl extends StatefulWidget {
  DocumentSnapshot? documentSnapshot;
   CardUl({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<CardUl> createState() => _CardUlState();
}

class _CardUlState extends State<CardUl> {
  bool descTextShowFlag = false;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (() {
        var route = MaterialPageRoute(
            builder: (BuildContext) =>
                Details(documentSnapshot: widget.documentSnapshot));
        Navigator.push(context, route);
      }),
      child: Card(
       margin: EdgeInsets.all(20.0),
       elevation: 2.0,
       child: Container(
         padding: EdgeInsets.all(25.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(widget.documentSnapshot!['date'],
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   fontSize:  16,
                   color: Colors.grey,
                   fontStyle: FontStyle.italic

                 ),),

 
                  Text(widget.documentSnapshot!['title'],
                  textAlign: TextAlign.center,
                 style:  GoogleFonts.bebasNeue(
                   fontSize:  16,
                   color: Colors.black,
                   fontWeight: FontWeight.bold

                 ),),

                 
                  Text(widget.documentSnapshot!['authorName'],
                  textAlign: TextAlign.center,
                 style: TextStyle(
                   fontSize:  16,
                   color: Colors.blue,
                   fontWeight: FontWeight.bold

                 ),),

               ],
             ),

             SizedBox(
               height: 10.0,
             ),

             Image.network(
               widget.documentSnapshot!['imgUrl'],
             width: double.infinity,
             height: 300,
             fit: BoxFit.cover,
             ),

             SizedBox(
               height: 10,
             ),

             Text(widget.documentSnapshot!['desc'],
              maxLines: descTextShowFlag ? 8 : 2,textAlign: TextAlign.start,
                  
                 style: GoogleFonts.nunito(
                   fontSize:  20,
                   color: Colors.black,
                   

                 ),),


           ],
         ),
       ),
   ),
    );
 }
//  late String imageUrl;
  // late String  desc;
  // late String date;
  // late String title;


    
  }
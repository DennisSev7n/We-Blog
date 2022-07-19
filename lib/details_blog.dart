import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Details extends StatefulWidget {
  DocumentSnapshot? documentSnapshot;
  Details({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(widget.documentSnapshot!['title'], style: TextStyle(color: Color(0xFFAA00FF), fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6)
                ),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.network(
             widget.documentSnapshot!['imgUrl'],
           width: double.infinity,
           height: 300,
           fit: BoxFit.cover,
           ),
              ),
            
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Text(
                widget.documentSnapshot!['title'],
                style:  GoogleFonts.bebasNeue(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Text(
                widget.documentSnapshot!['desc'],
                style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
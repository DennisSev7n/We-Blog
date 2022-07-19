
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
   RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);
  var currentUser = FirebaseAuth.instance.currentUser;


  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
     _emailController.dispose();
    _passwordController.dispose();
    confirmpasswordController.dispose();
    _ageController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();

  }

  Future signUp() async{
   if (passwordConfirmed()){

     showDialog(context: context,
     builder:(context){
       return Center(child: CircularProgressIndicator(
         color: Colors.deepPurpleAccent,
       ));
     }
     );

     // create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim());


      //add user details
      addUserDetails(
        _firstnameController.text.trim(),
       _lastnameController.text.trim(),
       _emailController.text.trim(),
       int.parse( _ageController.text.trim(),)
        );
   }
//pop loading circle
   Navigator.of(context).pop();
  }

  Future addUserDetails(String firstName, String lastName,  String email, int age) async{
   await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).set({
     'first name': firstName,
     'last name': lastName ,
     'age': age,
     'email': email,
   }) ;
  }

  bool passwordConfirmed() {
    if( _passwordController.text.trim() == confirmpasswordController.text.trim()){
      return true;
    }else{
return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.grey[300]  ,
body: Center(
  child:   SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
       children: [ 
    // Icon(Icons.rss_feed,
    // size: 100,),

    SizedBox(
      height: 75,
    ),
      //Hello Again
      Text("Hello There", style: GoogleFonts.bebasNeue(
         fontSize: 52,
      ),),

      SizedBox(
        height: 10,
      ),
    
    Text("Register below with your details", style: TextStyle( fontSize: 24),),

    SizedBox(
        height: 50,
      ),
    
    
    
    
    
    
    //first name textfiled
     Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: _firstnameController,
decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "First Name", 
          filled: true,
),
          ),
        ),
      ),
    ),
       
    SizedBox(
      height: 10,
    ),
    //last name textfield

     Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: _lastnameController,
decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Last Name", 
          filled: true,
),
          ),
        ),
      ),
    ),
    
    
    
 
    
    
    
    SizedBox(
      height: 10,
    ),

    //age 
     Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: _ageController,
decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Age", 
          filled: true,
),
          ),
        ),
      ),
    ),
    
    
    
    
    SizedBox(
      height: 10,
    ),
      //Email textfield
    
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: _emailController,
decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Email", 
          filled: true,
),
          ),
        ),
      ),
    ),
    
    
    
    
    SizedBox(
      height: 10,
    ),
      ///password textfield
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Password", 
          filled: true,
),
          ),
        ),
      ),
    ),

    // confirm password textfield

     SizedBox(
      height: 10,
    ),
      ///password textfield
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: confirmpasswordController,
            obscureText: true,
decoration: InputDecoration(
          border: InputBorder.none,
          hintText: " Confirm Password", 
          filled: true,
),
          ),
        ),
      ),
    ),
      
    
    
    
    
    SizedBox(
      height: 10,
    ),
      //sign in button
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: GestureDetector(
          onTap: signUp,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12)),
child: Center(child: Text("Sign Up",
style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold
),)),
          ),
        ),
      ),
    
    
    
    
    
    SizedBox(
      height: 25,
    ),
    
      //not a member? register now
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already a member? ", style: TextStyle( fontWeight: FontWeight.bold)),

        GestureDetector(
          onTap: widget.showLoginPage ,
          child: Text("Login", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
      ],
    )
    
    
    ],
    
    ),
  ),
),
    );
  }
}
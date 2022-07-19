import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_blog/auth_screens/forgot_password.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //text controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async{
    //loading circle
    showDialog(context: context,
     builder:(context){
       return Center(child: CircularProgressIndicator(
         color: Colors.deepPurpleAccent,
       ));
     }
     );
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
//pop the loading circle
Navigator.of(context).pop();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
    Icon(Icons.rss_feed,
    size: 100,),

    SizedBox(
      height: 75,
    ),
      //Hello Again
      Text("Hello Again!", style: GoogleFonts.bebasNeue(
         fontSize: 52,
      ),),

      SizedBox(
        height: 10,
      ),
    
    Text("Welcome back! you\'ve been missed", style: GoogleFonts.bebasNeue( fontSize: 24),),

    SizedBox(
        height: 50,
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
    SizedBox(
      height: 10,
    ),

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context){
              return ForgotPasswordPage();
            }));},
            child: Text("Forgot Password?", style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold
            ),),
          ),
        ],
      ),
    ),
      
    
    
    
    
    SizedBox(
      height: 10,
    ),
      //sign in button
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: GestureDetector(
          onTap: signIn,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12)),
child: Center(child: Text("Sign in",
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
        Text("Not a member? ", style: TextStyle( fontWeight: FontWeight.bold)),

        GestureDetector(
          onTap: widget.showRegisterPage ,
          child: Text("Register Now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
      ],
    )
    
    
    ],
    
    ),
  ),
),
    );
    
  }
}
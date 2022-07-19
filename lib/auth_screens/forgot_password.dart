
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text("Password reset link sent! check your email"),
      );
    });
  } on FirebaseAuthException catch (e) {
    print(e);

    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text(e.message.toString()),
      );
    });
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text("Enter your Email and we willsend you a rest link",
            textAlign: TextAlign.center,),
          ),
          
          SizedBox(
            height: 10,
          ),

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

    MaterialButton(onPressed: passwordReset,
    child: Text("Reset Password"),
    color: Colors.deepPurple[200],
    )
    
        ],
      ),
    );
  }
}
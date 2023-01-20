import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future Reset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content:Text('A link to reset your password was sent. Check your Email!', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
        );
      });
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content:Text(e.message.toString().substring(0,57), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Please enter your Email. We will sent you a link to reset your password! ', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20),textAlign: TextAlign.center,),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: 'Email Address',
                  suffixIcon: Icon(Icons.mail)
              ),
            ),
          ),
          MaterialButton(
              onPressed: (){Reset();},
              child: Text('Reset Password', style: TextStyle(color: Colors.white),),
              color: Colors.blue,
          )
        ],
      ),
    );
  }
}

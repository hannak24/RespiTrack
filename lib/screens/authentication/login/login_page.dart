import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:respi_track/screens/authentication/register/register_page.dart';
import '../../../main/main_page.dart';
import '../../home/setHomePage.dart';
import '../forgot_password/forgot_password_page.dart';



class LoginPage extends StatefulWidget{

  const  LoginPage({Key? key}) :super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future SignIn() async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      if (user != null) {
        setState(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        });
      }
      else {
        final snackBar = SnackBar(
          content: const Text('Wrong authentication credentials!'),
          action: SnackBarAction(
            label: 'Got it',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print("no such user!");
      final snackBar = SnackBar(
        content: const Text('Wrong authentication credentials!'),
        action: SnackBarAction(
          label: 'Got it',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  
  void _pushRegisterPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  RegisterPage();
    }));
  }
  void _pushForgotPassword() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  ForgotPassword();
    }));
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 880,
            width: 400,
            decoration: BoxDecoration( gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE3F2FD),
                Color(0xFF2196F3),
                Color(0xFF1A237E),
              ]
            )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  SizedBox(height: 80,),
                  CircleAvatar(
                    backgroundColor: Colors.white54,
                    backgroundImage:AssetImage('images/logo1.png'),
                    radius: 95,

                  ),
                 // Image.asset('images/logo1.png'),
                  SizedBox(height: 5,),
                  const Text('RespiTrack', style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold ),),
                  SizedBox(height: 50,),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 350,
                          width: 300,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.white,),
                          child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 30,),
                              Text('Welcome back!', style:GoogleFonts.bebasNeue(
                                fontSize: 30, color: Colors.black54),),
                              const SizedBox(height: 10,),
                             // Text('Welcome back', style: TextStyle(
                               // fontSize: 20,
                                //fontWeight: FontWeight.w500, color: Colors.black),),
                              const SizedBox(height: 10,),
                              Container(
                                width: 259,
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      hintText: 'Email Address',
                                      suffixIcon: Icon(Icons.mail)
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              Container(
                                width: 259,
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      suffixIcon: Icon(Icons.lock)
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                        onTap: (){_pushForgotPassword();},
                                        child: Text('Forgot Password?', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                                child: GestureDetector(
                                  onTap: SignIn,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(40),gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFE3F2FD),
                                          Color(0xFF2196F3),
                                          Color(0xFF1A237E),
                                        ]
                                    )),
                                    child: Center(
                                      child: Text('Sign In', style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account?", style: TextStyle(color: Colors.black54)),
                                  GestureDetector(
                                      onTap: (){_pushRegisterPage();} ,
                                      child: Text(" Register Now", style: TextStyle(color:Colors.blue, fontWeight: FontWeight.bold),))
                                ],
                              ),

                            ],

                          ),
                    ),


                        ),
                      ],
                    ),
                ],

              ),

          ),
        ],
      ),
    ),
    );
  }
}
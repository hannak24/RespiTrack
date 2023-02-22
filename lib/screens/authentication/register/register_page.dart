import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:respi_track/screens/authentication/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'splashScreenRegister.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future SignUp() async{
    if( _passwordController.text.trim() == _confirmPasswordController.text.trim()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(), password: _passwordController.text.trim());
    }
    _pushSplashScreen();
  }

  void _pushSplashScreen(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  SplashScreen();
    }));

  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _pushLogin() {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ == 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 780,
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
                    SizedBox(height: 20,),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 400,
                            width: 300,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.white,),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 30,),
                                  Text('Register below!', style:GoogleFonts.bebasNeue(
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
                                  const SizedBox(height: 15,),
                                  Container(
                                    width: 259,
                                    child: TextField(
                                      controller: _confirmPasswordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: 'Confirm Password',
                                          suffixIcon: Icon(Icons.lock)
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                                    child: GestureDetector(
                                      onTap: SignUp,
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
                                          child: Text('Sign Up', style: TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("I have an account! ", style: TextStyle(color: Colors.black54)),
                                      GestureDetector(
                                          onTap: (){_pushLogin();},
                                          child: Text("Login now", style: TextStyle(color:Colors.blue, fontWeight: FontWeight.bold),))
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

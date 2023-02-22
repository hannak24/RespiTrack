/*import 'package:flutter/material.dart';
import 'package:respi_track/login_page.dart';
import 'register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
   bool showLoginPage= true;

  void swapScreens(){
     setState(() {
       showLoginPage != showLoginPage;
     });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(showRegisterPage: swapScreens);
    }
    else{
      return RegisterPage(showLoginPage: swapScreens);
    }
  }
}
*/
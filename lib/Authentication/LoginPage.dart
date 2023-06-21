import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({
    Key? key,
  required this.onClickedSignUp,
  }) :super(key: key);
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}
class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) => SingleChildScrollView(
        padding: EdgeInsets.all(16) ,
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 250,),
          SafeArea(child: Text('LOGIN PAGE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),)),
          SizedBox(height: 30,),
          TextField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Email"),
          ),
          SizedBox(height: 4),
          TextField(
            controller: passwordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: "password"),
            obscureText: true,
          ),
          SizedBox(height: 20,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
          ),
            icon: Icon(Icons.lock_open,size: 32,),
            label: Text(
              'Sign In',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signIn,
          ),
          SizedBox(height: 20,),
          RichText(text: TextSpan(
            style: TextStyle(color: Colors.white,),
            text:'NO account',
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                ..onTap= widget.onClickedSignUp,
                text: 'Sign Up',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),),
        ],
      ),
    );
    Future signIn() async{
      showDialog(
          context: context,
          barrierDismissible: false,
          builder:(context) => Center(child: CircularProgressIndicator(),),
      );
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password:passwordController.text.trim(),
        );
      } on Exception catch (e) {
        print(e);
        // TODO
      }
      // Navigator.of(context) not working!
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
}

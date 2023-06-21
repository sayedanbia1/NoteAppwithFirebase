import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Utils.dart';
import '../main.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) :super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  var email= "aadaffa@gmail.com";
  final formKey= GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => SingleChildScrollView(

    padding: EdgeInsets.all(16) ,
    child:Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 250,),
          SafeArea(child: Text('REGISTER PAGE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),)),
          SizedBox(height: 30,),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Email"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // validator: (email)=>
            // email != null && EmailValidator.validate(email)
            //     ? 'Enter a valid email'
            //     : null,
          ),
          SizedBox(height: 4),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: "password"),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value)=>
            value != null && value.length<6
                ? 'Enter min.6 charachters'
                : null,
          ),
          SizedBox(height: 20,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.arrow_forward,size: 32,),
            label: Text(
              'SIGN UP',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signUp,
          ),
          SizedBox(height: 20,
          ),
          RichText(text: TextSpan(
            style: TextStyle(color: Colors.white,),
            text:'Already have an account?',
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap= widget.onClickedSignIn,
                text: 'Log in',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),),
        ],
      ),
    ),
  );
  Future signUp() async {
    final isValid =formKey.currentState!.validate();
    if(!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder:(context) => Center(child: CircularProgressIndicator(),
        ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password:passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);


    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

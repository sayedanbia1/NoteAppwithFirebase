import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/home_screen.dart';

import 'Utils.dart';



class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified= false;
  bool canResentEmail=false;
  Timer? timer;

  void initState(){
    super.initState();
    isEmailVerified= FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified){
      sendVerificationEmail();

      timer =Timer.periodic(
        Duration(seconds: 3),
          (_)=> checkEmailVerified(),
      );
    }
  }
  void dispose(){
    timer?.cancel();
    super.dispose();
  }
  Future checkEmailVerified() async{
    //call after email verification
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified= FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }
  Future sendVerificationEmail() async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResentEmail=false);
      await Future.delayed(Duration(seconds: 5));
      setState(()=> canResentEmail= true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
  @override
  Widget build(BuildContext context)=>isEmailVerified
      ? HomeScreen()
      : Scaffold(
    appBar: AppBar(title: Text
      ('VERIFY EMAIL'),),
    body: Padding(padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'A verification email has been sent to you email',style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.email,size: 32),
            label: Text('RESENT EMAIL',style: TextStyle(fontSize: 24),
            ),
            onPressed:canResentEmail ? sendVerificationEmail :null,
          ),
          TextButton(
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              child: Text('cancel',style: TextStyle(fontSize: 24)
                ,),
            onPressed: ()=> FirebaseAuth.instance.signOut(),
            
          )
        ],
      ),
    ),
  );
}

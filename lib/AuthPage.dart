import 'package:flutter/material.dart';
import 'package:note_app/LoginPage.dart';
import 'SignUpWidget.dart';



class AutoPag extends StatefulWidget {
  const AutoPag({super.key});
  @override
  State<AutoPag> createState() => _AutoPagState();
}
class _AutoPagState extends State<AutoPag> {
  bool isLogin= true;
  @override
  Widget build(BuildContext context) =>
      isLogin
          ? LoginWidget(onClickedSignUp: toggle)
          : SignUpWidget(onClickedSignIn: toggle);
  void toggle()=> setState(()=>isLogin =!isLogin);
}

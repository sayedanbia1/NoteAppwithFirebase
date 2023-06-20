import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/LoginPage.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'AuthPage.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(MyApp());
}
final navigatorKey= GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'NoteApp',
      theme: ThemeData.dark(),
      home:Home(),
    );
  }
}
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context,snapshot){
          if(snapshot.hasData){
            return HomeScreen();
  }else{
            return AutoPag();
  }
      }
    ),
  );
}


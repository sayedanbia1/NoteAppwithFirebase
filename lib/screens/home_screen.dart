import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/screens/note_editor.dart';
import 'package:note_app/screens/note_reader.dart';
import 'package:note_app/widget/note_card.dart';
import '../styles/App_style.dart';
import 'package:note_app/Authentication/profile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child:  ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('about us'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>myapp()),);
                },
              ),
              ListTile(
                title: const Text('signOut'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
      ),
      backgroundColor: appstyle.bgcolor,
      appBar: AppBar(
        title: Center(child: Text("Note App")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Recent Notes",style: GoogleFonts.roboto(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData){
                return GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                ),
                children: snapshot.data!.docs.map((note)=>notecard((){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteReaderScreen(note),
                  ),
                  );
                },note)).toList(),
                );
              }
              return Text("there is no Notes",style:GoogleFonts.nunito(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12) ,);
              },
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteEditorScreen()));
        },
        label: Text("add Note"),
        icon: Icon(Icons.add),
      ),

    );
  }
}

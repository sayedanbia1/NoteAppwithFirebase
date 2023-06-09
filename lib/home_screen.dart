import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/widget/note_card.dart';
import 'styles/App_style.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                children: snapshot.data!.docs.map((note)=>notecard((){},note)).toList(),
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
        onPressed: (){},
        label: Text("add Note"),
        icon: Icon(Icons.add),
      ),
    );
  }
}

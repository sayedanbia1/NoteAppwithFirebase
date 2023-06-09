import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/styles/App_style.dart';

class NoteReaderScreen extends StatefulWidget {
   NoteReaderScreen(this.doc,{super.key});
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}
class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id=widget.doc['color_id'];
    return Scaffold(
      backgroundColor: appstyle.cardscolor[color_id],
      appBar: AppBar(
        backgroundColor: appstyle.cardscolor[color_id],
        elevation: 0.0,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.doc["note_title"],
            style: appstyle.maintitle,),
          SizedBox(
            height: 8.0,
          ),
          Text(
            widget.doc["creation_date"],style: appstyle.datatitle,),
          SizedBox(
            height: 28.0,
          ),
          Text(
            widget.doc["note_content"],
            style: appstyle.maincontent,
            overflow: TextOverflow.ellipsis,),
        ],
    ),
      ),
    );
  }
}




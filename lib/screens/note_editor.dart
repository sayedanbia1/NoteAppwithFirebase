import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/styles/App_style.dart';


class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id=Random().nextInt(appstyle.cardscolor.length);
  String date =DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: appstyle.cardscolor[color_id],
        appBar: AppBar(
        backgroundColor:appstyle.cardscolor[color_id],
        elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Center(
            child: Text("Add New Note",
              style: TextStyle(color: Colors.black),),
          ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Title',
                ),
                style: appstyle.maintitle,
              ),

              SizedBox(height: 8.0),
              Text(date,style: appstyle.datatitle,),
              SizedBox(height: 8.0),

              TextField(
                controller: _mainController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Title',
                ),
                style: appstyle.maincontent,
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appstyle.accentcolor,
        onPressed: () async{
        FirebaseFirestore.instance.collection("Notes").add({
          "note_title":_titleController,
          "creation_date":date,
          "note_content":_mainController,
          "color_id":color_id,
        }).then((value){
          print(value.id);
          Navigator.pop(context);
        }).catchError((error)=>print("faield to add new Note due to $error"));
      },child: Icon(Icons.save),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_app/styles/App_style.dart';



class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id=Random().nextInt(appstyle.cardscolor.length);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: appstyle.cardscolor[color_id],
        appBar: AppBar(
        backgroundColor:appstyle.cardscolor[color_id],
        elevation: 0.0,
          title: Text("Add New Note"),
      ),
      
    );
  }
}

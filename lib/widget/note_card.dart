import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/styles/App_style.dart';

  Widget notecard(Function()? ontap, QueryDocumentSnapshot doc){
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: appstyle.cardscolor[doc['color_id']],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doc["note_title"],
              style: appstyle.maintitle,),
            SizedBox(
              height: 8.0,
            ),
            Text(
              doc["creation_date"],style: appstyle.datatitle,),
            SizedBox(
              height: 8.0,
            ),
            Text(
              doc["note_content"],style: appstyle.maincontent,),
          ],
        ),
      ),
    );
  }
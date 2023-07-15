import 'dart:async';
import 'package:attendance_app/ui/auth/login_screen.dart';
import 'package:attendance_app/ui/firestore/firestore_data.dart';
import 'package:attendance_app/ui/posts/post_screen.dart';
import 'package:attendance_app/ui/upload_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SplashServices{
  void isLogin(BuildContext context){
    final auth= FirebaseAuth.instance;
    final user= auth.currentUser;
    if(user != null){
      Timer(const Duration(seconds: 3), () =>{
        // Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageScreen())),
        Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen())),
        // Navigator.push(context, MaterialPageRoute(builder: (context) => FireStoreMark())),
      });
    }
    else
      {
        Timer(const Duration(seconds: 3), () =>{
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
        });
      }
  }
}
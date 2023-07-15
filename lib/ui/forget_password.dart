

import 'package:attendance_app/utils/utils.dart';
import 'package:attendance_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailControl= TextEditingController();
  final auth= FirebaseAuth.instance;
  bool loading= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: emailControl,
              decoration: InputDecoration(
                hintText: 'email'
              ),
            ),
            SizedBox(height: 40,),
            RoundButton(title: 'Forget Password',loading: loading, onTap: (){
              setState(() {
                loading= true;
              });
             auth.sendPasswordResetEmail(email: emailControl.text.toString()).then((value){
               Utils().toastMessage1('email sent recover your password, plz check mail');
               setState(() {
                 loading= false;
               });
             }).onError((error, stackTrace){
               setState(() {
                 loading= false;
               });
               Utils().toastMessage(error.toString());
             });
            })
          ],
        ),
      ),
    );
  }
}

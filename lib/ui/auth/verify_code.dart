import 'package:attendance_app/ui/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';


class VerifyCodeScreen extends StatefulWidget {

  String verificationId;

   VerifyCodeScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading= false;
  final verifyCodeControl= TextEditingController();
  final auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80,),
            TextFormField(
              controller: verifyCodeControl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '6 digit code'
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Verify Code',loading: loading, onTap: () async{

              setState(() {
                loading= true;
              });
              final credential= PhoneAuthProvider.credential(
              verificationId: widget.verificationId,
              smsCode: verifyCodeControl.text.toString(),
               );

              try{
               await auth.signInWithCredential(credential);

               Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
              }
              catch(e){
                setState(() {
                  loading= false;
                });
                Utils().toastMessage(e.toString());
              }


              // setState(() {
              //   loading= true;
              // });
              // auth.verifyPhoneNumber(
              //     phoneNumber: phoneNumberControl.text.toString(),
              //     verificationCompleted: (_){
              //       setState(() {
              //         loading= false;
              //       });
              //     },
              //     verificationFailed: (e){
              //       setState(() {
              //         loading= false;
              //       });
              //       Utils().toastMessage(e.toString());
              //     },
              //     codeSent: (String verificationId, int? token){
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCodeScreen(verificationId: verificationId,)));
              //       setState(() {
              //         loading= false;
              //       });
              //     },
              //     codeAutoRetrievalTimeout: (e){
              //       Utils().toastMessage(e.toString());
              //       setState(() {
              //         loading= false;
              //       });
                  //});
            })
          ],
        ),
      ),
    );
  }
}

import 'package:attendance_app/ui/auth/verify_code.dart';
import 'package:attendance_app/utils/utils.dart';
import 'package:attendance_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginWithPhoneNummber extends StatefulWidget {
  const LoginWithPhoneNummber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNummber> createState() => _LoginWithPhoneNummberState();
}

class _LoginWithPhoneNummberState extends State<LoginWithPhoneNummber> {
  bool loading= false;
  final phoneNumberControl= TextEditingController();
  final auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80,),
            TextFormField(
              controller: phoneNumberControl,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '+92 328 4102 897'
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Login with Phone Number',loading: loading, onTap: (){

              setState(() {
                loading= true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phoneNumberControl.text.toString(),
                  verificationCompleted: (_){
                    setState(() {
                      loading= false;
                    });
                  },
                  verificationFailed: (e){
                    setState(() {
                      loading= false;
                    });
                  Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCodeScreen(verificationId: verificationId,)));
                  setState(() {
                    loading= false;
                  });
                  },
                  codeAutoRetrievalTimeout: (e){
                    Utils().toastMessage(e.toString());
                    setState(() {
                      loading= false;
                    });
                  });
            })
          ],
        ),
      ),
    );
  }
}

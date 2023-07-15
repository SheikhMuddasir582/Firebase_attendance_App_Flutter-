
import 'package:attendance_app/ui/auth/login_phone_number.dart';
import 'package:attendance_app/ui/auth/sign_up.dart';
import 'package:attendance_app/ui/firestore/firestore_data.dart';
import 'package:attendance_app/ui/firestore/firestore_screen.dart';
import 'package:attendance_app/ui/forget_password.dart';
import 'package:attendance_app/ui/posts/post_screen.dart';
import 'package:attendance_app/utils/utils.dart';
import 'package:attendance_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailControl= TextEditingController();
  final passwordControl= TextEditingController();
  final _formkey= GlobalKey<FormState>();
  bool loading= false;

  final _auth= FirebaseAuth.instance;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControl.dispose();
    passwordControl.dispose();
  }

  void login(){
    setState(() {
      loading= true;
    });
    _auth.signInWithEmailAndPassword(email: emailControl.text.toString(),
        password: passwordControl.text.toString()).then((value){
      Utils().toastMessage1(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => FireStoreMark()));
        setState(() {
          loading= false;
        });

    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
        setState(() {
          loading= false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('login'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailControl,
                        decoration: InputDecoration(
                          hintText: 'Email',

                          prefixIcon: const Icon(
                            Icons.alternate_email,
                            color: Color(0xff323F4B),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                             return 'enter email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordControl,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'password',
                          prefixIcon: const Icon(
                            Icons.lock_open,
                            color: Color(0xff323F4B),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'enter password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30,),
                    ],
                  )),
             RoundButton(title: 'Login',
             loading: loading,
             onTap: (){
               if(_formkey.currentState!.validate()){
                 login();
               }
             },
             ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
                }, child: Text('Forget Password?', style: TextStyle(decoration: TextDecoration.underline),)),
              ),

              SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("don't have an account?"),
              TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              }, child: Text('sign up')),
            ],
        ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPhoneNummber()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black,
                    )
                  ),
                  child: Center(
                    child: Text('Login with Phone'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

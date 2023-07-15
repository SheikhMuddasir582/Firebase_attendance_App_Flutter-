import 'package:attendance_app/ui/auth/login_screen.dart';
import 'package:attendance_app/utils/utils.dart';
import 'package:attendance_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final emailControl= TextEditingController();
  final passwordControl= TextEditingController();
  final _formkey= GlobalKey<FormState>();
  FirebaseAuth _auth= FirebaseAuth.instance;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControl.dispose();
    passwordControl.dispose();
  }

  void SignUp(){
    setState(() {
      loading= true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailControl.text.toString(),
        password: passwordControl.text.toString()).then((value){
      setState(() {
        loading= false;
      });
    }).onError((error, stackTrace){
      Utils().toastMessage(error.toString());
      // Utils().toastMessage(error.toString());
      setState(() {
        loading= false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        //automaticallyImplyLeading: false,
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
                    SizedBox(height: 50,),
                  ],
                )),
            RoundButton(title: 'Sign Up',
              loading: loading,
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  SignUp();
                }
              }),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                }, child: Text('Login')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



import 'package:attendance_app/ui/auth/login_screen.dart';
import 'package:attendance_app/ui/upload_image.dart';
import 'package:attendance_app/utils/utils.dart';
import 'package:attendance_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'mark_attendance.dart';

class PostScreen extends StatefulWidget {

  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Mark');
  final markControl= TextEditingController();
  final dateControl= TextEditingController();
  final auth= FirebaseAuth.instance;
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Portal'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
    },
        icon: Icon(Icons.logout_outlined),),
          SizedBox(width: 10,),
        ],
      ),
      body: Column(
        children:[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.center,
                child: Text('Arid University', style: TextStyle(fontSize: 30),)),
          ),
          SizedBox(height: 5,),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RoundButton(title: 'upload image', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageScreen()));
            }),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: markControl,
              decoration: InputDecoration(
                hintText: 'mark your Attendance',
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return 'enter attendance';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: dateControl,
              decoration: InputDecoration(
                hintText: 'enter date',
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return 'enter date';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    String id= DateTime.now().millisecondsSinceEpoch.toString();
    //Navigator.push(context, MaterialPageRoute(builder: (context) => MarkScreen()));
       //'id' :    DateTime.now().millisecondsSinceEpoch.toString(),
       //child(DateTime.now().millisecondsSinceEpoch.toString()).set
    databaseRef.child(id).set({
    'attendance': markControl.text.toString(),
    'date': dateControl.text.toString(),
    'id': id,
    }).then((value){
    Utils().toastMessage1('attendance marked');
    }).onError((error, stackTrace){
    Utils().toastMessage(error.toString());
    });

                    },
                  child: Container(
                    height: 50,
                    width: 150,
                    child: Center(child: Text('Mark Attendance', style: TextStyle(color: Colors.white),)),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MarkScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    child: Center(child: Text('View Attendance', style: TextStyle(color: Colors.white),)),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              showDialog(context: context, builder: (context) => AlertDialog(
                title: Text('Leave'),
                content: Text('Are you sure ?'),
                actions: [
                  TextButton(onPressed: (){
                    auth.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                    });
                  }, child: Container(
                    height: 50,
                    width: 200,
                    child: Center(child: Text('Leave', style: TextStyle(color: Colors.white),)),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ), ),
                ],
              ));
            },
            child: Align(alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 150,
                child: Center(child: Text('Leave', style: TextStyle(color: Colors.white),)),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }



}


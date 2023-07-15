import 'package:attendance_app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/round_button.dart';





class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  bool loading =false;
  // final databaseRef = FirebaseDatabase.instance.ref('Mark');
  // final searchControl= TextEditingController();
  final fireStore= FirebaseFirestore.instance.collection('Mark').snapshots();
  CollectionReference ref=  FirebaseFirestore.instance.collection('Mark');
  // final ref1= FirebaseFirestore.instance.collection('Mark');
  final editControl= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View Attendance'),
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: TextFormField(
            //     controller: searchControl,
            //     decoration: InputDecoration(
            //       hintText: 'Search',
            //       border: OutlineInputBorder(),
            //     ),
            //     onChanged: (String value){
            //       setState(() {
            //
            //       });
            //     },
            //   ),
            // ),
            SizedBox(height: 10,),
            StreamBuilder<QuerySnapshot>(
                stream: fireStore,
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  if(snapshot.hasError)
                    return Text('error try again');
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index){
                            final date= snapshot.data!.docs[index]['date'].toString();
                            return ListTile(
                              // title: Text(snapshot.data!.docs[index].id.toString()),
                              title: Text(snapshot.data!.docs[index]['attendance'].toString()),
                              subtitle: Text(snapshot.data!.docs[index]['date'].toString()),
                              trailing: PopupMenuButton(
                                icon: Icon(Icons.more_vert),
                                itemBuilder: (context) =>
                                [
                                  PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        onTap: (){
                                          Navigator.pop(context);
                                          showMyDialog(date, snapshot.data!.docs[index]['id'].toString());
                                          // ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                                          //   'title': 'hello'
                                          // }).then((value){
                                          //
                                          // }).onError((error, stackTrace){
                                          //
                                          // });
                                        },
                                        leading: Icon(Icons.edit),
                                        title: Text('Edit'),
                                      )),
                                  PopupMenuItem(
                                      value: 2,
                                      child: ListTile(
                                        onTap: (){
                                          Navigator.pop(context);
                                          // databaseRef.child(snapshot.child('id').value.toString()).remove();
                                          ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                                        },
                                        leading: Icon(Icons.delete_outline),
                                        title: Text('Delete'),
                                      )),
                                ],
                              ),
                            );
                          }),


                      // child: FirebaseAnimatedList(
                      //     query: databaseRef,
                      //     defaultChild: Text('Loading'),
                      //     itemBuilder: (context, snapshot, animation, index) {
                      //
                      //       final date= snapshot.child('date').value.toString();
                      //
                      //       if(searchControl.text.isEmpty){
                      //         return ListTile(
                      //           title: Text(snapshot.child('attendance').value.toString()),
                      //           subtitle: Text(snapshot.child('date').value.toString()),
                      //           trailing: PopupMenuButton(
                      //             icon: Icon(Icons.more_vert),
                      //             itemBuilder: (context) =>
                      //             [
                      //               PopupMenuItem(
                      //                   value: 1,
                      //                   child: ListTile(
                      //                     onTap: (){
                      //                       Navigator.pop(context);
                      //                       showMyDialog(date, snapshot.child('id').value.toString());
                      //                     },
                      //                     leading: Icon(Icons.edit),
                      //                     title: Text('Edit'),
                      //                   )),
                      //               PopupMenuItem(
                      //                   value: 2,
                      //                   child: ListTile(
                      //                     onTap: (){
                      //                       Navigator.pop(context);
                      //                       databaseRef.child(snapshot.child('id').value.toString()).remove();
                      //                     },
                      //                     leading: Icon(Icons.delete_outline),
                      //                     title: Text('Delete'),
                      //                   )),
                      //             ],
                      //           ),
                      //         );
                      //       }
                      //       else if(date.toLowerCase().contains(searchControl.text.toLowerCase().toString())){
                      //         return ListTile(
                      //           title: Text(snapshot.child('attendance').value.toString()),
                      //           subtitle: Text(snapshot.child('date').value.toString()),
                      //         );
                      //       }
                      //       else{
                      //         return Container();
                      //       }
                      //     }
                      // ),
                    );
                }),
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: 3,
            //       itemBuilder: (context, index){
            //     return ListTile(
            //       title: Text('hello'),
            //     );
            //   }),
            //   // child: FirebaseAnimatedList(
            //   //     query: databaseRef,
            //   //     defaultChild: Text('Loading'),
            //   //     itemBuilder: (context, snapshot, animation, index) {
            //   //
            //   //       final date= snapshot.child('date').value.toString();
            //   //
            //   //       if(searchControl.text.isEmpty){
            //   //         return ListTile(
            //   //           title: Text(snapshot.child('attendance').value.toString()),
            //   //           subtitle: Text(snapshot.child('date').value.toString()),
            //   //           trailing: PopupMenuButton(
            //   //             icon: Icon(Icons.more_vert),
            //   //             itemBuilder: (context) =>
            //   //             [
            //   //               PopupMenuItem(
            //   //                   value: 1,
            //   //                   child: ListTile(
            //   //                     onTap: (){
            //   //                       Navigator.pop(context);
            //   //                       showMyDialog(date, snapshot.child('id').value.toString());
            //   //                     },
            //   //                     leading: Icon(Icons.edit),
            //   //                     title: Text('Edit'),
            //   //                   )),
            //   //               PopupMenuItem(
            //   //                   value: 2,
            //   //                   child: ListTile(
            //   //                     onTap: (){
            //   //                       Navigator.pop(context);
            //   //                       databaseRef.child(snapshot.child('id').value.toString()).remove();
            //   //                     },
            //   //                     leading: Icon(Icons.delete_outline),
            //   //                     title: Text('Delete'),
            //   //                   )),
            //   //             ],
            //   //           ),
            //   //         );
            //   //       }
            //   //       else if(date.toLowerCase().contains(searchControl.text.toLowerCase().toString())){
            //   //         return ListTile(
            //   //           title: Text(snapshot.child('attendance').value.toString()),
            //   //           subtitle: Text(snapshot.child('date').value.toString()),
            //   //         );
            //   //       }
            //   //       else{
            //   //         return Container();
            //   //       }
            //   //     }
            //   // ),
            // ),
          ],
        )
    );
  }


  Future <void> showMyDialog(String date, String id) async{
    editControl.text= date;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editControl,
                decoration: InputDecoration(
                    hintText: 'Edit'
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: Text('Cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);

                ref.doc(id).update({
                  'date': editControl.text.toLowerCase(),

                }).then((value){
                  Utils().toastMessage1('updated');
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });





                //real database
                // databaseRef.child(id).update({
                //   'date': editControl.text.toLowerCase(),
                // }).then((value){
                //   Utils().toastMessage1('Post Updated');
                // }).onError((error, stackTrace){
                //   Utils().toastMessage(error.toString());
                // });

              },
                  child: Text('Update')),
            ],
          );
        });
  }
}

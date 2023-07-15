import 'package:attendance_app/ui/upload_image.dart';
import 'package:attendance_app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';
class MarkScreen extends StatefulWidget {
  const MarkScreen({Key? key}) : super(key: key);

  @override
  State<MarkScreen> createState() => _MarkScreenState();
}

class _MarkScreenState extends State<MarkScreen> {
  bool loading =false;
  final databaseRef = FirebaseDatabase.instance.ref('Mark');
  final searchControl= TextEditingController();
  final editControl= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Attendance'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          // RoundButton(title: 'upload image', onTap: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageScreen()));
          // }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchControl,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: databaseRef,
                defaultChild: Text('Loading'),
                itemBuilder: (context, snapshot, animation, index) {

                  final date= snapshot.child('date').value.toString();

                  if(searchControl.text.isEmpty){
                    return ListTile(
                      title: Text(snapshot.child('attendance').value.toString()),
                      subtitle: Text(snapshot.child('date').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) =>
                        [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  showMyDialog(date, snapshot.child('id').value.toString());
                                },
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                          )),
                          PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  databaseRef.child(snapshot.child('id').value.toString()).remove();
                                },
                                leading: Icon(Icons.delete_outline),
                                title: Text('Delete'),
                              )),
                        ],
                      ),
                    );
                  }
                  else if(date.toLowerCase().contains(searchControl.text.toLowerCase().toString())){
                    return ListTile(
                      title: Text(snapshot.child('attendance').value.toString()),
                      subtitle: Text(snapshot.child('date').value.toString()),
                    );
                  }
                  else{
                    return Container();
                  }
                }
            ),
          ),
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
                databaseRef.child(id).update({
                  'date': editControl.text.toLowerCase(),
                }).then((value){
                  Utils().toastMessage1('Post Updated');
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });

              },
                  child: Text('Update')),
            ],
          );
        });
  }
}


// Expanded(child: StreamBuilder(
// stream: databaseRef.onValue,
// builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
//
// if(!snapshot.hasData){
// return CircularProgressIndicator();
// }
// else{
// Map<dynamic, dynamic> map= snapshot.data!.snapshot.value as dynamic;
// List<dynamic> list= [];
// list.clear();
// list= map.values.toList();
// return ListView.builder(
// itemCount: snapshot.data!.snapshot.children.length,
// itemBuilder: (context, index){
// return ListTile(
// title: Text(list[index]['attendance']),
// subtitle: Text(list[index]['date']),
// );
// });
// }
// },
// )),


// Container(
// child: TextField(
// controller: editControl,
// decoration: InputDecoration(
// hintText: 'Edit'
// ),
// ),
// ),
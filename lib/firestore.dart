import 'package:flutter/material.dart';
import 'package:practice/feedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'json.dart';

class firestore extends StatefulWidget {
  const firestore({Key? key}) : super(key: key);

  @override
  State<firestore> createState() => _firestoreState();
}

class _firestoreState extends State<firestore> {

  List<Item> feedbacks = [];

  @override
  void initState(){
    fetchRecords();
    FirebaseFirestore.instance.collection('feedbacks').snapshots().listen((records) {
      mapRecords(records);
    });
    super.initState();
  }

  fetchRecords() async {
    var records = await FirebaseFirestore.instance.collection('feedbacks').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records){
   var _list = records.docs.map(
            (item) => Item(id: item.id,name: item['name'], feedback: item['feedback'],),).toList();

   setState(() {
     feedbacks = _list;
   });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()
          {
            Navigator.pushAndRemoveUntil(context, PageTransition(
                type: PageTransitionType.topToBottom,
                duration: const Duration(milliseconds: 600),
                reverseDuration: const Duration(milliseconds: 600),
                child: const feedback()) , (r) => false );
          },
              iconSize: 30,
              icon: Image.asset('assets/arrow-up.png')),
          backgroundColor: Colors.black87,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.9,

          title:  const Text(
            "Saved Feedbacks",
            style: TextStyle(
              fontFamily: 'Gloss',
              fontSize: 38,
              letterSpacing: 1,
              color: Colors.blue,
            ),
          ),
        ),

        body: Container(
          decoration:  const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFCB2B93),
                Color(0XFF9546C4),
                Color(0XFF5E61F4),
              ],

                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
          ),
          child: ListView.builder(
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: const EdgeInsets.all(5),
                  color: Colors.black26,
                  child: Slidable(
                    endActionPane: ActionPane(motion: const ScrollMotion (),
                        children: [
                          SlidableAction(onPressed: (c){
                            deleteItem(feedbacks[index].id);
                          },
                          backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete feedback',
                            spacing: 8,
                          ),
                        ]),
                    child: ListTile(
                      leading: const Icon(Icons.tag_faces_sharp,size: 48,color: Colors.white,),
                      title: Text(feedbacks[index].name,
                        style:  const TextStyle(
                        fontSize: 35,
                        color: Color(0xFF296FF9),
                        fontFamily: 'stencil',
                        height: 0.9,
                        letterSpacing: 1.5,
                      ),),
                      subtitle: Text(feedbacks[index].feedback,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'travel',
                        ),),
                      textColor: Colors.white,
                      contentPadding: const EdgeInsets.fromLTRB(10, 05, 20, 10),
                    ),
                  ),
                );
              }
          ),
        )
      ),
    );
  }

  deleteItem(String id){
    FirebaseFirestore.instance.collection('feedbacks').doc(id).delete();
  }
}

import 'package:chatbot/Models/custom_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase/firestore.dart';
import 'package:flutter/cupertino.dart';


class DatabaseService with ChangeNotifier{
  
  
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  Map mappedDoc = {};

  
  Future<void> updateUserData(String name, String emailId, String phoneNo) async {
     await userCollection.doc(uid).set({
      'name': name,
      'emailId': emailId,
      'phoneNo': phoneNo,
    });
    notifyListeners();
  }

  // Future<void> updateNewsSubscription(String? newsSubscription) async {
  //   await userCollection.doc(uid).update({
  //     'newsSubscription': newsSubscription,
  //   });
  // }

  
  CustomUserData customUserDataFromSnapshot(DocumentSnapshot snapshot) {
    //var data = (snapshot.data() as Map);
    return CustomUserData(
      uid: uid,
      name: snapshot['name'],
      phoneNumber: snapshot['phoneNumber'],
      emailId: snapshot['emailId'],
      //name: snapshot['name'],
      // name: data['name'],
      // phoneNumber: data['phoneNo'],
      // emailId: data['emailId'],
      // newsSubscription: data['newsSubscription'] ?? 'none',
      //imageurl: snapshot['ima']
    );
  }
  
  
  // Stream<CustomUserData> get customUserData {
  //   return userCollection.doc(uid).snapshots().map(customUserDataFromSnapshot);
  // }

  Future getData(String uid) async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('user').doc(uid).get();
    mappedDoc = doc.data() as Map;
    // print(mappedDoc['name']);
    // print(mappedDoc['emailId']);
    // print(mappedDoc['phoneNumber']);
    // print(mappedDoc['newsSubscription']);
  }


}
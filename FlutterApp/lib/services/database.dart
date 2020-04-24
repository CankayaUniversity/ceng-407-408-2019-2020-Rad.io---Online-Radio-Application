import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');
      //ADD, READ, OBTAIN, REMOVE data from collection using 'brewCollection'

  Future updateUserData(String name, String oldpass, String newpass) async
  {
    return await brewCollection.document(uid).setData({
      'name': name,
      'oldpass' : oldpass,
      'newpass' : newpass,


    }); //ey np ill create it lel
  }
}
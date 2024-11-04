import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_kart/Models/community_model.dart';
import 'package:pet_kart/Models/customer.dart';
import 'package:pet_kart/MyWidgets/snackbarAL.dart';

class FirestoreFirebaseAL{
  FirebaseFirestore ff=FirebaseFirestore.instance;
  uploadUserDataAL(Customer cu) async {
    try{
await ff.collection("users").doc(cu.email).set(cu.toMap());
      print("user profile data success");
    return true;
    }
    catch(e){
      print("user data firebasefirestore upload failed");
      return false;
    }
  }

  deleteUserDataAl(String? docName) async {
    try{
      await ff.collection("users").doc(docName).delete();
      print("user profile data delete success");
      return true;
    }
    catch(e){
      print("user data firebasefirestore delete failed");
      return false;
    }
  }

  Future<bool> isPresentCommunity(String name) async {
   DocumentSnapshot documentSnapshot= await ff.collection("community").doc(name).get();
   if(documentSnapshot.exists){
     return true;
   }
   else {
     return false;
   }
  }
  createCommunity(CommunityModel cm ) async {
try{
  await ff.collection("community").doc(cm.id).set(cm.toMap());
  return true;
}catch(e){
  // showErrorSnackbar(e.toString());
return false;
}
  }

}
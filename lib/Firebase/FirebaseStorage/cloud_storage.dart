import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class CloudStorage{
  FirebaseStorage fs=FirebaseStorage.instance;
  uploadImageAL(File? file, String name) async {
  String downloadURL="";
    Reference ref=fs.ref().child('profile/$name');
    try {
      await ref.putFile(file!);
      print("File uploaded successfully.");
    }
    catch(e){
print("File upload fail.");
    }
    finally{
     downloadURL = await ref.getDownloadURL();
    }
    return downloadURL;
  }

  /////////////////////////////////////////////////////////////////////Delete Profile/////////////////////////////////////////////////
  deleteProfile(String? email) async {
    if(email!.isEmpty ||email=="")return false;
    final desertRef = fs.ref().child('profile/$email');
try{
    await desertRef.delete();
return false;
}
catch(e){
  print(e.toString());
  return false;
}
  }
  Future<List<String>> uploadCommunityImages(String id, List<File> files) async {


      List<String> downloadUrls = [];


      try {
        int index=0;
        for (File file in files) {

          String fileName = "$id$index";
          final ref = fs.ref().child('community/$id/$fileName');
          await ref.putFile(file);
          final downloadUrl = await ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
          index++;
        }

      } catch (e) {
        print('Error uploading files: $e');
      }

      return downloadUrls;

  }

  Future<bool> deleteCommunityImages(String id) async {
    try {
      await fs.ref().child("community/$id").delete();
    return true;
    }
    catch(e){
      return false;
    }
  }

}
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
class FirebaseStorageService {
  final storage = FirebaseStorage.instance;
  Future<void> uploadFile(String nameimage,String location,String path,Function onSuccess,Function(String) onError) async {
      if(path!=null&&path.isNotEmpty){
        try {
          final ref = storage.ref(location+nameimage+".jpg");
          await ref.putFile(File(path));
          onSuccess();
        } on FirebaseException catch (e) {
          print("error");
          onError("error : "+e.toString());
        }
      }
      else{
        onSuccess();
      }
  }
  Future<String> downloadURLExample(String location,String nameimage) async {
    String downloadURL = await storage
        .ref(location+nameimage+".jpg")
        .getDownloadURL();
    return downloadURL;
  }
}
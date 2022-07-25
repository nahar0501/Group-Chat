import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'update_profile_controller_state.dart';

class UpdateProfileControllerCubit extends Cubit<UpdateProfileControllerState> {
  UpdateProfileControllerCubit() : super(UpdateProfileControllerInitial());
  updateProfile(XFile pic,UserModel model)async{
    try{
      final storageRef = FirebaseStorage.instance.ref();

// Create a reference to 'images/mountains.jpg'
      final pRef = storageRef.child("images/${pic.name}");
      var task=await pRef.putFile(File(pic.path));
      String downloadUrl=await task.ref.getDownloadURL();
      final ref=await FirebaseFirestore.instance.collection("users").doc(model.id).update(
          {
            'pic':downloadUrl
          });

    }catch(e)
    {

    }
  }
}

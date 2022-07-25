import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

part 'signup_controller_state.dart';

class SignupControllerCubit extends Cubit<SignupControllerState> {
  SignupControllerCubit() : super(SignupControllerInitial());

  doSignup(String name, String email, String password) async {
    try {
      emit(SignupControllerAuthenticating());
      var uc = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (uc.user != null) {
        var data = UserModel(
            name: name,
            email: email,
            id: uc.user!.uid,
            pic:
                "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png",
            totalpoints: 0,
            rated: 0);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uc.user!.uid)
            .set(data.toJson());
        emit(SignupControllerSuccess(user: data));
      } else {
        emit(SignupControllerError(err: "signup failed"));
      }
    } catch (e) {
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseAuth.instance.signOut();
      }
      if (e is SocketException) {
        emit(SignupControllerError(err: e.message));
      }
      if (e is FirebaseAuthException) {
        emit(SignupControllerError(err: e.message.toString()));
      }
    }
  }
}

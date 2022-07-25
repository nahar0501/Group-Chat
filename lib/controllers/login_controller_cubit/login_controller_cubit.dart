import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_controller_state.dart';

class LoginControllerCubit extends Cubit<LoginControllerState> {
  LoginControllerCubit() : super(LoginControllerInitial());

  doLogin(String email,String pass)async
  {
    try{
      emit(LoginControllerAuthenticating());
      var uc=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      if(uc.user!=null)
        {
          final ref=FirebaseFirestore.instance.collection("users");
          var userdata=await ref.doc(uc.user!.uid).get();
          print(jsonEncode(userdata.data()));
          var user=UserModel.fromRawJson(jsonEncode(userdata.data()));
          emit(LoginControllerSuccess(user: user));
        }else {
        emit(LoginControllerError(err: "login failed"));
      }
    }catch(e)
    {
      if(e is SocketException)
        {
          emit(LoginControllerError(err: e.message));
        }
      if(e is FirebaseAuthException)
        {
          emit(LoginControllerError(err: e.message.toString()));
        }
      else{
        print(e.toString());
      }
    }
  }
}

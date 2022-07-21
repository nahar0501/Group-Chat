import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'send_message_controller_state.dart';

class SendMessageControllerCubit extends Cubit<SendMessageControllerState> {
  SendMessageControllerCubit() : super(InitialState());

  sendMessage({required  String msg})async
  {
    try{
      emit(SendingState());
      final mAuth=FirebaseAuth.instance.currentUser;
      var msgBody={
        'msg':msg,
        'sender':mAuth!.uid,
        'ph':mAuth.phoneNumber,
        'time':DateTime.now().millisecondsSinceEpoch,
      };
      await FirebaseFirestore.instance.collection("chats").add(msgBody);
      emit(SentState());
    }catch(e)
    {
      if(e is SocketException){
        emit(FailureState(err: e.message));
      }
      if(e is FirebaseException)
        {
          emit(FailureState(err: e.message.toString()));
        }
    }
  }
}

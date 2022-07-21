
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'otp_controller_state.dart';

class OtpControllerCubit extends Cubit<OtpControllerState> {
  OtpControllerCubit() : super(OtpControllerInitial());


  sendOtp(String ph)async
  {

    try{
      emit(OtpControllerLoadingState(msg: "Sending otp..."));
     await FirebaseAuth.instance.verifyPhoneNumber(
         phoneNumber: ph,
         verificationCompleted: (PhoneAuthCredential credential)async{
           emit(OtpControllerFetchedState(otp: credential.smsCode.toString()));
         },
         timeout: Duration(seconds: 63),
         verificationFailed: (FirebaseAuthException err){
           emit(OtpControllerErrorState(err: err.message.toString()));
         },
         codeSent: (String verificationId,int? code)async{
           print(code);
           emit(OtpSentState(verificationID: verificationId));
         },
         codeAutoRetrievalTimeout: (String timeout){
           emit(OtpExpiryState());
         }
     );
    }catch(e)
    {
      print(e);
    }
  }

  verify(String verificationID,String otp)async
  {
    try{
      emit(OtpControllerLoadingState(msg: "verifying"));
      var credentials=PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otp);
      var uc=await FirebaseAuth.instance.signInWithCredential(credentials);
      if(uc.user!=null)
        {
          print(uc.user!.phoneNumber);
          emit(OtpControllerSuccessState(id: uc.user!.uid));
        }
      else {
        emit(OtpControllerErrorState(err: "Login failed"));
      }

    }catch(e)
    {
      if(e is SocketException)
        {
          emit(OtpControllerErrorState(err: e.message.toString()));

        }
      if(e is FirebaseAuthException)
        {
          emit(OtpControllerErrorState(err: e.message.toString()));
        }
    }
  }
}

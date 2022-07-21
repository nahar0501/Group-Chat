import 'package:chat_app/controllers/fetch_message_cubit/fetch_message_controller_cubit.dart';
import 'package:chat_app/controllers/otp_controller_cubit/otp_controller_cubit.dart';
import 'package:chat_app/controllers/send_message_cubit/send_message_controller_cubit.dart';
import 'package:chat_app/controllers/timer_controller_cubit/timer_controller_cubit.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/phone_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>OtpControllerCubit()),
        BlocProvider(create: (context)=>TimerControllerCubit()),
        BlocProvider(create: (context)=>SendMessageControllerCubit()),
        BlocProvider(create: (context)=>FetchMessageControllerCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
          )
        ),
        home:FirebaseAuth.instance.currentUser!=null ? ChatScreen() : PhoneVerification(),
        ),
    );
  }
}

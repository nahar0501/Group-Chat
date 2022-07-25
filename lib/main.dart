
import 'package:chat_app/controllers/fetch_all_groups/fetch_all_groups_cubit.dart';
import 'package:chat_app/controllers/fetch_message_cubit/fetch_message_controller_cubit.dart';
import 'package:chat_app/controllers/fetch_users_controller/fetch_users_controller_cubit.dart';
import 'package:chat_app/controllers/profile_controller_cubit/profile_controller_cubit.dart';
import 'package:chat_app/controllers/ratings_controller/ratings_controller_cubit.dart';
import 'package:chat_app/controllers/send_message_cubit/send_message_controller_cubit.dart';
import 'package:chat_app/controllers/signup_controller_cubit/signup_controller_cubit.dart';
import 'package:chat_app/controllers/update_profile_controller/update_profile_controller_cubit.dart';
import 'package:chat_app/views/all_groups.dart';
import 'package:chat_app/views/all_users.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/login_screen.dart';

import 'package:chat_app/views/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controllers/create_group_chat_controller/create_group_controller_cubit.dart';
import 'controllers/login_controller_cubit/login_controller_cubit.dart';




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
        BlocProvider(create: (context)=>FetchMessageControllerCubit()),
        BlocProvider(create: (context)=>LoginControllerCubit()),
        BlocProvider(create: (context)=>SignupControllerCubit()),
        BlocProvider(create: (context)=>FetchUsersControllerCubit()),
        BlocProvider(create: (context)=>CreateGroupControllerCubit()),
        BlocProvider(create: (context)=>FetchAllGroupsCubit()),
        BlocProvider(create: (context)=>FetchMessageControllerCubit()),
        BlocProvider(create: (context)=>SendMessageControllerCubit()),
        BlocProvider(create: (context)=>ProfileControllerCubit()),
        BlocProvider(create: (context)=>UpdateProfileControllerCubit()),
        BlocProvider(create: (context)=>RatingsControllerCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.blue,
            elevation: 0,
          )
        ),
        // home:FirebaseAuth.instance.currentUser!=null ? ChatScreen() : PhoneVerification(),
        home:FirebaseAuth.instance.currentUser!=null?AllGroups():LoginScreen(),
        ),
    );
  }
}

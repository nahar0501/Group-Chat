import 'dart:convert';

import 'package:chat_app/controllers/login_controller_cubit/login_controller_cubit.dart';
import 'package:chat_app/shared_prefs/Prefs.dart';
import 'package:chat_app/views/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/signup_controller_cubit/signup_controller_cubit.dart';
import 'all_groups.dart';
import 'custom_widgets/custom_auth_loading.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  final _txtEmail=TextEditingController();
  final _txtPass=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            TextField(
              controller: _txtEmail,
              decoration: InputDecoration(
                  hintText: "Email",
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      )
                  )
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _txtPass,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Colors.blue,
                      )
                  )
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocListener<LoginControllerCubit, LoginControllerState>(
        listener: (context, state)async {
          // TODO: implement listener
          if(state is LoginControllerAuthenticating)
          {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              // false = user must tap button, true = tap outside dialog
              builder: (BuildContext dialogContext) {
                return CustomAuthLoading(title: "Authenticating");
              },
            );
          }
          if(state is LoginControllerSuccess)
          {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("login success"),backgroundColor: Colors.green,)
            );
            await Prefs.setUserData(jsonEncode(state.user.toJson()));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_)=>AllGroups())
            );
          }
          if(state is LoginControllerError)
          {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.err),backgroundColor: Colors.red,)
            );
          }
        },
        child: FloatingActionButton(
          onPressed: () {
            context.read<LoginControllerCubit>().doLogin(_txtEmail.text, _txtPass.text);
          },
          child:const Icon(Icons.login, color: Colors.white,),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Center(
          child: Text.rich(
              TextSpan(
                  text: "Don't have an account ? ",
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                          print("hello");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_)=>SignupScreen()));

                          },
                        text: "Create one",
                        style: TextStyle(color: Colors.blue)
                    )
                  ]
              )
          ),
        ),
      ),
    );
  }
}

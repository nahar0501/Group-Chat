import 'dart:convert';

import 'package:chat_app/controllers/signup_controller_cubit/signup_controller_cubit.dart';
import 'package:chat_app/views/all_groups.dart';
import 'package:chat_app/views/custom_widgets/custom_auth_loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared_prefs/Prefs.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({Key? key}) : super(key: key);
  final _txtName=TextEditingController();
  final _txtPass=TextEditingController();
  final _txtEmail=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              TextField(
                controller: _txtName,
                decoration: InputDecoration(
                    hintText: "Name",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _txtEmail,
                decoration: InputDecoration(
                    hintText: "Email",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _txtPass,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:const  BorderSide(
                          color: Colors.blue,
                        ))),
              ),
              SizedBox(
                height: 30,
              ),
              BlocListener<SignupControllerCubit, SignupControllerState>(
                listener: (context, state) async{
                  // TODO: implement listener
                  if(state is SignupControllerAuthenticating)
                    {
                      showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      // false = user must tap button, true = tap outside dialog
                      builder: (BuildContext dialogContext) {
                        return CustomAuthLoading(title: "Creating account");
                      },
                    );
                  }
                  if(state is SignupControllerSuccess)
                    {
                      Navigator.pop(context);
                      await Prefs.setUserData(jsonEncode(state.user.toJson()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("account Created"),backgroundColor: Colors.green,)
                      );
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_)=>AllGroups())
                      );
                    }
                  if(state is SignupControllerError)
                    {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text(state.err),backgroundColor: Colors.red,)
                      );
                    }
                },
                child: MaterialButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    context.read<SignupControllerCubit>().doSignup(
                        _txtName.text,
                        _txtEmail.text,
                        _txtPass.text
                    );
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Center(
          child:
              Text.rich(TextSpan(text: "Already have an account ? ", children: [
            TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () {},
                text: "Login",
                style: TextStyle(color: Colors.blue))
          ])),
        ),
      ),
    );
  }
}

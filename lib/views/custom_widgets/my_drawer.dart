import 'package:chat_app/controllers/profile_controller_cubit/profile_controller_cubit.dart';
import 'package:chat_app/shared_prefs/Prefs.dart';
import 'package:chat_app/views/all_users.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:chat_app/views/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileControllerCubit>().loadUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              BlocBuilder<ProfileControllerCubit, ProfileControllerState>(
                builder: (context, state) {
                  if(state is ProfileControllerLoaded) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Stack(
                              children: [
                                 Center(
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          state.userModel.pic,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 5,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.6),
                                              spreadRadius: 2,
                                              blurRadius: 3,
                                            )
                                          ]),
                                      height: 20,
                                      width: 20,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: Text(
                              state.userModel.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => AllUsers()));
                },
                leading: Icon(Icons.people),
                title: Text("Users"),
                trailing: Icon(Icons.arrow_right),
              ),
              ListTile(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Profile(null)));
                },
                leading: Icon(Icons.person),
                title: Text("Profile"),
                trailing: Icon(Icons.arrow_right),
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  final pref = await SharedPreferences.getInstance();
                  pref.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                trailing: Icon(Icons.arrow_right),
              )
            ],
          ),
        ),
      ),
    );
  }
}

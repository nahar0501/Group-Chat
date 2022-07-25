import 'dart:io';

import 'package:chat_app/controllers/ratings_controller/ratings_controller_cubit.dart';
import 'package:chat_app/controllers/update_profile_controller/update_profile_controller_cubit.dart';
import 'package:chat_app/views/custom_widgets/custom_auth_loading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '/controllers/profile_controller_cubit/profile_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_widgets/profileTextfield.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? img;
  final _txtEmail = TextEditingController();
  final _txtName = TextEditingController();
  num ratings=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ProfileControllerCubit, ProfileControllerState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {

            if (state is ProfileControllerLoaded) {
              _txtEmail.text = state.userModel.email;
              _txtName.text = state.userModel.name;
              context.read<RatingsControllerCubit>().checkMyRating(state.userModel.id);
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 196,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocListener<UpdateProfileControllerCubit,
                            UpdateProfileControllerState>(
                          listener: (context, state) {
                            // TODO: implement listener
                            if (state is UpdateProfileControllerLoading) {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      CustomAuthLoading(title: "uploading"));
                            }
                            if (state is UpdateProfileControllerLoaded) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("profile updated"),
                                backgroundColor: Colors.red,
                              ));
                            }
                            if (state is UpdateProfileControllerError) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.err)));
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Stack(
                              children: [
                                Container(
                                  width: 137,
                                  height: 137,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: img == null
                                        ?  DecorationImage(
                                            image: NetworkImage(
                                                state.userModel.pic),
                                            fit: BoxFit.fill)
                                        : DecorationImage(
                                            image: FileImage(img!),
                                            fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Positioned(
                                    right: 10,
                                    bottom: 5,
                                    child: InkWell(
                                        onTap: () async {
                                          try {
                                            final ImagePicker _picker =
                                                ImagePicker();
                                            // Pick an image
                                            final XFile? image =
                                                await _picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            img = File(image!.path);
                                            setState(() {});
                                            context
                                                .read<
                                                    UpdateProfileControllerCubit>()
                                                .updateProfile(
                                                    image, state.userModel);
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.edit)))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 59),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'User Name',
                            style: TextStyle(color: Color(0xff706C6C)),
                          ),
                          ProfileTextField(
                            title: 'name',
                            controller: _txtName,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Email Address',
                            style: TextStyle(color: Color(0xff706C6C)),
                          ),
                          ProfileTextField(
                            title: 'hiumerkhalil@gmail.com',
                            controller: _txtEmail,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // Text(
                          //   'Phone Number',
                          //   style: TextStyle(color: Color(0xff706C6C)),
                          // ),
                          // ProfileTextField(title: '+923379717184'),
                          // SizedBox(
                          //   height: 30.sp,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  BlocConsumer<RatingsControllerCubit, RatingsControllerState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context,st){
                      return Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: RatingBar.builder(
                                    initialRating: 2,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 30,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      ratings=rating;
                                    },
                                  ),
                                )),
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                context.read<RatingsControllerCubit>().updateRatings(state.userModel, ratings);
                              },
                              child: Text(
                                "Rate coversation",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      );
                    },

                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

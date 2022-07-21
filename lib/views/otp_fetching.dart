
import 'package:chat_app/views/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/otp_controller_cubit/otp_controller_cubit.dart';
import '../controllers/timer_controller_cubit/timer_controller_cubit.dart';
import '../shared_prefs/prefs.dart';
import 'custom_widgets/custom_auth_loading.dart';

class OtpFetching extends StatelessWidget {
  String ph;
  String verificationID;

  OtpFetching({required this.ph,required this.verificationID});

  final _txtPinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP verification"),
      ),
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: _txtPinCode,
                  pinTheme: PinTheme(
                      inactiveColor: Colors.grey.shade200,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  onChanged: (String value) {},
                  onCompleted: (String value) {
                    context.read<OtpControllerCubit>().verify(verificationID, value);
                  },
                ),
              ),

              BlocBuilder<TimerControllerCubit, int>(
                builder: (context, state) {
                  return Container(
                    child: state < 1 ? Text("Resend otp") : RichText(
                      text: TextSpan(
                          text: "",
                          children: [
                            const TextSpan(
                                text: "code expires in ",
                                style: TextStyle(color: Colors.black)
                            ),
                            TextSpan(
                                text: "00:${state}",
                                style: const TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.bold)
                            ),
                            const TextSpan(
                                text: "sec",
                                style: TextStyle(color: Colors.black)
                            ),
                          ]
                      ),
                    ),
                  );
                },
              ),

              BlocConsumer<OtpControllerCubit, OtpControllerState>(
                listener: (context, state)async {
                  // TODO: implement listener
                  if(state is OtpControllerLoadingState)
                    {
                      showDialog(context: context, builder: (context)=>CustomAuthLoading(title: state.msg));
                    }
                  if(state is OtpControllerFetchedState)
                    {
                      _txtPinCode.text=state.otp;
                    }
                  if(state is OtpControllerLoadedState)
                    {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
                    }
                  if(state is OtpControllerSuccessState)
                    {
                      Navigator.pop(context);
                      await Prefs.setUserid(state.id);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>ChatScreen())
                      );
                    }
                  if(state is OtpControllerErrorState)
                    {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text(state.err),backgroundColor: Colors.red,)
                      );
                    }
                },
                builder: (context, state) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        if (state is OtpExpiryState) {
                          context.read<OtpControllerCubit>().sendOtp(ph);
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: state is OtpExpiryState ? Colors.blue : Colors
                              .grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Resend",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/otp_controller_cubit/otp_controller_cubit.dart';
import '../controllers/timer_controller_cubit/timer_controller_cubit.dart';
import 'custom_widgets/custom_auth_loading.dart';
import 'otp_fetching.dart';

class PhoneVerification extends StatefulWidget {
  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final _txtPhone = TextEditingController();
  String? countryCode;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Phone number"),
      ),
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                margin:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    border:
                    Border.all(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CountryCodePicker(
                        hideSearch: true,
                        onChanged: (CountryCode country) {
                          countryCode = country.dialCode;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _txtPhone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: "Enter your phone no.",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              BlocListener<OtpControllerCubit, OtpControllerState>(
                listener: (context, state) {
                  if(state is OtpControllerLoadingState)
                    {
                      showDialog(context: context, builder: (context)=>CustomAuthLoading(title: state.msg));
                    }
                  if(state is OtpSentState)
                    {
                      Navigator.pop(context);
                      String ph=countryCode!+_txtPhone.text.trim();
                      context.read<TimerControllerCubit>().startTimer();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>OtpFetching(ph: ph,verificationID: state.verificationID,)
                          )
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
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      String ph=countryCode!+_txtPhone.text.trim();
                      print(ph);
                      context.read<OtpControllerCubit>().sendOtp(ph);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

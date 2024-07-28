import 'package:chatbot/Common/util/color.dart';
import 'package:chatbot/features/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpScreen extends ConsumerWidget {
  static const routeName='/otp-screen';
   final String verificationId;
  const OtpScreen({super.key, required this.verificationId, });

  void verifyOtp(WidgetRef ref,BuildContext context,String otp){
  ref.read(authControllerProvider).verifyOTP(context, verificationId, otp);
  }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Enter the otp"),
        centerTitle: false,
        backgroundColor: tabColor,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              const Text("We had sent a sms with a One Time Password (OTP)",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
              const SizedBox(height: 50,),
              SizedBox(
                width: 150,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "_ _ _ _ _ _",
                    hintStyle: TextStyle(
                      fontSize: 30,
                    )
                  ),
                  onChanged: (val){
                    if(val.length==6){
                      verifyOtp(ref, context, val.trim());
                     // showSnackBar(context, val.trim());
                    }
                  }
                  ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

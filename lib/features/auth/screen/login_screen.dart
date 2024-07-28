import 'package:chatbot/Common/util/color.dart';
import 'package:chatbot/Common/widget/custom_button.dart';
import 'package:chatbot/Common/widget/snack_bar.dart';
import 'package:chatbot/features/auth/auth_controller.dart';
import 'package:country_picker/country_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName='/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController=TextEditingController();
  Country? country;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }
  void pickCountry(){
    showCountryPicker(
        context: context, onSelect: (Country selectCountry){
          setState(() {
            country=selectCountry;
          });
    }
    );
  }
  // void navigateToOtpScreen(BuildContext context){
  //   Navigator.popAndPushNamed(context, OtpScreen.routeName);
  // }

  void sendPhoneNumber(){
    String phoneNumber=phoneController.text.trim();
    if(country!=null && phoneNumber.isNotEmpty){
      ref.read(authControllerProvider).signInWithPhone(context, "+${country!.phoneCode}$phoneNumber");
    }else{
      showSnackBar(context, "Fill out all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Enter your mobile number'),
        centerTitle: false,
        backgroundColor: tabColor,
        elevation: 20,
        toolbarHeight: 50,
      ),
      body:  Padding(
        padding:  const EdgeInsets.all(15.0),
        child:Column(

          children: [
            const Text('ChatBot needs to verify your phone number',style: TextStyle(
              fontSize: 20,

            ),
            textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10,),
            TextButton(
                onPressed: pickCountry,
                child: const Text("Select country code",style: TextStyle(fontSize: 18),)),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                country!=null?Text('+${country!.phoneCode}',style:const TextStyle(fontSize: 20),):const Text("+00",style: TextStyle(fontSize: 20),),
                const SizedBox(width: 10,),
                SizedBox(
                  width: size.width*0.7,
                  child: TextField(
                    controller: phoneController,
                    decoration:const InputDecoration(
                      hintText: "Phone Number",
                      hintStyle: TextStyle(fontSize: 15)
                    ),
                    style: const TextStyle(fontSize: 20),
                    keyboardType: TextInputType.number,

                  ),
                )
              ],
            ),
            Flexible(flex: 1,child: Container(),),
            CustomButton(text: "Next", onPressed: sendPhoneNumber),

          ],
        )
      ),
    );
  }
}

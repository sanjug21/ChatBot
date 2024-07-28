
import 'package:chatbot/features/chat/chat_screens/mobile_chat_screen.dart';
import 'package:chatbot/features/auth/screen/login_screen.dart';
import 'package:chatbot/features/auth/screen/otp_screen.dart';
import 'package:chatbot/features/auth/screen/user_info.dart';
import 'package:chatbot/features/selectcontacts/screen/select_contact_screem.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/Common/widget/error.dart';
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
      case LoginScreen.routeName:
       return MaterialPageRoute(
        builder: (context) => const LoginScreen());
      case OtpScreen.routeName:
        final verificationId = settings.arguments as String;
        return MaterialPageRoute(builder: (context)=> OtpScreen(verificationId: verificationId,));
    case UserInformation.routeName:
      return MaterialPageRoute(
          builder: (context) => const UserInformation());
    case SelectContactScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const SelectContactScreen());
    case MobileChatScreen.routeName:
      final arguments=settings.arguments as Map<String,dynamic>;
      final name=arguments['name'];
      final uid=arguments['uid'];
      return MaterialPageRoute(

          builder: (context) =>  MobileChatScreen(name: name, uid: uid));
    default:
      return MaterialPageRoute(

        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "This page doesn't exist"),
        ),
      );
  }
}
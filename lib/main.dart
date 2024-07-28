import 'dart:io';

import 'package:chatbot/Common/util/color.dart';
import 'package:chatbot/Common/widget/loader.dart';
import 'package:chatbot/Screens/mobile_screen.dart';
import 'package:chatbot/features/auth/auth_controller.dart';
import 'package:chatbot/router.dart';
import 'package:chatbot/features/auth/landing_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDd2sjLnNxvrFj0MitfFsSdA_aiMoEcjdM',
              appId: '1:1068856645318:android:8237813b3ed391254ee9c7',
              messagingSenderId: '1068856645318',
              projectId: 'hatbot-84fc1',
              storageBucket: 'chatbot-84fc1.appspot.com'))
      : null;
  await FirebaseAppCheck.instance.activate();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) return const LandingScreen();
            return const MobileScreen();
          },
          error: (err, trace) {
            return const Scaffold(body: Center(child: Text("connect to a network and try again"),),);
          },
          loading: () => const Loader()),
    );
  }
}

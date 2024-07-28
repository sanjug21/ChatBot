import 'package:chatbot/Common/util/color.dart';
import 'package:chatbot/features/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';


class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }
 // final Icon forwardIcon=const Icon(Icons.arrow_forward_outlined);
  @override
  Widget build(BuildContext context) {
    //final size=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to ChatBot',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 50,),
                SizedBox(
                  width: 170,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: ()=> navigateToLoginScreen(context),
                      style: ElevatedButton.styleFrom(
                      backgroundColor:tabColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      elevation: 100,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Let's start", style:TextStyle(
                          color: Colors.black,
                            fontSize: 18,
                          ),),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward,color: Colors.black,)
                        ],
                      ),),
                ),
                // SizedBox(
                //   child: CustomIconButton(
                //       text: "Let's Start ",
                //       icon: const Icon(Icons.arrow_forward_outlined,color: Colors.black,),
                //       onPressed:()=> navigateToLoginScreen(context),
                //     width: 150,
                //   ),

                // ),
                // ElevatedButton(
                //     onPressed:()=> navigateToLoginScreen(context),
                //     child:const Text("Let's Start"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

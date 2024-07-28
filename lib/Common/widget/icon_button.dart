import 'package:chatbot/Common/util/color.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final double width;
  final String text;
  final VoidCallback onPressed;
  final Icon icon;
  const CustomIconButton({
    super.key,
    required this.text,
    required this.onPressed, required this.icon, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        onPressed: onPressed,
      icon: icon,
      label: Text(
        text,
      style:const TextStyle(
        color: blackColor
      ),),
      style: ElevatedButton.styleFrom(
        backgroundColor: tabColor,
        minimumSize: Size(width, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        elevation: 100,


      ),
    );
  }
}

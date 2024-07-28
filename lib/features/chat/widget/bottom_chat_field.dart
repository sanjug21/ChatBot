import 'package:flutter/material.dart';

import '../../../Common/util/color.dart';
class BottomChatField extends StatefulWidget {
  const BottomChatField({super.key});

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  bool sendButton=false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onChanged: (val){
              if(val.isNotEmpty){
                setState(() {
                  sendButton=true;
                });

              }else{
                setState(() {
                  sendButton=false;
                });
              }
            },

            decoration: InputDecoration(
              filled: true,
              fillColor: mobileChatBoxColor,
              prefixIcon: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.emoji_emotions, color: Colors.grey,),),
                    IconButton(onPressed: (){}, icon:  const Icon(Icons.gif, color: Colors.grey,))
                   ,
                  ],
                ),
              ),
              suffixIcon: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed:(){},icon:const Icon(Icons.camera_alt, color: Colors.grey,)),
                    IconButton(onPressed:(){},icon:const Icon(Icons.attach_file, color: Colors.grey,)),

                  ],
                ),
              ),
              hintText: 'Type a message!',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
         Padding(
          padding: const EdgeInsets.only(bottom: 8,right: 2,left: 2),
          child: CircleAvatar(
            backgroundColor: tabColor,
            radius: 25,
            child:Icon(
              sendButton?Icons.send:Icons.mic,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:chatbot/features/auth/auth_controller.dart';
import 'package:chatbot/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../Common/util/color.dart';
import '../../../Common/widget/chat_list.dart';
import '../widget/bottom_chat_field.dart';


class MobileChatScreen extends ConsumerWidget {
  static const routeName='/mobile-chatScreen';
  final String name;
  final String uid;

  const MobileChatScreen({super.key, required this.name, required this.uid});


  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting) {
              return Container();
            }
          return Column(
            children: [
              Text(name),
              if(snapshot.data!.isOnline)Text('online',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),),
            ],
          );
          }, stream: ref.read(authControllerProvider).userDataById(uid),
          
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: ChatList(),
          ),
          BottomChatField(),
        ],
      ),
    );
  }
}

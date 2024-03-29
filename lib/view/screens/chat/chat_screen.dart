import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/view/providers/chat_provider.dart';
import 'package:yes_no_app/view/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/view/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/view/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Padding(
              padding: EdgeInsets.all(4.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.guim.co.uk/img/static/sys-images/Film/Pix/pictures'
                    '/2002/12/18/aniston1.jpg?width=465&dpr=1&s=none'),
              )),
          title: const Text('Mi amor'),
          centerTitle: false,
        ),
        body: _ChatView());
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messages[index];
                      return (message.fromWho == FromWho.hers)
                          ? HerMessageBubble(message: message)
                          : MyMessageBubble(message: message);
                    })),
            MessageFieldBox(
              onValue: chatProvider.sendMessage
            )
          ],
        ),
      ),
    );
  }
}

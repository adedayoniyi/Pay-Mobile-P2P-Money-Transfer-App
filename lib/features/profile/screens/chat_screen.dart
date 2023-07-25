import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/features/profile/models/message_model.dart';
import 'package:pay_mobile_app/features/profile/providers/chat_provider.dart';
import 'package:pay_mobile_app/features/profile/services/profile_services.dart';
import 'package:pay_mobile_app/features/profile/widgets/receivers_message_card.dart.dart';
import 'package:pay_mobile_app/features/profile/widgets/senders_message_card.dart';
import 'package:pay_mobile_app/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_app/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  static const String route = "/chat-screen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController messageController;
  late final ScrollController scrollController;
  late final IO.Socket socket;
  late final StreamController<List<MessageModel>> streamController;
  final ProfileServices profileServices = ProfileServices();

  @override
  void initState() {
    super.initState();
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    print(chatProvider.chat.id);
    messageController = TextEditingController();
    scrollController = ScrollController();
    socket = IO.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'pingTimeout': 120000,
      'cors': {'origin': uri},
    });
    streamController = StreamController<List<MessageModel>>();

    socket.emit('join', {'chatId': chatProvider.chat.id});
    socket.on('message', (data) {
      streamController.add([MessageModel.fromJson(data)]);
      print(streamController);
    });
    loadMessages();
    // Future.delayed(Duration.zero, () {
    //   scrollToBottom();
    // });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    socket.dispose();
    streamController.close();
    super.dispose();
  }

  Future<void> loadMessages() async {
    final messages = await profileServices.getAllMessages(context: context);
    streamController.add(messages);
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      socket.emit('sendMessage', {
        'chatId': chatProvider.chat.id,
        'sender': chatProvider.chat.sender,
        'receiver': chatProvider.chat.receiver,
        'content': messageController.text,
      });

      messageController.clear();
      FocusScope.of(context).unfocus();
      Future.delayed(Duration.zero, () {
        scrollToBottom();
      });
      loadMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pay Moblie Support'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data!;
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        if (message.sender == userProvider.user.username) {
                          return SendersMessageCard(
                            message: message.content,
                            dateTime:
                                '${message.createdAt.day}/${message.createdAt.month}/${message.createdAt.year} ${message.createdAt.hour}:${message.createdAt.minute}',
                            user: 'You',
                          );
                        } else {
                          return ReceiversMessageCard(
                            message: message.content,
                            dateTime:
                                '${message.createdAt.day}/${message.createdAt.month}/${message.createdAt.year} ${message.createdAt.hour}:${message.createdAt.minute}',
                            user: 'Pay Mobile Support',
                          );
                        }
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: messageController,
                      hintText: 'Enter your message',
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

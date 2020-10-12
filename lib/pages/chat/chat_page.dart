import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  final ChatUser _chatUser = ChatUser(
    name: 'Test',
  );

  final ChatUser _otherUser = ChatUser(
    name: 'Other',
  );

  final ChatUser _otherUser2 = ChatUser(
    name: 'D',
  );

  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  void initState() {
    super.initState();

    _messages.add(
      ChatMessage(
        text: 'Welcome to Amuse world!',
        createdAt: DateTime(2020, 10, 1),
        user: _otherUser,
      ),
    );

    _messages.add(
      ChatMessage(
        text: 'hello world',
        createdAt: DateTime.now(),
        user: _otherUser2,
      ),
    );
  }

  void _onSend(ChatMessage message) {
    print(message.createdAt);
    _messages.add(message);

    _chatViewKey.currentState.scrollController.animateTo(
      _chatViewKey.currentState.scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: _sizeWidth,
          height: _sizeHeight,
          color: Colors.black,
          child: DashChat(
            key: _chatViewKey,
            user: _chatUser,
            messages: _messages,
            onSend: _onSend,
            sendOnEnter: true,
            textInputAction: TextInputAction.send,
            scrollToBottom: true,
            scrollToBottomStyle: ScrollToBottomStyle(
              backgroundColor: Colors.lightBlue,
            ),
            shouldShowLoadEarlier: false,
            onLoadEarlier: () {
              print('reaches top');
            },
            showUserAvatar: false,
            showAvatarForEveryMessage: false,
          ),
        ),
      ),
    );
  }
}

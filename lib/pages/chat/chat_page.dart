import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    @required this.userName,
  }) : assert(userName != null);

  final String userName;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String _userName;

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  TextEditingController _textEditingController;

  ChatUser _chatUser;

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

    _userName = widget.userName;

    _textEditingController = TextEditingController();

    _chatUser = ChatUser(
      name: _userName,
    );

    _messages.add(
      ChatMessage(
        text: 'Welcome to Amuse world!\n$_userName!',
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

  Color _senderColor() {
    if (_textEditingController.text.isNotEmpty) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  void _onSend(ChatMessage message) {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: _sizeWidth,
          height: _sizeHeight,
          child: DashChat(
            key: _chatViewKey,
            user: _chatUser,
            messages: _messages,
            textController: _textEditingController,
            inputMaxLines: 3,
            onSend: _onSend,
            sendOnEnter: true,
            textInputAction: TextInputAction.send,
            scrollToBottom: true,
            scrollToBottomStyle: ScrollToBottomStyle(
              backgroundColor: Colors.lightBlue.withOpacity(0.9),
            ),
            shouldShowLoadEarlier: false,
            onLoadEarlier: () {
              print('reached top');
            },
            showUserAvatar: false,
            showAvatarForEveryMessage: false,
            inputContainerStyle: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
              color: Colors.white,
            ),
            sendButtonBuilder: (Function sendMessage) => IconButton(
              onPressed: () => sendMessage(),
              icon: Icon(
                Icons.send,
                color: _senderColor(),
              ),
            ),
            // onTextChange: _onTextChanged,
            messageDecorationBuilder: (ChatMessage chatMessage, bool isUser) {
              if (isUser) {
                return BoxDecoration(
                  color: Colors.blue[400],
                );
              } else {
                return BoxDecoration(
                  color: Colors.grey[200],
                );
              }
            },
            dateFormat: DateFormat('yyyy.MM.dd'),
          ),
        ),
      ),
    );
  }
}

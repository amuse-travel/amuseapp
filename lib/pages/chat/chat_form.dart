import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/blocs/chat/chat_bloc.dart';
import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/pages/common/common_widgets/custom_toast/custom_toast.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatForm extends StatefulWidget {
  @override
  _ChatFormState createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  SingletonUser _singletonUser;

  String _userName;

  ChatBloc _chatBloc;

  AuthenticationBloc _authenticationBloc;

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  TextEditingController _textEditingController;

  ChatUser _chatUser;

  final ChatUser _otherUser = ChatUser(
    name: 'Other',
  );

  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  void initState() {
    super.initState();

    _singletonUser = SingletonUser();

    _userName = _singletonUser.user.displayName;

    _chatBloc = BlocProvider.of<ChatBloc>(context);

    _chatBloc.add(ChatMessagesFetchTried(userName: 'tester'));

    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    _textEditingController = TextEditingController();

    _chatUser = ChatUser(
      name: _userName,
    );

    _messages.add(
      ChatMessage(
        text: 'Welcome to Amuse world!\n$_userName!',
        createdAt: DateTime.now(),
        user: _otherUser,
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

  void _onSendMessage(ChatMessage chatMessage) {
    _chatBloc.add(ChatMessageSendTried(userName: 'tester', chatMessage: chatMessage));
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return MultiBlocListener(
      listeners: <BlocListener<dynamic, dynamic>>[
        BlocListener<ChatBloc, ChatState>(
          listener: (BuildContext context, ChatState state) {
            if (state is ChatMessageSendTrySuccess) {
              _messages.add(state.chatMessage);

              _chatViewKey.currentState.scrollController.animateTo(
                _chatViewKey.currentState.scrollController.position.maxScrollExtent + 48,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeOutQuint,
              );
            }
            if (state is ChatFailure) {
              CustomToast(message: '메시지 전송 실패').show();
            }
          },
        ),
      ],
      child: Container(
        width: _sizeWidth,
        height: _sizeHeight,
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                _chatBloc.add(ChatMessagesFetchTried(userName: 'tester'));

              },
              child: Text('fetch'),
            ),
            DashChat(
              height: 300,
              key: _chatViewKey,
              user: _chatUser,
              messages: _messages,
              textController: _textEditingController,
              inputMaxLines: 3,
              onSend: _onSendMessage,
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
              messageDecorationBuilder: (ChatMessage chatMessage, bool isUser) {
                if (isUser) {
                  return BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.blue[400],
                  );
                } else {
                  return BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[200],
                  );
                }
              },
              dateFormat: DateFormat('yyyy.MM.dd'),
            ),
          ],
        ),
      ),
    );
  }
}

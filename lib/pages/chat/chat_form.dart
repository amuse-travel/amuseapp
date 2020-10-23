import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/blocs/chat/chat_bloc.dart';
import 'package:amuse_app/model/custom_chat_message.dart';
import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/pages/common/common_widgets/custom_toast/custom_toast.dart';
import 'package:amuse_app/pages/common/common_widgets/loading_indicator/loading_indicator.dart';
import 'package:amuse_app/services/socket_io.dart';
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

  final SocketIo _socketIo = SocketIo();

  String _userName;

  ChatBloc _chatBloc;

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  TextEditingController _textEditingController;

  ChatUser _chatUser;

  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  void initState() {
    super.initState();

    _singletonUser = SingletonUser();

    _userName = _singletonUser.user.displayName;

    _chatBloc = BlocProvider.of<ChatBloc>(context);

    _chatBloc.add(const ChatMessagesFetchTried(userName: '야야야'));

    _textEditingController = TextEditingController();

    _chatUser = ChatUser(
      name: '야야야',
    );

    _listenMessages();
  }

  Color _senderColor() {
    if (_textEditingController.text.isNotEmpty) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  void _listenMessages() {
    CustomChatMessage _customChatMessage;

    _socketIo.socket.on(
      'incomingMessage',
          (dynamic data) {
        final Map<String, dynamic> jsonResponse = data as Map<String, dynamic>;
        _customChatMessage = CustomChatMessage.fromJson(jsonResponse);
        setState(
              () {
            _messages.add(
              ChatMessage(
                text: _customChatMessage.text ?? '',
                id: _customChatMessage.msId,
                user: ChatUser(
                  name: _customChatMessage.username,
                ),
                createdAt: DateTime.fromMillisecondsSinceEpoch(_customChatMessage.time),
              ),
            );
          },
        );
      },
    );
  }

  void _onSendMessage(ChatMessage chatMessage) {
    _chatBloc.add(ChatMessageSendTried(userName: '야야야', chatMessage: chatMessage));
  }

  void _onFetchMoreMessages() {
    print('on top');
    _chatBloc.add(ChatMessagesFetchMoreTried(userName: '야야야', lastMsId: _messages[0].id));
  }

  Widget _loadMoreProgressIndicator(ChatState state) {
    if (state is ChatInProgress) {
      return Container(
        width: 100,
        height: 200,
        child: LoadingIndicator(),
      );
    } else {
      return const SizedBox(
        height: 0,
      );
    }
  }

  Widget _avatarBuilder(ChatUser chatUser) {
    if (chatUser.name == '야야야') {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        shape: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(3),
          alignment: Alignment.center,
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: CircleAvatar(
            radius: 20,
            // backgroundImage: NetworkImage(
            //   chatUser.avatar,
            // ),
          ),
        ),
      ),
    );
  }

  Widget _messageBuilder(ChatMessage chatMessage) {
    bool _isMyMessage;
    if (chatMessage.user.name == '야야야') {
      _isMyMessage = true;
    } else {
      _isMyMessage = false;
    }

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 16),
          alignment: _isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: _isMyMessage
                  ? null
                  : Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
              color: _isMyMessage ? const Color(0xFFD1D5DB) : Colors.white,
            ),
            child: Text(
              chatMessage.text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          alignment: _isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            DateFormat('M월 dd일 a hh:mm').format(chatMessage.createdAt),
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return BlocConsumer<ChatBloc, ChatState>(
      builder: (BuildContext buildContext, ChatState state) {
        return Container(
          width: _sizeWidth,
          height: _sizeHeight,
          child: DashChat(
            key: _chatViewKey,
            user: _chatUser,
            messages: _messages,
            textController: _textEditingController,
            inputMaxLines: 3,
            onSend: _onSendMessage,
            sendOnEnter: true,
            textInputAction: TextInputAction.send,
            scrollToBottom: false,
            // scrollToBottomStyle: ScrollToBottomStyle(
            //   backgroundColor: Colors.lightBlue.withOpacity(0.9),
            // ),
            shouldShowLoadEarlier: false,
            showLoadEarlierWidget: () => _loadMoreProgressIndicator(state),
            onLoadEarlier: _onFetchMoreMessages,
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
            avatarBuilder: (ChatUser chatUser) => _avatarBuilder(chatUser),
            messageBuilder: (ChatMessage chatMessage) => _messageBuilder(chatMessage),
            dateFormat: DateFormat('yyyy.MM.dd'),
          ),
        );
      },
      listener: (BuildContext buildContext, ChatState state) {
        if (state is ChatMessagesFetchTrySuccess) {
          for (final CustomChatMessage _customChatMessage in state.chatMessageList.messages) {
            _messages.insert(
              0,
              ChatMessage(
                text: _customChatMessage.text ?? '',
                id: _customChatMessage.msId,
                user: ChatUser(
                  name: _customChatMessage.username,
                  // avatar: _customChatMassage.avatar,
                ),
                createdAt: DateTime.fromMillisecondsSinceEpoch(_customChatMessage.time),
              ),
            );
          }

          // _chatBloc.add(ChatMessageIncomingListened(userName: 'tester'));

          // _chatViewKey.currentState.scrollController.animateTo(
          //   _chatViewKey.currentState.scrollController.position.maxScrollExtent + 48,
          //   duration: const Duration(milliseconds: 100),
          //   curve: Curves.easeOutQuint,
          // );
        }
        if (state is ChatMessagesFetchMoreTrySuccess) {
          for (final CustomChatMessage _customChatMessage in state.chatMessageList.messages) {
            _messages.insert(
              0,
              ChatMessage(
                text: _customChatMessage.text ?? '',
                id: _customChatMessage.msId,
                user: ChatUser(
                  name: _customChatMessage.username,
                  // avatar: _customChatMassage.avatar,
                ),
                createdAt: DateTime.fromMillisecondsSinceEpoch(_customChatMessage.time),
              ),
            );
          }

          // _chatViewKey.currentState.scrollController.animateTo(
          //   0,
          //   duration: const Duration(milliseconds: 300),
          //   curve: Curves.easeOutQuint,
          // );
        }
        if (state is ChatMessageSendTrySuccess) {
          _messages.add(state.chatMessage);

          _chatViewKey.currentState.scrollController.animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent + 48,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOutQuint,
          );
        }
        if (state is ChatMessageIncomingListenSuccess) {
          print(state.chatMessage);

          _messages.add(ChatMessage(
            text: state.chatMessage.text,
            id: state.chatMessage.msId,
            user: ChatUser(
              name: state.chatMessage.username,
              // avatar: _customChatMassage.avatar,
            ),
            createdAt: DateTime.fromMillisecondsSinceEpoch(state.chatMessage.time),
          ));
        }
        if (state is ChatFailure) {
          CustomToast(message: '메시지 전송 실패').show();
        }
      },
    );
  }
}

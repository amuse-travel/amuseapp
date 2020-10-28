import 'package:amuse_app/blocs/chat/chat_bloc.dart';
import 'package:amuse_app/main.dart';
import 'package:amuse_app/model/custom_chat_message.dart';
import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/pages/common/common_widgets/custom_toast/custom_toast.dart';
import 'package:amuse_app/pages/common/common_widgets/loading_indicator/loading_indicator.dart';
import 'package:amuse_app/services/socket_io.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatRoomForm extends StatefulWidget {
  @override
  _ChatRoomFormState createState() => _ChatRoomFormState();
}

class _ChatRoomFormState extends State<ChatRoomForm> {
  SingletonUser _singletonUser;

  final SocketIo _socketIo = SocketIo();

  String _userName;

  ChatBloc _chatBloc;

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  TextEditingController _textEditingController;

  ChatUser _chatUser;

  final List<ChatMessage> _messages = <ChatMessage>[];

  final String _emptyAvatar = 'https://www.travelcontinuously.com/wp-content/uploads/2018/04/empty-avatar.png';

  @override
  void initState() {
    super.initState();

    _singletonUser = SingletonUser();

    if (_singletonUser.userName != null) {
      _userName = _singletonUser.userName;
    } else {
      _userName = 'tester';
    }

    _chatBloc = BlocProvider.of<ChatBloc>(context);

    _chatBloc.add(ChatMessagesFetchTried(userName: _userName));

    _textEditingController = TextEditingController();

    _chatUser = ChatUser(
      name: _userName,
      avatar: 'https://www.tinygraphs.com/squares/$_userName?theme=frogideas&numcolors=4',
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _listenMessages();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  Color _senderColor() {
    if (_textEditingController.text.isNotEmpty) {
      return Theme.of(context).primaryColor;
    } else {
      return Colors.grey;
    }
  }

  void _listenMessages() {
    CustomChatMessage _customChatMessage;

    _socketIo.socketConnection().on(
      'incomingMessage',
      (dynamic data) {
        final Map<String, dynamic> jsonResponse = data as Map<String, dynamic>;
        if (jsonResponse != null) {
          _customChatMessage = CustomChatMessage.fromJson(jsonResponse);
          if (mounted) {
            setState(
              () {
                _messages.add(
                  ChatMessage(
                    text: _customChatMessage.text ?? '',
                    id: _customChatMessage.msId,
                    user: ChatUser(
                      name: _customChatMessage.username,
                      avatar: _customChatMessage.avatar,
                    ),
                    createdAt: DateTime.fromMillisecondsSinceEpoch(_customChatMessage.time),
                  ),
                );
                _chatViewKey.currentState.scrollController.animateTo(
                  _chatViewKey.currentState.scrollController.position.maxScrollExtent + 48,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeOutQuint,
                );
              },
            );
          }
        }
      },
    );
  }

  void _onSendMessage(ChatMessage chatMessage) {
    _chatBloc.add(ChatMessageSendTried(userName: _userName, chatMessage: chatMessage));
  }

  void _onFetchMoreMessages() {
    print('on top');
    _chatBloc.add(ChatMessagesFetchMoreTried(userName: _userName, lastMsId: _messages[0].id));
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
    if (chatUser.name == _userName) {
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
            backgroundImage: CachedNetworkImageProvider(
              chatUser.avatar ?? _emptyAvatar,
            ),
          ),
        ),
      ),
    );
  }

  Widget _messageBuilder(ChatMessage chatMessage) {
    bool _isMyMessage;

    if (chatMessage.user.name == _userName) {
      _isMyMessage = true;
    } else {
      _isMyMessage = false;
    }

    return Column(
      children: <Widget>[
        if (_isMyMessage)
          const SizedBox(
            height: 18,
          )
        else
          Container(
            margin: const EdgeInsets.only(top: 18),
            alignment: Alignment.bottomLeft,
            child: Text(
              chatMessage.user.name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: REGULAR,
                color: Colors.black,
              ),
            ),
          ),
        Container(
          alignment: _isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: _isMyMessage
                  ? null
                  : Border.all(
                      width: 1,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
              color: _isMyMessage ? const Color(0xFFD1D5DB) : Colors.white,
            ),
            child: Text(
              chatMessage.text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: MEDIUM,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          alignment: _isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            DateFormat('M월 dd일 a hh:mm').format(chatMessage.createdAt),
            style: TextStyle(
              fontSize: 12,
              fontWeight: REGULAR,
              color: Theme.of(context).primaryColorDark,
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
                  avatar: _customChatMessage.avatar,
                ),
                createdAt: DateTime.fromMillisecondsSinceEpoch(_customChatMessage.time),
              ),
            );
          }

          _chatViewKey.currentState.scrollController.animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOutQuint,
          );
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
                  avatar: _customChatMessage.avatar,
                ),
                createdAt: DateTime.fromMillisecondsSinceEpoch(_customChatMessage.time),
              ),
            );
          }
        }
        if (state is ChatMessageSendTrySuccess) {
          _messages.add(state.chatMessage);

          _chatViewKey.currentState.scrollController.animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOutQuint,
          );
        }
        if (state is ChatFailure) {
          CustomToast(
            message: state.message,
          ).show();
        }
      },
    );
  }
}

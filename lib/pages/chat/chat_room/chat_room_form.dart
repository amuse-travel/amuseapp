import 'package:amusetravel/pages/chat/chat_room/modal_container/modal_report_user_container.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../main.dart';
import '../../../model/custom_chat_message.dart';
import '../../../model/singleton_user.dart';
import '../../common/common_widgets/custom_toast/custom_toast.dart';
import '../../common/common_widgets/loading_indicator/loading_indicator.dart';

class ChatRoomForm extends StatefulWidget {
  const ChatRoomForm({
    @required String room,
  })  : assert(room != null),
        _room = room;

  final String _room;

  @override
  _ChatRoomFormState createState() => _ChatRoomFormState();
}

class _ChatRoomFormState extends State<ChatRoomForm> {
  String _room;

  SingletonUser _singletonUser;

  String _userName;

  ChatBloc _chatBloc;

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  TextEditingController _textEditingController;

  ChatUser _chatUser;

  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  void initState() {
    super.initState();

    _room = widget._room;

    _singletonUser = SingletonUser();

    if (_singletonUser.userName != null) {
      _userName = _singletonUser.userName;
    } else {
      _userName = 'tester';
    }

    _chatBloc = BlocProvider.of<ChatBloc>(context);

    _chatBloc.add(ChatMessagesFetchTried(userName: _userName, room: _room));

    _textEditingController = TextEditingController();

    _chatUser = ChatUser(
      name: _userName,
      avatar: 'https://ui-avatars.com/api/?name=$_userName',
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  Color _senderColor() {
    if (_textEditingController.text.isNotEmpty) {
      return Theme.of(context).accentColor;
    } else {
      return Theme.of(context).textSelectionHandleColor;
    }
  }

  void _onSendMessage(ChatMessage chatMessage) {
    _chatBloc.add(ChatMessageSendTried(userName: _userName, room: _room, chatMessage: chatMessage));
  }

  void _onFetchMoreMessages() {
    if (_messages.length > 9) {
      _chatBloc.add(ChatMessagesFetchMoreTried(userName: _userName, room: _room, lastMsId: _messages[0].id));
    }
  }

  void _reportUser() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      isScrollControlled: true,
      builder: (BuildContext buildContext) => ModalReportUserContainer(),
    );
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
      margin: const EdgeInsets.only(bottom: 24),
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        child: ElevatedButton(
          onPressed: _reportUser,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            elevation: 1,
            shape: const CircleBorder(),
            primary: Theme.of(context).secondaryHeaderColor,
          ),
          child: Text(
            chatUser.name,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: MEDIUM,
              letterSpacing: -0.16,
              color: Colors.black,
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
            height: 32,
          )
        else
          Container(
            margin: const EdgeInsets.only(top: 16),
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
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              primary: _isMyMessage ? const Color(0xFFD1D5DB) : Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: _isMyMessage
                  ? const BorderSide(
                      width: 1,
                      color: Colors.white,
                    )
                  : BorderSide(
                      width: 1,
                      color: Theme.of(context).textSelectionHandleColor,
                    ),
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
            inputCursorColor: Theme.of(context).accentColor,
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
            dateBuilder: (String dateTime) => Container(),
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
          _chatViewKey.currentState.scrollController.jumpTo(
            _sizeHeight,
          );
        }
        if (state is ChatMessagesFetchMoreTrySuccess) {
          final int _newMessageCount = state.chatMessageList.messages.length;
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
          _chatViewKey.currentState.scrollController.jumpTo(_newMessageCount.toDouble() * 100);
        }
        if (state is ChatMessageSendTrySuccess) {
          _messages.add(state.chatMessage);

          _chatViewKey.currentState.scrollController.jumpTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent + 200,
          );
        }
        if (state is ChatFailure) {
          CustomToast(
            message: state.message,
          ).show();
        }
        if (state is ChatIncomingMessageFetchSuccess) {
          if (state.chatRoom == _room) {
            _messages.add(state.chatMessage);
            _chatViewKey.currentState.scrollController.jumpTo(
              _chatViewKey.currentState.scrollController.position.maxScrollExtent + 120,
            );
          }
        }
      },
    );
  }
}

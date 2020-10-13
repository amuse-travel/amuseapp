import 'package:flutter/widgets.dart';

abstract class ChatRepository {
  Future<void> sendMessage({@required String message});
}

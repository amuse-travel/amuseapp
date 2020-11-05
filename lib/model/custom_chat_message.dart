class CustomChatMessage {
  CustomChatMessage({
    this.room,
    this.msId,
    this.avatar,
    this.username,
    this.text,
    this.time,
  });

  CustomChatMessage.fromJson(Map<String, dynamic> json) {
    room = json['room'] as String;
    msId = json['msid'] as String;
    avatar = json['avatar'] as String;
    username = json['username'] as String;
    text = json['content']['text'] as String;
    time = json['time'] as int;
  }

  String room;
  String msId;
  String avatar;
  String username;
  String text;
  int time;
}

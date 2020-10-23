class CustomChatMessage {
  CustomChatMessage({
    this.msId,
    this.avatar,
    this.username,
    this.text,
    this.time,
    this.room,
  });

  CustomChatMessage.fromJson(Map<String, dynamic> json) {
    msId = json['msid'] as String;
    avatar = json['avatar'] as String;
    username = json['username'] as String;
    text = json['content']['text'] as String;
    time = json['time'] as int;
    room = json['room'] as String;
  }

  String msId;
  String avatar;
  String username;
  String text;
  int time;
  String room;
}
class ChatList {
  String? key, msg, dateTime;

  ChatList({required this.key, required this.msg, required this.dateTime});

  ChatList.fromJson(Map<String, dynamic> chatMap) {
    key = chatMap["key"];
    msg = chatMap["msg"];
    dateTime = chatMap["dateTime"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["key"] = key;
    map["msg"] = msg;
    map["dateTime"] = dateTime;
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{"key":"$key","dateTime":"$dateTime"}';
  }
}

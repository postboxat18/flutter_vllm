class ChatList {
  String? key, msg;

  ChatList(this.key, this.msg);

  ChatList.fromJson(Map<String, dynamic> chatMap) {
    key = chatMap["key"];
    msg = chatMap["msg"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["key"] = key;
    map["msg"] = msg;
    return map;
  }
}
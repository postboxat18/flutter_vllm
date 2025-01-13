class ChatHistoryList {
  String? key, msg;

  ChatHistoryList(this.key, this.msg);

  ChatHistoryList.fromJson(Map<String, dynamic> chatMap) {
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

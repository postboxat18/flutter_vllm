import 'package:flutter_vllm/Home/Model/chatList.dart';

class ChatHistoryList {
  String? title;
  List<ChatList>? chatList;

  ChatHistoryList(this.title, this.chatList);

  ChatHistoryList.fromJson(Map<String, dynamic> chatMap) {
    title = chatMap["title"];
    List<dynamic> chitDynamic = chatMap["chatList"];
    List<ChatList> inner_chatList = [];
    for (var data in chitDynamic) {
      ChatList list = ChatList.fromJson(data);
      inner_chatList.add(list);
    }
    chatList = inner_chatList;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["title"] = title;
    map["chatList"] = chatList;
    return map;
  }
  @override
  String toString() {
    return '{"title":"$title","chatList":$chatList}';
  }
}

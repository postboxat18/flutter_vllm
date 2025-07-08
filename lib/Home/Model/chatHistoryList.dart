import 'package:flutter_vllm/Home/Model/chatList.dart';

class ChatHistoryList {
  String? title;
  String? uuid_name;
  List<ChatList>? chatList;

  ChatHistoryList(this.title, this.uuid_name,this.chatList);

  ChatHistoryList.fromJson(Map<String, dynamic> chatMap) {
    title = chatMap["title"];
    uuid_name = chatMap["uuid_name"];
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
    map["uuid_name"] = uuid_name;
    map["chatList"] = chatList;
    return map;
  }
  @override
  String toString() {
    return '{"title":"$title","uuid_name":$uuid_name,"chatList":$chatList}';
  }
}

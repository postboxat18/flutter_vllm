import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_vllm/Home/Model/chatHistoryList.dart';
import 'package:flutter_vllm/Home/Model/chatList.dart';

import '../../API/api.dart';
import '../../Utils/sharedPrefs.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeChatHistoryEvent>(homeChatHistoryEvent);
  }

  FutureOr<void> homeChatHistoryEvent(
      HomeChatHistoryEvent event, Emitter<HomeState> emit) async {
    String title = event.title;

    emit(HomeLoading());
    //GET HISTORY
    List<ChatHistoryList> chatHistoryList = getHistory(title);
    // GET MSG FROM VLLM
    if (event.usrMsg.isNotEmpty) {
      // var response = await chatAPI(event.usrMsg);
      // if (response.statusCode == 200) {
      if (true) {
        // var res = response.stream.bytesToString();
        List<ChatList> chatList = [];
        //TITLE IS NOT EXIST
        if (title.isEmpty) {
          title = event.usrMsg.substring(
              0, event.usrMsg.length > 80 ? 80 : event.usrMsg.length);
          chatList.add(ChatList("user", event.usrMsg));
          chatHistoryList.add(ChatHistoryList(title, chatList));
        }
        //TITLE IS EXIST
        else {
          for (int i = 0; i < chatHistoryList.length; i++) {
            //EXIST TITLE
            if (chatHistoryList[i].title == title) {
              for (var res in (chatHistoryList[i].chatList) ?? []) {
                chatList.add(res);
              }
              chatList.add(ChatList("user", event.usrMsg));
              chatHistoryList[i] = ChatHistoryList(title, chatList);
            }
          }
        }
        setChatHistory(chatHistoryList);
      } else {
        emit(HomeError());
      }
    }
    //GET HISTORY
    chatHistoryList = getHistory(title);
    emit(HomeChatHistory(chatHistoryList, title));
  }

  setChatHistory(List<ChatHistoryList> chatHistoryList) async {
    var dicJs = [];
    for (var data in chatHistoryList) {
      var lis = [];
      for (var res in data.chatList ?? []) {
        lis.add('{"key":"${res.key}","msg":"${res.msg}"}');
      }

      if (lis.isNotEmpty) {
        dicJs.add('{"title":"${data.title}","chatList":$lis}');
      }
    }

    if (dicJs.isNotEmpty) {
      await SharedPrefs.setString("chatVllm", dicJs.toString());
    }
  }

  getHistory(String title) {
    List<ChatHistoryList> chatHistoryList = [];
    if (title.isNotEmpty) {
      // CHECK IS EMPTY CHAT
      if (SharedPrefs.getString("chatVllm").isEmpty) {
        chatHistoryList = [];
      } else {
        var shars = SharedPrefs.getString("chatVllm");
        //STR TO JSON
        List<dynamic> chatVllm = jsonDecode(shars);
        for (var data in chatVllm) {
          ChatHistoryList list = ChatHistoryList.fromJson(data);
          chatHistoryList.add(list);
        }
      }
    }
    return chatHistoryList;
  }
}

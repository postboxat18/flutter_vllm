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
    List<ChatHistoryList> chatHistoryList = event.chatHistoryList;
    chatHistoryList = getHistory(title, chatHistoryList);
    // GET MSG FROM VLLM
    if (event.usrMsg.isNotEmpty) {
      // var response = await chatAPI(event.usrMsg);
      // if (response.statusCode == 200) {
      if (true) {
        List<ChatList> chatList = [];
        // var res = response.stream.bytesToString();
        //TITLE IS NOT EXIST
        if (title.isEmpty) {
          title = event.usrMsg.substring(
              0, event.usrMsg.length > 80 ? 80 : event.usrMsg.length);
          chatList.add(ChatList("user", event.usrMsg));
          // chatList.add(ChatList("bot", res.toString()));
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
              // chatList.add(ChatList("bot", res.toString()));
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
    chatHistoryList = getHistory(title, chatHistoryList);
    emit(HomeChatHistory(chatHistoryList, title));
  }

  setChatHistory(List<ChatHistoryList> chatHistoryList) async {
    if (chatHistoryList.isNotEmpty) {
      List<ChatHistoryList> reChatHistoryList = [];
      for (var data in chatHistoryList) {
        List<ChatList> chList = [];
        for (var ch in data.chatList ?? []) {
          String msg = ch.msg
              .replaceAll("\"", "'")
              .replaceAll("\n", "#>")
              .replaceAll("[", "~>")
              .replaceAll("]", "<~")
              .replaceAll("{", "->")
              .replaceAll("}", "<-");
          chList.add(ChatList(ch.key, msg));
        }
        String title = data.title
            .toString()
            .replaceAll("\"", "'")
            .replaceAll("\n", "#>")
            .replaceAll("[", "~>")
            .replaceAll("]", "<~")
            .replaceAll("{", "->")
            .replaceAll("}", "<-");
        reChatHistoryList.add(ChatHistoryList(title, chList));
      }

      await SharedPrefs.setString("chatVllm", reChatHistoryList.toString());
    }
  }

  getHistory(String title, List<ChatHistoryList> chatHistoryList) {
    if (title.isNotEmpty) {
      // CHECK IS EMPTY CHAT
      if (SharedPrefs.getString("chatVllm").isNotEmpty) {
        chatHistoryList = [];
        var shars = SharedPrefs.getString("chatVllm");
        //STR TO JSON
        try {
          var chatVllm =
              json.decode(shars).cast<Map<String, dynamic>>().toList();
          for (var data in chatVllm) {
            ChatHistoryList list = ChatHistoryList.fromJson(data);
            ChatHistoryList main_list;
            List<ChatList> chList = [];
            for (var ch in list.chatList ?? []) {
              String msg = ch.msg
                  .replaceAll("'", "\"")
                  .replaceAll("#>", "\n")
                  .replaceAll("~>", "[")
                  .replaceAll("<~", "]")
                  .replaceAll("->", "{")
                  .replaceAll("<-", "}");
              ChatList ls = ChatList(ch.key, msg);
              chList.add(ls);
            }
            if (chList.isNotEmpty) {
              main_list = ChatHistoryList(list.title, chList);
              chatHistoryList.add(main_list);
            }
          }
        } catch (e) {
          print("error:$e\n$shars");
        }
      }
    }
    return chatHistoryList;
  }
}

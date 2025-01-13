import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_vllm/Home/Model/chatHistoryList.dart';

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
    emit(HomeLoading());
    //GET HISTORY
    List<ChatHistoryList> chatHistoryList = getHistory();
    // GET MSG FROM VLLM
    if (event.usrMsg.isNotEmpty) {
      // var response = await chatAPI(event.usrMsg);
      // if (response.statusCode == 200) {
      if (true) {
        // var res = response.stream.bytesToString();
        chatHistoryList.add(ChatHistoryList("user", event.usrMsg));
        // chatHistoryList.add(ChatHistoryList("bot", res.toString()));
        setChatHistory(chatHistoryList);
      } else {
        emit(HomeError());
      }
    }
    //GET HISTORY
    chatHistoryList = getHistory();
    emit(HomeChatHistory(chatHistoryList));
  }

  setChatHistory(List<ChatHistoryList> chatHistoryList) async {
    var dicJs = [];
    for (var res in chatHistoryList) {
      dicJs.add('{"key":"${res.key}","msg":"${res.msg}"}');
    }
    await SharedPrefs.setString("chatVllm", dicJs.toString());
  }

  getHistory() {
    List<ChatHistoryList> chatHistoryList = [];
    // CHECK IS EMPTY CHAT
    if (SharedPrefs.getString("chatVllm").isEmpty) {
      chatHistoryList = [];
    } else {
      var shars = SharedPrefs.getString("chatVllm");
      //STR TO JSON
      List<dynamic> chatVllm = jsonDecode(shars);
      for (var res in chatVllm) {
        ChatHistoryList list = ChatHistoryList.fromJson(res);
        chatHistoryList.add(list);
      }
    }
    return chatHistoryList;
  }
}

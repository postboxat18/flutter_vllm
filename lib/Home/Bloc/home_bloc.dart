import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_vllm/Home/Model/chatHistoryList.dart';
import 'package:flutter_vllm/Home/Model/chatList.dart';
import 'package:uuid/uuid.dart';

import '../../API/api.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeChatHistoryEvent>(homeChatHistoryEvent);
  }

  FutureOr<void> homeChatHistoryEvent(
      HomeChatHistoryEvent event, Emitter<HomeState> emit) async {
    String title = event.title;
    String uuid_name = event.uuid_name;
    emit(HomeLoading());

    // GET MSG FROM VLLM
    if (event.usrMsg.isNotEmpty) {
      String startTime = DateTime.now().toString();
      var res = await chatAPI(event.usrMsg);
      if (res.value == "") {
        emit(HomeError("Somethings went wrong", 1));
      } else {
        var response = res.value;

        if (response.statusCode == 200) {
          var res = response.body;
          //TITLE IS NOT EXIST
          if (title.isEmpty) {
            title = event.usrMsg.substring(
                0, event.usrMsg.length > 80 ? 80 : event.usrMsg.length);
            var uuid = Uuid();
            var v1 = uuid.v1();
            await setChatHistory(
                title, event.usrMsg, "user", startTime, v1.toString());
            await setChatHistory(title, json.decode(res.toString()), "bot",
                DateTime.now().toString(), v1.toString());
          }
          //TITLE IS EXIST
          else {
            await setChatHistory(
                title, event.usrMsg, "user", startTime, uuid_name);
            await setChatHistory(title, json.decode(res.toString()), "bot",
                DateTime.now().toString(), uuid_name);
          }
        } else {
          emit(HomeError(response.reasonPhrase.toString(), 1));
        }
      }
    }
    //GET HISTORY
    var getRes = await getChatHistory(title, uuid_name);
    List<ChatHistoryList> chatHistoryList = getRes.value;
    emit(HomeChatHistory(chatHistoryList, title));
  }
}

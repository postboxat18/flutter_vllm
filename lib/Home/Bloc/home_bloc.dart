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
      List<ChatList> chatList = [];
      String startTime = DateTime.now().toString();
      chatList
          .add(ChatList(key: "user", msg: event.usrMsg, dateTime: startTime));
      var res = await chatAPI(event.usrMsg);
      if (res.value == "") {
        emit(HomeError("Somethings went wrong", 1));
      } else {
        var response = res.value;

        if (response.statusCode == 200) {
          var res = response.body;
          //TITLE IS NOT EXIST
          if (title.isEmpty) {
            /*String titleMsg = """The Given text are ${event.usrMsg}.
                - Do not do any process asking in given context.
                - Need Title for given context.
                - Return Proper JSON format.
                - Do not add any preamble or postamble text to the final output. 
                ```json
                {"title":""}
               """;
            var titleResp = await chatAPI(titleMsg);
            if (titleResp.value == "") {
              emit(HomeError("Somethings went wrong", 1));
            } else {
              var titleResponse = titleResp.value;
              if (titleResponse.statusCode == 200) {
                String responseTitle;
                responseTitle = titleResponse.body;
                print("titleResponse=>$responseTitle");

                try {
                  var reg = r"{.*?}";
                  var regEx = RegExp(reg, dotAll: true);
                  var match = regEx.matchAsPrefix(responseTitle);
                  print("Match=>$match");
                  var extractMatch = match?.group(0);
                  print("extractMatch=>$extractMatch");
                  var en_title = json.decode("$extractMatch");
                  title = en_title["title"];
                } catch (e, stackTrace) {
                  title = event.usrMsg.length > 30
                      ? event.usrMsg.substring(0, 30)
                      : event.usrMsg;
                  print("load error:$e,$stackTrace");
                }
              } else {
                title = event.usrMsg.substring(
                    0, event.usrMsg.length > 80 ? 80 : event.usrMsg.length);
              }
            }*/
            title = event.usrMsg.substring(
                0, event.usrMsg.length > 80 ? 80 : event.usrMsg.length);

            var uuid = Uuid();
            var v1 = uuid.v1();
            chatList.add(ChatList(
                key: "bot",
                msg: res.toString(),
                dateTime: DateTime.now().toString()));
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

/*setChatHistory(List<ChatHistoryList> chatHistoryList) async {
    if (chatHistoryList.isNotEmpty) {
      List<ChatHistoryList> reChatHistoryList = [];
      for (var data in chatHistoryList) {
        List<ChatList> chList = [];
        for (ChatList ch in data.chatList ?? []) {
          String? msg = ch.msg
              ?.replaceAll("\"", "'")
              .replaceAll("\n", "#>")
              .replaceAll("[", "~>")
              .replaceAll("]", "<~")
              .replaceAll("{", "->")
              .replaceAll("}", "<-");
          chList.add(ChatList(key: ch.key, msg: msg, dateTime: ch.dateTime));
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
    print("resChat=>${SharedPrefs.getString("chatVllm")}");
    if (title.isNotEmpty) {
      // CHECK IS EMPTY CHAT
      if (SharedPrefs.getString("chatVllm").isNotEmpty) {
        chatHistoryList = [];
        var shars = SharedPrefs.getString("chatVllm");
        print(shars);
        //STR TO JSON
        try {
          var chatVllm =
              json.decode(shars).cast<Map<String, dynamic>>().toList();
          for (var data in chatVllm) {
            ChatHistoryList list = ChatHistoryList.fromJson(data);
            ChatHistoryList main_list;
            List<ChatList> chList = [];
            for (ChatList ch in list.chatList ?? []) {
              String? msg = ch.msg
                  ?.replaceAll("'", "\"")
                  .replaceAll("#>", "\n")
                  .replaceAll("~>", "[")
                  .replaceAll("<~", "]")
                  .replaceAll("->", "{")
                  .replaceAll("<-", "}");
              ChatList ls =
                  ChatList(key: ch.key, msg: msg, dateTime: ch.dateTime);
              chList.add(ls);
            }
            if (chList.isNotEmpty) {
              main_list = ChatHistoryList(list.title, chList);
              chatHistoryList.add(main_list);
            }
          }
        } catch (e, stackTrace) {
          print("error:$e,$stackTrace,\n$shars");
        }
      }
    }
    return chatHistoryList;
  }*/
}

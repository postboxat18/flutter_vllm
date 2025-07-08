import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vllm/Home/Bloc/home_bloc.dart';
import 'package:flutter_vllm/Home/Model/chatHistoryList.dart';
import 'package:intl/intl.dart';
import '../../Drawer/UI/drawer.dart';
import '../Model/chatList.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeBloc homeBloc = HomeBloc();
  late HomeBloc homeHistoryBloc = HomeBloc();
  late TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    homeHistoryBloc.add(HomeChatHistoryEvent("", "", "", []));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: homeBloc,
      listener: (context, initState) {},
      builder: (context, initState) {
        return BlocBuilder(
          bloc: homeHistoryBloc,
          builder: (context, hisState) {
            Widget historyWidget;
            String title = "";
            String uuid_name = "";
            List<ChatHistoryList> chatHistoryList = [];
            if (hisState is HomeChatHistory) {
              title = hisState.title;
              chatHistoryList = hisState.chatHistoryList;

              int id = chatHistoryList.indexWhere(
                (element) => element.title == title,
              );
              List<ChatList> chatList = [];
              if (id != -1) {
                chatList = chatHistoryList[id].chatList ?? [];
                uuid_name = chatHistoryList[id].uuid_name ?? "";
              }

              if (chatList.isNotEmpty) {
                historyWidget = ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    if (chatList[index].key == "bot") {
                      String msg = chatList[index].msg.toString();

                      /*  var jsStr = chatList[index].msg.toString();
                        RegExp reg = RegExp(r'\[\s*{.*?}\s*\]');
                        var cpyList = reg.allMatches(jsStr);*/

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            chatList[index].dateTime.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: Colors.blue,
                            ),
                            margin: EdgeInsets.fromLTRB(10, 10, 55, 10),
                            padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
                            child: Text(
                              msg.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    } else {
                      var jsStr = chatList[index].msg.toString();
                      /*RegExp reg = RegExp(r'\[\s*{.*?}\s*\]');
                        var cpyList = reg.allMatches(jsStr);
                        print("cpyList::$cpyList");*/

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                chatList[index].dateTime.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.fromLTRB(55, 10, 10, 10),
                            padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
                            child: Text(
                              chatList[index].msg.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              } else {
                historyWidget = const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please Start Your Chat",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                );
              }
            } else if (hisState is HomeLoading) {
              historyWidget = const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              );
            } else if (hisState is HomeError) {
              historyWidget = const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Getting Error",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            } else {
              historyWidget = const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Something went Wrong",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            }
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text("Flutter Vllm"),
                  actions: [
                    //NEW CHAT
                    IconButton(
                        onPressed: () {
                          homeHistoryBloc.add(HomeChatHistoryEvent(
                              "", "", "", chatHistoryList));
                        },
                        icon: Icon(Icons.mode_edit_rounded))
                  ],
                ),
                drawer: chatHistoryList.isEmpty
                    ? Container()
                    : MyDrawer(homeHistoryBloc, title, chatHistoryList),
                body: Column(children: [
                  //HISTORY
                  Expanded(child: historyWidget),
                  //CHAT
                  Container(
                    color: Colors.black,
                    child: Row(
                      children: [
                        //ADD
                        /*Icon(
                  Icons.add_outlined,
                ),*/
                        //CHAT
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              controller: textEditingController,
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //SEND
                        IconButton(
                          onPressed: () {
                            if (textEditingController.text.trim().isNotEmpty) {
                              homeHistoryBloc.add(HomeChatHistoryEvent(
                                  textEditingController.text.trim(),
                                  title,
                                  uuid_name,
                                  chatHistoryList));
                              textEditingController.clear();
                            }
                          },
                          icon: Icon(Icons.send_rounded),
                        ),
                      ],
                    ),
                  ),
                ]));
          },
        );
      },
    );
  }
}

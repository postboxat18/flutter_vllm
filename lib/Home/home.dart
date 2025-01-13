import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vllm/Home/Bloc/home_bloc.dart';
import 'package:flutter_vllm/Home/Model/chatHistoryList.dart';

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
    homeHistoryBloc.add(HomeChatHistoryEvent(""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: homeBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Flutter Vllm"),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //HISTORY
              BlocBuilder(
                bloc: homeHistoryBloc,
                builder: (context, state) {
                  if (state is HomeChatHistory) {
                    List<ChatHistoryList> chatHistoryList =
                        state.chatHistoryList;
                    if (chatHistoryList.isNotEmpty) {
                      return ListView.builder(
                        itemCount: chatHistoryList.length,
                        itemBuilder: (context, index) {
                          if (chatHistoryList[index].key == "bot") {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  color: Colors.blue,
                                  margin: EdgeInsets.fromLTRB(5, 10, 15, 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "data $index",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.fromLTRB(15, 10, 5, 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      chatHistoryList[index].msg.toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    } else {
                      return Column(
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
                  } else if (state is HomeLoading) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    );
                  } else if (state is HomeError) {
                    return const Column(
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
                    return const Column(
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
                },
              ),
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
                              textEditingController.text.trim()));
                          textEditingController.clear();
                        }
                      },
                      icon: Icon(Icons.send_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

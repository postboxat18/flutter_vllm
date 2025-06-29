import 'package:flutter/material.dart';
import 'package:flutter_vllm/Home/Bloc/home_bloc.dart';
import 'package:flutter_vllm/Home/Model/chatHistoryList.dart';

class MyDrawer extends StatefulWidget {
  late HomeBloc homeHistoryBloc;
  late String title;
  late List<ChatHistoryList> chatHistoryList;

  MyDrawer(this.homeHistoryBloc, this.title, this.chatHistoryList, {super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //RECENT
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Recent Chats",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          //HISTORY TITLE LIST
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.chatHistoryList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: widget.chatHistoryList[index].title.toString().isEmpty
                    ? null
                    : () {
                        widget.homeHistoryBloc.add(HomeChatHistoryEvent(
                            "",
                            widget.chatHistoryList[index].title.toString(),
                            widget.chatHistoryList[index].uuid_name.toString(),
                            widget.chatHistoryList));
                        Navigator.pop(context);
                      },
                child: widget.chatHistoryList[index].title.toString().isEmpty?Container():Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: widget.chatHistoryList[index].title.toString() ==
                            widget.title
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.chatHistoryList[index].title.toString(),
                    style: TextStyle(
                        fontWeight:
                            widget.chatHistoryList[index].title.toString() ==
                                    widget.title
                                ? FontWeight.bold
                                : FontWeight.normal,
                        color: widget.chatHistoryList[index].title.toString() ==
                                widget.title
                            ? Colors.black
                            : Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

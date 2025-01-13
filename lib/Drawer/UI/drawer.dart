import 'package:flutter/material.dart';
import 'package:flutter_vllm/Home/Model/chatHistoryList.dart';

class MyDrawer extends StatefulWidget {
  List<ChatHistoryList> chatHistoryList;

  MyDrawer(this.chatHistoryList, {super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.chatHistoryList.length,
      itemBuilder: (context, index) => Flexible(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(widget.chatHistoryList[index].title.toString()),
        ),
      ),
    ));
  }
}

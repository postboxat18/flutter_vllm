import 'dart:convert';
import "package:collection/collection.dart";
import 'package:flutter_vllm/Home/Model/chatHistoryList.dart';
import 'package:flutter_vllm/Home/Model/chatList.dart';

void main() {
  // resFunc();
  func();
}

void func() {
  String title="{\n  \\\"title\": \\\\\"Medicine Prescriptions\\\\\"\n}";
  var reg= r"{.*?}";
  var regEx=RegExp(reg,dotAll: true);
  title=title.replaceAll("\\", "");
  var match=regEx.matchAsPrefix(title);
  print(match?.group(0));
}
void resFunc() {
    var data = [
      {"title": 'Avengers', "release_date": '10/01/2019'},
      {"title": 'Creed', "release_date": '10/01/2019'},
      {"title": 'Jumanji', "release_date": '30/10/2019'},
    ];
    var newMap = groupBy(data, (Map obj) => obj['release_date']);
    print(newMap);

}

import 'dart:convert';
import "package:collection/collection.dart";
import 'package:flutter_vllm/Home/Model/chatHistoryList.dart';
import 'package:flutter_vllm/Home/Model/chatList.dart';
import 'package:uuid/uuid.dart';

void main() {
  // resFunc();
  func();
}

void func() {
  String title="\"```json\\n{\\\"title\\\": \\\"The Given text are need vitals report.\\\"}\\n```\"";
  // var reg= r"{.*?}";
  // var regEx=RegExp(reg,dotAll: true);
  // var match=regEx.firstMatch(json.decode(title));
  // var enMatch=match?.group(0);
  // print(enMatch);
  // print(json.decode(enMatch.toString())["title"]);

  // Step 2: Regex to find: "title": "some value"
  var uuid = Uuid();
  var v1 = uuid.v1();
  print(v1.toString());



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

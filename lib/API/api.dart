import 'dart:convert';

import 'package:flutterx_live_data/flutterx_live_data.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import "package:collection/collection.dart";

import '../Home/Model/chatHistoryList.dart';
import '../Home/Model/chatList.dart';

String url = 'http://192.168.21.233:8080/';
// vllm serve meta-llama/Llama-3.1-8B-Instruct --disable-custom-all-reduce --tensor-parallel-size 4 > /dev/null
chatAPI1(String msg) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://172.18.40.183:8080/v1/completions'));
    request.body = json.encode({
      "model": "TinyLlama/TinyLlama-1.1B-Chat-v1.0",
      "prompt": msg,
      "max_tokens": 2048,
    });

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
    } else {
      print(response.reasonPhrase);
    }
    return response;
  } catch (e, stackTrace) {
    print("res=>error=>$e,$stackTrace}");
  }
}

Future<MutableLiveData> chatAPI(String msg) async {
  MutableLiveData liveData = MutableLiveData();
  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({"prompt": msg, "text": msg});
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      liveData.value = response;
    } else {
      liveData.value = response;
    }
  } catch (e, stackTrace) {
    print("error=>chatApi=>$e,$stackTrace}");
    liveData.value = "";
  }
  return liveData;
}

//SET
Future<MutableLiveData> setChatHistory(String title, String msg, String key,
    String dateTime, String uuid_name) async {
  MutableLiveData liveData = MutableLiveData();

  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${url}setHistory'));
    var dict_ = {
      "uuid_name": uuid_name,
      "title": title,
      "msg": msg,
      "key": key,
      "dateTime": dateTime
    };
    print("dict_=>$dict_");
    request.body = json.encode(dict_);
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      liveData.value = true;
    } else {
      liveData.value = false;
    }
  } catch (e, stackTrace) {
    print("error=>setChat Hist=>$e,$stackTrace");
    liveData.value = false;
  }
  return liveData;
}

//GET
Future<MutableLiveData> getChatHistory(String title, String uuid_name) async {
  MutableLiveData liveData = MutableLiveData();
  List<ChatHistoryList> chatHistoryList = [];
  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${url}getHistory'));
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var list_ = json.decode(response.body);
      var map_ = groupBy(
        list_,
        (Map p0) => p0["uuid_name"],
      );
      for (var data in map_.entries) {
        List<ChatList> chatList = [];
        if (uuid_name == data.key || uuid_name.isEmpty) {
          for (var res in data.value) {
            String key = res["key"];
            chatList.add(ChatList(
                key: key,
                msg: key == "user" ? res["msg"] : json.decode(res["msg"]),
                dateTime: res["dateTime"]));
          }
        }
        chatHistoryList
            .add(ChatHistoryList(data.value[0]["title"], uuid_name, chatList));
      }
      liveData.value = chatHistoryList;
    } else {
      liveData.value = chatHistoryList;
    }
  } catch (e, stackTrace) {
    print("error=>getChatHist=>$e,$stackTrace");
    liveData.value = chatHistoryList;
  }
  return liveData;
}

import 'dart:convert';

import 'package:http/http.dart' as http;

chatAPI(String msg) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('http://localhost:8000/v1/chat/completions'));
  request.body = json.encode({
    "model": "meta-llama/Llama-3.1-8B-Instruct",
    "messages": [
      {"role": "user", "content": msg}
    ]
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var res = response;
  return res;
}

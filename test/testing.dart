import 'dart:convert';

import 'package:flutter_vllm/Home/Model/chatHistoryList.dart';
import 'package:flutter_vllm/Home/Model/chatList.dart';

void main() {
//   String data = '{key: user, msg: dsad}';
//   String data='[{"title":"start","chatList":[{"key":"user","msg":"start"}]}]';
  List<ChatHistoryList> chatHistoryList = [];
  List<ChatList> chatList = [];
  chatList.add(ChatList("user",
      """Extract medicine-related data from the provided context and structure it in JSON format. Follow these   specific instructions:

      Scope of Extraction:

      Only rely on the information explicitly present in the given context. Do not use external knowledge.
      Ignore unrelated data and do not include it in the output.
      Output Details:

      Capture the following fields for each medicine entry:
      medicine name: The generic name of the medicine(ensure units and dosage form are removed from this field).
  brand name : The brand name of the medicine if it is provided in the given context(generally the brand name will be mentioned inside brackets near the generic name of the medicine).
  dosage form: Tablet, capsule, injection, spray, cream, etc.
  dosage: The dosage amount.
  unit of measurement: mg, ml, mcg, %, ACT, or any other units explicitly mentioned.
  frequency range: Frequency details as provided (e.g., "twice a day," "every 6 hours").
  route of administration: The method of delivery (e.g., oral, intravenous).
  start date: Start date of the medication if available.(e.g., "start date","issue date","Last Released").
  end date: End date of the medication, if available.(e.g., "end date","expr date","Expiration Date","Stop Date","Discontinued on").
  date counts:Calculate the total number of days based on the provided medication schedule (e.g., "90 days", "6 days", "180 days", and "2 weeks ago").
  report type: The category of the report under which the medicine information is extracted (e.g., medication, allergies, laboratory).
  Handling Missing Information:

  If any information is not present in the context, include the field with an empty string ("").
  Exclusion Criteria:

  If the context does not contain medicine-related data, do not generate any output.
  Output Format:

  Provide the response in the following JSON structure, strictly without any preamble or postamble:
  ```
  [{
  "medicine name":"",
  "brand name":"",
  "dosage form":"",
  "dosage":"",
  "unit of measurement":"",
  "frequency range":"",
  "route of administration":"",
  "report type":"",
  "start date":"",
  "end date":"",
  "date counts":""

  }]
  ```
  unit of measurement: mg, ml, mcg, %, ACT, from the given context.
  report type: Identify the topic under which the medicine name is extracted for example medication, allergies, laboratory as such."""));
  // chatList.add(ChatList("bot", res.toString()));
  chatHistoryList.add(ChatHistoryList("Flutter Vllm", chatList));
  // String data="""[{"title":"Extract medicine-related data from the provided context and structure it in JSON","chatList":[{"key":"user","msg":"Extract medicine-related data from the provided context and structure it in JSON format. Follow these   specific instructions:              Scope of Extraction:              Only rely on the information explicitly present in the given context. Do not use external knowledge.             Ignore unrelated data and do not include it in the output.             Output Details:              Capture the following fields for each medicine entry:             medicine name: The generic name of the medicine(ensure units and dosage form are removed from this field).             brand name : The brand name of the medicine if it is provided in the given context(generally the brand name will be mentioned inside brackets near the generic name of the medicine).             dosage form: Tablet, capsule, injection, spray, cream, etc.             dosage: The dosage amount.             unit of measurement: mg, ml, mcg, %, ACT, or any other units explicitly mentioned.             frequency range: Frequency details as provided (e.g., "twice a day," "every 6 hours").             route of administration: The method of delivery (e.g., oral, intravenous).             start date: Start date of the medication if available.(e.g., "start date","issue date","Last Released").             end date: End date of the medication, if available.(e.g., "end date","expr date","Expiration Date","Stop Date","Discontinued on").             date counts:Calculate the total number of days based on the provided medication schedule (e.g., "90 days", "6 days", "180 days", and "2 weeks ago").             report type: The category of the report under which the medicine information is extracted (e.g., medication, allergies, laboratory).             Handling Missing Information:              If any information is not present in the context, include the field with an empty string ("").             Exclusion Criteria:              If the context does not contain medicine-related data, do not generate any output.             Output Format:              Provide the response in the following JSON structure, strictly without any preamble or postamble:                 ```                 [{                     "medicine name":"",                     "brand name":"",                     "dosage form":"",                     "dosage":"",                     "unit of measurement":"",                     "frequency range":"",                     "route of administration":"",                     "report type":"",                     "start date":"",                     "end date":"",                     "date counts":""                  }]                 ```                 unit of measurement: mg, ml, mcg, %, ACT, from the given context.                 report type: Identify the topic under which the medicine name is extracted for example medication, allergies, laboratory as such."}]}]""";
  var encodedString = json
      .decode(chatHistoryList.toString())
      .cast<Map<String, dynamic>>()
      .toList();
  // var encodedString = jsonDecode(chatHistoryList.toString());
  print("encodedString:$encodedString");
  var chatVllm = encodedString;
  // List<dynamic> chatVllm = jsonDecode(encodedString);
  for (var data in chatVllm) {
    ChatHistoryList list = ChatHistoryList.fromJson(data);
    chatHistoryList.add(list);
  }
  print("chatHist:$chatHistoryList");
//   var map = json.decode(encodedString);
//   print(map);
//   var res=jsonDecode(map);
//   print(res);
//     Map<String, dynamic> valueMap = json.decode(encodedString);

//     print(valueMap);
}

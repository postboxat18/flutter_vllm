// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

void main() {
  // func();
  fes();
}

void fes() {
  String responseTitle = "{\n  \"title\": \"Medicine Prescriptions\"\n}";

  String fixedText = responseTitle;
  Map<String, dynamic> en_title = json.decode(fixedText.toString());

}

void func() {
  String responseTitle = "{\n  \"title\": \"Medicine Prescriptions\"\n}";
  final regexp = RegExp(r'{.*?}', dotAll: true);
  final match = regexp.firstMatch(responseTitle.toString());
  print(match);
  final matchedText = match?.group(0);
  String fixedText = matchedText.toString().replaceAll("'", '"');
  print(fixedText);
  Map<String, dynamic> en_title = json.decode(fixedText.toString());
  print(en_title);
  print(en_title["title"]);
}

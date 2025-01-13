import 'dart:convert';

class User {
  int? id;
  String? name;
  String? address;

  User({this.id, this.name, this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

void main() {
//   String data = '{key: user, msg: dsad}';
  String data='[{"title":"start","chatList":[{"key":"user","msg":"start"}]}]';

  var encodedString = jsonDecode(data);
  print(encodedString);
//   var map = json.decode(encodedString);
//   print(map);
//   var res=jsonDecode(map);
//   print(res);
//     Map<String, dynamic> valueMap = json.decode(encodedString);

//     print(valueMap);
}

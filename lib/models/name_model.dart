import 'package:demo/models/base_response.dart';

class NameModel extends BaseResponse {
  String title;
  String first;
  String last;

  NameModel({
    this.title,
    this.first,
    this.last,
  });

  NameModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      title = json['title'] == null ? "" : json['title'];
      first = json['first'] == null ? "" : json['first'];
      last = json['last'] == null ? "" : json['last'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['first'] = this.first;
    data['last'] = this.last;
    return data;
  }
}
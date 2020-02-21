import 'package:demo/models/base_response.dart';

class LocationModel extends BaseResponse {
  String street;
  String city;
  String state;
  String zip;

  LocationModel({
    this.street,
    this.city,
    this.state,
    this.zip,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      street = json['street'] == null ? "" : json['street'];
      city = json['city'] == null ? "" : json['city'];
      state = json['state'] == null ? "" : json['state'];
      zip = json['zip'] == null ? "" : json['zip'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    return data;
  }
}
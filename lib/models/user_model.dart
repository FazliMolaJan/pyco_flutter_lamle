 

import 'package:demo/models/base_response.dart';
import 'package:demo/models/location_model.dart';
import 'package:demo/models/name_model.dart';

class UserModel extends BaseResponse {
  String gender;
  NameModel name; 
  LocationModel location;
  String email;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;
  String registered;
  String dob;
  String phone;
  String cell;
  String ssn;
  String picture;

  UserModel({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.username,
    this.password,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256,
    this.registered,
    this.dob,
    this.phone,
    this.cell,
    this.ssn,
    this.picture,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      gender = json['gender'] == null ? "" : json['gender'];
      name = json['name'] == null ? null : NameModel.fromJson(json['name']);
      location = json['location'] == null ? null : LocationModel.fromJson(json['location']);
      email = json['email'] == null ? "" : json['email'];
      username = json['username'] == null ? "" : json['username'];
      password = json['password'] == null ? "" : json['password'];
      salt = json['salt'] ?? "";
      md5 = json['md5'] ?? "";
      sha1 = json['sha1'] ?? "";
      sha256 = json['sha256'] ?? "";
      registered = json['registered'] ?? "";
      dob = json['dob'] ?? "";
      phone = json['phone'] ?? "";
      cell = json['cell'] ?? "";
      ssn = json['SSN'] ?? "";
      picture = json['picture'] ?? "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['name'] = this.name;
    data['location'] = this.location;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['salt'] = this.salt;
    data['md5'] = this.md5;
    data['sha1'] = this.sha1;
    data['sha256'] = this.sha256;
    data['registered'] = this.registered;
    data['dob'] = this.dob;
    data['phone'] = this.phone;
    data['cell'] = this.cell;
    data['SSN'] = this.ssn;
    data['picture'] = this.picture;
    return data;
  }
}

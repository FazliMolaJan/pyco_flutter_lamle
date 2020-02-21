import 'package:demo/models/base_response.dart';
import 'package:demo/models/user_model.dart';

class ParentUserModel extends BaseResponse {
  String seed;
  String version;
  UserModel user;

  ParentUserModel({
    this.seed,
    this.version,
    this.user,
  });

  ParentUserModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      seed = json['seed'] == null ? "" : json['seed'];
      version = json['version'] == null ? "" : json['version'];
      user = json['user'] == null ? null : UserModel.fromJson(json['user']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seed'] = this.seed;
    data['version'] = this.version;
    data['user'] = this.user;
    return data;
  }
}
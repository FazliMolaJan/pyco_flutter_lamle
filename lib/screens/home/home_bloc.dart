import 'dart:convert';

import 'package:bflutter/bflutter.dart';
import 'package:demo/models/base_response.dart';
import 'package:demo/models/parent_user_model.dart';
import 'package:demo/provider/account_api.dart';
import 'package:demo/provider/shared_pref.dart';
import 'package:demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final loading = BlocDefault<bool>();
  final accountApi = AccountApi();
  var getListCustomer = Bloc<String, List<ParentUserModel>>();
  var listUserBloc = BlocDefault<List<ParentUserModel>>();
  var isSwiftRightBloc = BlocDefault<bool>();

  var listUsers = List<ParentUserModel>();
  BuildContext context;

  HomeBloc() {
    _initLogic();
  }

  void _initLogic() {
    getListCustomer.logic = (Observable<String> input) => input
        .map((input) {
          loading.push(true);
          return input;
        })
        .timeout(Duration(seconds: 30))
        .asyncMap(accountApi.getListUsers)
        .asyncMap(
          (data) {
            if (data.statusCode == 200) {
              var dataRes = BaseResponse.fromJson(json.decode(data.body));
              var list = dataRes.data == null
                  ? List<ParentUserModel>()
                  : (dataRes.data as List)
                      .map((i) => new ParentUserModel.fromJson(i))
                      .toList();
              return list;
            } else {
              loading.push(false);
              throw (data.body);
            }
          },
        )
        .handleError((error) async {
          loading.push(false);

          var dataError = BaseResponse.fromJson(json.decode(error));
          if (dataError.errors.length > 0) {
            Utils.showToast(dataError.errors.first.message ?? '', context);
          }
        })
        .doOnData((data) {
          loading.push(false);
          // if (listUsers.length > 0) {
          //   listUsers.addAll(data);
          // } else {
          //   listUsers = data;
          // }
          listUsers = data;
          SharedPrefService.internal().saveListUser(listUsers);
          this.listUserBloc.push(listUsers);
        });
  }

///////////////////GET LIST/////////////////////////////////////////////
  Future<void> getListUsers(BuildContext context) async {
    this.context = context;
    var isConnect = await Utils.checkInternetIfHave();
    if (!isConnect) {
      var list = await SharedPrefService.internal().getListUser();
      if (list != null) {
        this.listUserBloc.push(list);
      }
    } else {
      getListCustomer.push('');
    }
  }

  void swiftRight(bool isSwiftRight) {
    isSwiftRightBloc.push(isSwiftRight);
  }

///////////////////DISPOSE/////////////////////////////////////////////
  void dispose() {
    loading.dispose();
    getListCustomer.dispose();
    listUserBloc.dispose();
    isSwiftRightBloc.dispose();
  }
}

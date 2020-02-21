import 'package:flutter/material.dart';

/// Environment declare here
class Env {
  Env._({@required this.apiBaseUrl});

  final String apiBaseUrl;

  factory Env.dev() {
    return Env._(apiBaseUrl: "https://randomuser.me/api");
  }

  factory Env.staging() {
    return Env._(apiBaseUrl: "https://randomuser.me/api"); 
  }
}
/// Global env
class Global {
  Global._private();

  static final Global _instance = Global._private();

  factory Global() => _instance;

  Env env = Env.dev();
}
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';

class Utils {
  static double getHeightFromScreenSize(
      BuildContext context, double heightDesign) {
    return MediaQuery.of(context).size.height * heightDesign / 812; //Iphone X
  }

  static double getWidthFromScreenSize(
      BuildContext context, double widthDesign) {
    return MediaQuery.of(context).size.width * widthDesign / 375; //Iphone X
  }

  static bool validateMail(String mail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(mail);
  }

  static bool validatePhoneNumber(String phoneNumber) {
    Pattern pattern = r'^[0-9]+$';
    RegExp regex = new RegExp(pattern);
    if (phoneNumber.length == 0) {
      return false;
    }
    return regex.hasMatch(phoneNumber) &&
        ((phoneNumber.length == 10 && phoneNumber[0] == "0") ||
            (phoneNumber.length == 9 && phoneNumber[0] != "0"));
  }

  static Future<bool> checkInternetIfHave() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Widget buildLoading(bool isLoading) {
    if (isLoading) {
      return Container(
        color: Color.fromRGBO(40, 42, 62, 0),
        child: SpinKitCircle(color: Color.fromRGBO(204, 155, 117, 1)),
        alignment: Alignment.center,
      );
    } else {
      return SizedBox();
    }
  }

  static File resizeImage(File file) {
    img.Image imageTemp = img.decodeImage(file.readAsBytesSync());
    img.Image resizedImg = img.copyResize(imageTemp, width: 500, height: 500);
    return file..writeAsBytesSync(img.encodePng(resizedImg));
  }

  static showToast(String text, BuildContext contextx) {
    Toast.show(text, contextx,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundRadius: 10,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        textColor: Colors.white);
  }

}

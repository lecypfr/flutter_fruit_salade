import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  String accessToken = "";
  String refreshToken = "";

  init(responseHttp) {
    print(responseHttp);
    // accessToken = responseHttp.accessToken;
    // refreshToken = responseHttp.refreshToken;
    // print(accessToken);
    // print(refreshToken);
  }
}

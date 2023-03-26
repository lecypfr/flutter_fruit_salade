import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

class UserProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  late String accessToken;
  late String refreshToken;
  late Map<String, dynamic> user;

  init(responseHttp) {
    Map<String, dynamic> json = jsonDecode(responseHttp)['data'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    user = Jwt.parseJwt(accessToken);
  }

  refresh() {}
}

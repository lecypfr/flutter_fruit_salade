class User {
  String password;
  String email;

  User({required this.password, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
    };
  }
}

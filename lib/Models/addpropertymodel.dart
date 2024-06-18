class PropertyModel{
  final String? username;
  final String? email;
  final String? password;
  final String? mobileno;
  final String? gender;
  final String? filePath;

  PropertyModel({
    this.username,
    this.email,
    this.password,
    this.mobileno,
    this.gender ,
    this.filePath ,
  });

  PropertyModel copyWith({
    String? username,
    String? email,
    String? password,
    String? mobileno,
    String? gender,
    String? filePath,
  }) {
    return PropertyModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      mobileno: mobileno ?? this.mobileno,
      gender: gender ?? this.gender,
      filePath: filePath ?? this.filePath,
    );
  }

  PropertyModel clear() {
    return PropertyModel(
      username: null,
      email: null,
      password: null,
      mobileno: null,
      gender: null,
      filePath: null,
    );
  }
}
class UserModel {
  final String id;
  final String emailOrPhone;

  const UserModel({
    required this.id,
    required this.emailOrPhone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      emailOrPhone: json['emailOrPhone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'emailOrPhone': emailOrPhone,
    };
  }
}



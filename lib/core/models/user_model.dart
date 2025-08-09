class UserModel {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String additionalInfo;
  final String imageUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.additionalInfo,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'additionalInfo': additionalInfo,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      additionalInfo: map['additionalInfo'],
      imageUrl: map['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, phone: $phone, additionalInfo: $additionalInfo, imageUrl: $imageUrl,)';
  }
}

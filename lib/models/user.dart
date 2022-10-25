class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String profilePictureUrl;
  // final bool isSeller;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profilePictureUrl,
    // required this.isSeller,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        // isSeller: json['seller'] as bool,
        profilePictureUrl: json['profile_picture_url']??'' as String);
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone, profile_picture_url: $profilePictureUrl}';
  }
}

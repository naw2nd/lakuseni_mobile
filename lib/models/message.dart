import 'seller.dart';
import 'user.dart';

class Message {
  final int id;
  final String text;
  final User user;

  Message({
    required this.id,
    required this.text,
    required this.user,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int,
      text: json['text'] as String,
      user: User.fromJson(json['user']),
    );
  }
}

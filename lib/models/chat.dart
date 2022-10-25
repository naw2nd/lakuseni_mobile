import 'package:lakuseni_user/models/message.dart';
import 'package:lakuseni_user/models/user.dart';

import 'seller.dart';

class Chat {
  final int id;
  final User user;
  final Seller seller;
  final bool opened;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.user,
    required this.seller,
    required this.opened,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] as int,
      opened: json['opened'] as bool,
      user: User.fromJson(json['user']),
      seller: Seller.fromJson(json['seller']),
      messages: List<Message>.from(
          json['mesages'].map((message) => Message.fromJson(message))),
    );
  }
}

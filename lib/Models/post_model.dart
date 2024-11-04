import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String owner; // The person who created the post
  String community; // The community where the post is shared
  String content; // The actual content of the post
  int chars; // Character count of the content
  DateTime date; // Date when the post was created

  // Constructor
  PostModel({
    required this.owner,
    required this.community,
    required this.content,
    required this.chars,
    required this.date,
  });

  // Factory method for creating a PostModel instance from a map (useful for Firestore)
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      owner: map['owner'] ?? '',
      community: map['community'] ?? '',
      content: map['content'] ?? '',
      chars: map['chars'] ?? 0,
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  // Method to convert PostModel instance to map (useful for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'owner': owner,
      'community': community,
      'content': content,
      'chars': chars,
      'date': date,
    };
  }
}

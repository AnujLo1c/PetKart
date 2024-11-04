import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityModel {
  final String id;
  final String name;
  final double rating;
  final List<String> members;
  final String? shortDescription;
  final int? imagesCount;
  final String? description;
  final List<String>? imageUrls;
  final String owner; // New owner field

  CommunityModel({
    required this.name,
    required this.rating,
    required this.members,
    required this.owner, // Owner added to constructor
    this.shortDescription,
    this.imagesCount,
    this.description,
    this.imageUrls,
    String? id,
  }) : id = id ?? _generateIdFromName(name);

  static String _generateIdFromName(String name) {
    return name.replaceAll(' ', '');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'members': members,
      'shortDescription': shortDescription,
      'imagesCount': imagesCount,
      'description': description,
      'imageUrls': imageUrls,
      'owner': owner, // Include owner in the map
    };
  }

  factory CommunityModel.fromFirestore(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    print(1);
    return CommunityModel(
      id: doc.id,
      name: map['name'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      members: map['members'] is List ? List<String>.from(map['members']) : [],
      shortDescription: map['shortDescription'],
      imagesCount: map['imagesCount'],
      description: map['description'],
      imageUrls: map['imageUrls'] != null ? List<String>.from(map['imageUrls']) : null,
      owner: map['owner'] ?? '', // Retrieve owner from Firestore
    );
  }
}

class CartAnimalItem {
  final String id;
  final String name;
  final String gender;
  final String age;
  final String location;
  final String price;
  final String imageUrl;
  int? quantity; // Optional quantity field
  final bool delivery; // Indicates if delivery is available
  final String deliveryPrice; // Price for delivery

  CartAnimalItem({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.location,
    required this.price,
    required this.imageUrl,
    this.quantity, // Optional
    required this.delivery,
    required this.deliveryPrice,
  });

  // Factory constructor to create an instance from a map
  factory CartAnimalItem.fromMap(String id, Map<String, dynamic> pet) {
    return CartAnimalItem(
      id: id,
      name: pet['petName'] ?? 'Unknown',
      gender: pet['gender'] ?? 'Unknown',
      age: pet['age'] ?? 'Unknown',
      location: pet['location'] ?? 'Unknown',
      price: pet['price']?.toString() ?? '0',
      imageUrl: pet['primaryImageUrl'] ?? 'assets/picture/puppy.png',
      quantity: pet['quantity'], // Nullable, defaults to null if not provided
      delivery: pet['delivery'] ?? false, // Defaults to false if not provided
      deliveryPrice: pet['deliveryPrice']?.toString() ?? '0',
    );
  }

  // Method to convert the object back to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petName': name,
      'gender': gender,
      'age': age,
      'location': location,
      'price': price,
      'primaryImageUrl': imageUrl,
      if (quantity != null) 'quantity': quantity, // Include only if non-null
      'delivery': delivery,
      'deliveryPrice': deliveryPrice,
    };
  }

  // Method to create a copy of the object with new values
  CartAnimalItem copyWith({
    String? id,
    String? name,
    String? gender,
    String? age,
    String? location,
    String? price,
    String? imageUrl,
    int? quantity,
    bool? delivery,
    String? deliveryPrice,
  }) {
    return CartAnimalItem(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      location: location ?? this.location,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      delivery: delivery ?? this.delivery,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
    );
  }
}

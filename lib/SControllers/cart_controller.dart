import 'package:get/get.dart';
import 'package:pet_kart/Models/cart_animal_item.dart';


class AnimalCartController extends GetxController {
  // Reactive map to store cart items
  var cartItems = <String, CartAnimalItem>{}.obs;

  var dicount=0;

  // Add an item to the cart
  void addToCart(CartAnimalItem item) {
    if (cartItems.containsKey(item.id)) {
      // Increment the quantity if the item already exists
      cartItems[item.id] = cartItems[item.id]!.copyWith(
        quantity: (cartItems[item.id]!.quantity ?? 0) + 1,
      );
    } else {
      // Add a new item with quantity set to 1
      cartItems[item.id] = item.copyWith(quantity: 1);
    }
  }

  // Remove an item from the cart
  void removeFromCart(String itemId) {
    cartItems.remove(itemId);
  }

  // Update item quantity
  void updateQuantity(String itemId, int quantity) {
    if (cartItems.containsKey(itemId) && quantity > 0) {
      cartItems[itemId]!.quantity = quantity;
      cartItems.refresh();
    } else {
      cartItems.remove(itemId);
    }
  }

int get totalPrice {
  return cartItems.values.fold(0, (sum, item) {
    int quantity = item.quantity ?? 1; // Default to 1 if quantity is null
    return sum + (int.parse(item.price) * quantity);
  });
}
  int get totalDeliveryPrice {
    return cartItems.values.fold(0, (sum, item) {
      int quantity = item.quantity ?? 1; // Default to 1 if quantity is null
      return sum + (int.parse(item.deliveryPrice) * quantity);
    });
  }
// Get total items count
int get totalItems {
  return cartItems.values.fold(0, (sum, item) {
    int quantity = item.quantity ?? 1; // Default to 1 if quantity is null
    return sum + quantity;
  });
}
}

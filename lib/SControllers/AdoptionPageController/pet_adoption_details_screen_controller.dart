import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class PetAdoptionDetailsScreenController extends GetxController {
  PageController pageController = PageController();
  List<ImageProvider> cachedImageProviders = [];

  // Define image URLs
  List<String> getPetImageUrls() {
    return [
      'https://images.pexels.com/photos/1170986/pexels-photo-1170986.jpeg',
      'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg',
      'https://images.pexels.com/photos/1108098/pexels-photo-1108098.jpeg',
    ];
  }
  List<String> imageUrls=[];
  @override
  void onInit() {
    super.onInit();

    // Pre-cache and store the images as ImageProviders
    imageUrls= getPetImageUrls();
    for (var url in imageUrls) {
      ImageProvider imageProvider = CachedNetworkImageProvider(url);
      cachedImageProviders.add(imageProvider);

      // Precache the image
      precacheImage(imageProvider, Get.context!);
    }
  }

  @override
  void onClose() {
    // Dispose of cached images when the screen is closed
    for (var imageProvider in cachedImageProviders) {
      imageProvider.evict();
    }

    pageController.dispose();
    super.onClose();
  }
}

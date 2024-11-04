import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Models/community_model.dart';

class CommunitySearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  var searchResults = <CommunityModel>[].obs;
  var filteredCommunities = <CommunityModel>[].obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void filterSearch() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredCommunities.assignAll(searchResults);
    } else {
      filteredCommunities.assignAll(
        searchResults.where((community) {
          return community.name.toLowerCase().contains(query) ||
              (community.shortDescription?.toLowerCase().contains(query) ?? false);
        }).toList(),
      );
    }
  }
}

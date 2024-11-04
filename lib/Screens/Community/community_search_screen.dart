import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_kart/Models/community_model.dart';

import '../../SControllers/CommunityController/community_search_controller.dart';

class CommunitySearchScreen extends StatelessWidget {
  const CommunitySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunitySearchController controller = Get.put(CommunitySearchController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Community Search"),
        backgroundColor: Get.theme.colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: controller.searchController,
              onChanged: (value) {
                controller.filterSearch();
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.pinkAccent),
                ),
              ),
            ),
            const Gap(20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('community').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No communities available"));
                  }

                  controller.searchResults.value = snapshot.data!.docs.map((doc) {
                    return CommunityModel.fromFirestore(doc);
                  }).toList();

                  controller.filterSearch();

                  return Obx(
                        () => controller.filteredCommunities.isEmpty
                        ? const Center(child: Text("No results found"))
                        : ListView.builder(
                      itemCount: controller.filteredCommunities.length,
                      itemBuilder: (context, index) {
                        final community = controller.filteredCommunities[index];
                        return GestureDetector(
                          onTap: () => Get.toNamed(
                            "/community_search_home_screen",
                            arguments: community,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.pinkAccent),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          community.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.pinkAccent,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.yellow),
                                            Text(
                                              "${community.rating} (${community.members.length} Members)",
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        if (community.shortDescription != null) ...[
                                          const SizedBox(height: 5),
                                          Text(
                                            community.shortDescription!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, size: 40, color: Colors.pinkAccent),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

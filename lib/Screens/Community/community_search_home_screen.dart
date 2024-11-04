import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

import '../../Models/post_model.dart';
import '../../SControllers/CommunityController/community_search_home_controller.dart';

class CommunitySearchHomeScreen extends StatelessWidget {
  const CommunitySearchHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunitySearchHomeController controller = Get.put(CommunitySearchHomeController());

    Color primary = Get.theme.colorScheme.primary;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pet Information"),
          backgroundColor: primary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use Obx only for the elements that depend on observable properties
          Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: primary),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.community.name, // Accessing the observable value
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          Obx(() => Text(
                            "${controller.community.rating} (${controller.members.length} Members)",
                            style: const TextStyle(fontSize: 14),
                          )),
                        ],
                      ),
                      const Gap(10),
                      ElevatedButton(
                        onPressed: () {
                          controller.joinCommunity();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: primary,
                          side: BorderSide(color: primary),
                        ),
                        child: const Text("Join Community"),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              // Tab Bar for About and Feed
              TabBar(
                labelColor: primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: primary,
                tabs: const [
                  Tab(text: "About Community"),
                  Tab(text: "Feed"),
                ],
              ),
              const Gap(10),
              // Tab Bar View
              Expanded(
                child: TabBarView(
                  children: [

                    SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            "Welcome to ${controller.community.name} Community",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Gap(10),
                           Text(
                            controller.community.description ?? "",
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                          const Gap(20),
                          // Sample Images Grid
                           GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: controller.community.imagesCount ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Image.network(controller.community.imageUrls![index]); // Accessing the observable value
                            },
                          ),
                        ],
                      ),
                    ),
                    // Feed Tab (Can be customized further)
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("community").doc(controller.community.id)
              .collection('posts') // Change this to your posts collection path
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No posts available"));
            }

            // Map the documents to a list of PostWidgets
            List<Widget> postWidgets = snapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              var post = PostModel.fromMap(data); // Assuming you have a `fromMap` constructor in PostModel
              print(1);
              return postWidget(post, controller); // Pass the post to postWidget
            }).toList();

            return Column(
              children: postWidgets,
            );
          },
        )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget postWidget(PostModel post, CommunitySearchHomeController controller) {
    return Container(
      height: 290,
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(
            color: Get.theme.colorScheme.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(post.community),
          Divider(
            color: Get.theme.colorScheme.primary,
            thickness: 2,
          ),
          const Gap(3),
          Row(
            children: [
              const Gap(5),
              CircleAvatar(
                radius: 20,
                child: CachedNetworkImage(
                  //TODO:user url
                  imageUrl: "https://example.com/path/to/your/image.jpg",
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const SizedBox(
                      child: Icon(Icons.person,size: 25,)),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 30,
                    backgroundImage: imageProvider,
                  ),
                ),
              ),
              const Gap(10),
              RichText(
                text:  TextSpan(
                  text: post.owner+'\n',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: controller.formatDateTime(post.date),
                        style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 12)),
                  ],
                ),
              ),
              // Gap(Get.width - 260),
              // Obx(
              //   () => IconButton(
              //       padding: EdgeInsets.zero,
              //       constraints: const BoxConstraints(maxWidth: 10),
              //       icon: Icon(
              //         communityPageController.tempLikeToggle.value
              //             ? Icons.heart_broken
              //             : Icons.heart_broken_outlined,
              //         color: Colors.red,
              //         size: 30,
              //       ),
              //       onPressed: () => communityPageController.likeToggle()),
              // ),
              // const Text("5k")
            ],
          ),
          const Gap(6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                post.content+'sadf ',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                maxLines: 9,
                softWrap: true,
              ),
            ),
          )

        ],
      ),
    );
  }
}

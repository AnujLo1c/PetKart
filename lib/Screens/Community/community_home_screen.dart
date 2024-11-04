import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import '../../Models/post_model.dart';
import '../../SControllers/CommunityController/community_home_controller.dart';


class CommunityHomeScreen extends StatelessWidget {
  const CommunityHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunityHomeController controller = Get.put(CommunityHomeController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pet Information"),
          backgroundColor: Get.theme.colorScheme.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

                 Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.pinkAccent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.community.name,
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
                              "${controller.community.rating ?? 0} (${controller.community.members.length} Members)",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Text(
                          controller.community.shortDescription ?? "No description available",
                          style: const TextStyle(fontSize: 12),
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              ,
              const Gap(10),
              TabBar(
                labelColor: Colors.pinkAccent,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.pinkAccent,
                tabs: const [
                  Tab(text: "About Community"),
                  Tab(text: "Feed"),
                ],
              ),
              const Gap(10),
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
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.community.imageUrls?.length ?? 0,
                            itemBuilder: (context, index) => Image.network(
                              controller.community.imageUrls?[index] ?? 'fallback_image_url',
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget postWidget(PostModel post, CommunityHomeController controller) {
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

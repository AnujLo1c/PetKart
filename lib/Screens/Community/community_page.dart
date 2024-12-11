import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';
import 'package:pet_kart/SControllers/CommunityController/community_page_controller.dart';

import '../../Models/community_model.dart';
import '../../Models/post_model.dart';
import '../../SControllers/persistent_data_controller.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});
  @override
  Widget build(BuildContext context) {
    CommunityPageController communityPageController =
        Get.put(CommunityPageController());

    List<Widget> pagesList = [myFeed(communityPageController), myCommunity(communityPageController)];
    return Column(
      children: [
        const Gap(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("/community_search_screen");

                }, child: const Text("Search Community")),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("/community_create_screen");
                }, child: const Text("Create Community"))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  communityPageController.myFeedToggle();
                },
                child: const Text("My feed", style: TextStyle(fontSize: 20))),
            TextButton(
                onPressed: () {
                  communityPageController.myFeedToggle();
                },
                child: const Text("My communities",
                    style: TextStyle(fontSize: 20))),
          ],
        ),
        Obx(
          () => Divider(
            color: Get.theme.colorScheme.primary,
            thickness: 3,
            height: 0,
            indent: communityPageController.onMyFeed.value ? 50 : 180,
            endIndent: communityPageController.onMyFeed.value ? 250 : 50,
          ),
        ),
        const Gap(10),
        Obx(() => Flexible(
            child: pagesList[communityPageController.onMyFeed.value ? 0 : 1]))
      ],
    );
  }

  postingWidget(CommunityPageController communityPageController) {
    PersistentDataController persistentDataController=Get.find<PersistentDataController>();
    return Container(
      padding: const EdgeInsets.only(right: 5, top: 3, bottom: 3, left: 10),
      height: communityPageController.postBoxBool.value ? 250 : 65,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Get.theme.colorScheme.primary, width: 1)),
      child: Column(
        children: [
          const Gap(5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20, 
                child: CachedNetworkImage(
                  //TODO:user url
                  imageUrl: "https://example.com/path/to/your/image.jpg", 
                  placeholder: (context, url) => const SizedBox(

                      child: Icon(Icons.person,size: 25,)),
                  errorWidget: (context, url, error) => const SizedBox(

                      child: Icon(Icons.person,size: 25,)),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 30,
                    backgroundImage: imageProvider,
                  ),
                ),
              ),

              const Gap(6),
              communityPageController.postBoxBool.value
                  ? SizedBox(
                      height: 40,
                      width: Get.width-100,
                      child: Row(
                        children: [
                           Text(
                            persistentDataController.userName.value ,
                            style: const TextStyle(
                              fontSize: 16, // Adjust font size
                              fontWeight: FontWeight.bold, // Make the text bold
                              color: Colors.black, // Set text color
                            ),
                          ),
                          // Gap(Get.width -260),
Spacer(),                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.black),
                            onPressed: () {
                              communityPageController.postingToggle();
                            },
                          )
                        ],
                      ))
                  : TextButton(
                      onPressed: () {
                        communityPageController.postingToggle();
                      },
                      style: TextButton.styleFrom(

                          minimumSize: Size(Get.width - 99, 40),
                          alignment: AlignmentDirectional.centerStart,
                          splashFactory: NoSplash.splashFactory),
                      child: const Text(
                        "Write your post here",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
            ],
          ),
          if (communityPageController.postBoxBool.value)
            Column(
              children: [
                TextField(
                  controller: communityPageController.postController,
                  // focusNode: communityPageController.postFocusNode,
                  maxLines: 6,
                  minLines: 6,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                      hintText: "Start Writting..",
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.symmetric(vertical: 10)),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        String? selectedCommunity = await showCommunityDialog(); // Get the selected community
                        if (selectedCommunity != null) { // Check if it's not null
                          communityPageController.communityName.value = selectedCommunity; // Correctly assign to RxString
                          print(communityPageController.communityName.value); // Print the updated value
                        }
                        print(communityPageController.communityName.value);
                      },
                      child:  Row(
                        children: [
                          const Icon(
                            Icons.ac_unit,
                            color: Colors.grey,
                          ),
                          Obx(()=> Text( communityPageController.communityName.value.isEmpty?"Add your post in ".toString():
                          communityPageController.communityName.value.toString())),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          bool b=await communityPageController.uploadPost();
                        if(b){
                          communityPageController.postingToggle();
                        }
                          },
                        style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10)),
                        child: const Text("Publish Post")),
                    const Gap(10)
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget postWidget(PostModel post, CommunityPageController communityPageController) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Gap(10),
              Text( "posted on ",style: TextStyle(fontSize: 12),),
             GestureDetector(
                 onTap: () {

                 },
                 child: Text(post.community,style: TextStyle(color: Get.theme.colorScheme.primary),))
            ],
          ),

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
            placeholder: (context, url) => const SizedBox(
                child: Icon(Icons.person,size: 25,)),
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
                        text: communityPageController.formatDateTime(post.date),
                        style: const TextStyle(fontWeight: FontWeight.w300)),
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
            child: Text(
              post.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 9,
              softWrap: false,
              textAlign: TextAlign.left, // Ensures text is aligned to the left
            ),
          )

        ],
      ),
    );
  }

  Widget myFeed(CommunityPageController communityPageController) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Obx(() => postingWidget(communityPageController)),
          Divider(
            color: Get.theme.colorScheme.primary,
            thickness: 4,
            height: 20,
            indent: 40,
            endIndent: 40,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("users").doc(EmailPassLoginAl().getEmail())
                  .collection('feed') // Change this to your posts collection path
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
                  var post = PostModel.fromMap(data);

                  return postWidget(post, communityPageController); // Pass the post to postWidget
                }).toList();

                return Column(
                  children: postWidgets,
                );
              },
            ),

        ],
      ),
    );
  }

  Widget myCommunity(CommunityPageController communityPageController) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(EmailPassLoginAl().getEmail()).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading spinner while waiting
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No communities found.")); // No user data
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          List<String> communityIds = List<String>.from(userData['joinedCommunities'] ?? []);

          if (communityIds.isEmpty) {
            return const Center(child: Text("You haven't joined any communities.")); // No communities joined
          }

          // Build a list of community tiles based on the user's joined communities
          return FutureBuilder<List<CommunityModel>>(
            future: communityPageController.fetchCommunitiesByIds(communityIds),
            builder: (context, communitySnapshot) {
              if (communitySnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Show loading spinner while fetching communities
              }

              if (!communitySnapshot.hasData || communitySnapshot.data!.isEmpty) {
                return const Center(child: Text("No communities found.")); // No communities found for the IDs
              }

              // Return the ListView of CommunityTiles
              return ListView.builder(
                itemCount: communitySnapshot.data!.length,
                itemBuilder: (context, index) {
                  final community = communitySnapshot.data![index];
                  return CommunityTile(
                    community: community,

                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class CommunityTile extends StatelessWidget {

final CommunityModel community;
  const CommunityTile({super.key, required this.community,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed("/community_home_screen",arguments: community),
      child: Card(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Community Name
              Text(
                community.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 8),
              // Rating and Members
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: 4),
                  Text(
                    "${community.rating} (${community.members.length} Members)",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // View Community Button
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.redAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('View Community'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Future<String?> showCommunityDialog() async {
  // Retrieve the email for fetching communities
  String email = EmailPassLoginAl().getEmail();

  // Show the dialog and wait for a result
  return await Get.dialog<String>(
    AlertDialog(
      title: const Text('Select a Community'),
      content: SizedBox(
        height: 300,
        width: double.maxFinite, // Make the dialog width flexible
        child: FutureBuilder<List<String>>(
          future: fetchCommunities(email), // Call the fetch function
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Loading indicator
            } else if (snapshot.hasError) {
              // Error handling
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No communities available.')); // No data handling
            }

            // Extract the communities data
            final communities = snapshot.data!;
            return ListView.builder(
              itemCount: communities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(communities[index]),
                  onTap: () {
                    // Close the dialog and return the selected community
                    Get.back(result: communities[index]);
                  },
                );
              },
            );
          },
        ),
      ),
    ),
  );
}


Future<List<String>> fetchCommunities(String email) async {
  var temp = await FirebaseFirestore.instance.collection("users").doc(email).get();

  // Assuming "joinedCommunities" is a list of strings.
  // You may need to adapt this if the structure is different.
  List<dynamic>? joinedCommunities = temp.data()?["joinedCommunities"];

  // Convert the dynamic list to List<String>
  return joinedCommunities?.cast<String>() ?? []; // Returns an empty list if null
}

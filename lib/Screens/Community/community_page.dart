import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/CommunityController/community_page_controller.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});
  @override
  Widget build(BuildContext context) {
    CommunityPageController communityPageController =
        Get.put(CommunityPageController());

  List<Widget> pagesList=[myFeed(communityPageController),myCommunity()];
    return Column(
      children: [
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {communityPageController.myFeedToggle();},
                child: const Text("My feed", style: TextStyle(fontSize: 20))),
            TextButton(
                onPressed: () {communityPageController.myFeedToggle();},
                child: const Text("My communities",
                    style: TextStyle(fontSize: 20))),
          ],
        ),
         Obx(()=>
             Divider(
              color: Get.theme.colorScheme.primary,
              thickness: 3,
              height: 0,
              indent: communityPageController.onMyFeed.value?50:180,
              endIndent: communityPageController.onMyFeed.value?250:50,
            ),
),
                 const Gap(10),
        Obx(()=>Flexible(child: pagesList[communityPageController.onMyFeed.value?0:1]))
      ],
    );
  }

  postingWidget(CommunityPageController communityPageController) {
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
              const CircleAvatar(
                child: Image(
                  image: AssetImage(
                    "assets/picture/welcome.png",
                  ),
                  width: 35,
                ),
              ),
              const Gap(6),
              communityPageController.postBoxBool.value
                  ? SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          const Text(
                            "Nandini Dhote",
                            style: TextStyle(
                              fontSize: 16, // Adjust font size
                              fontWeight: FontWeight.bold, // Make the text bold
                              color: Colors.black, // Set text color
                            ),
                          ),
                          Gap(Get.width - 250),
                          IconButton(
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
                          // backgroundColor: Colors.black,
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
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.ac_unit,
                            color: Colors.grey,
                          ),
                          Text("Add your post in "),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {},
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

  postWidget(CommunityPageController communityPageController) {
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
          const Text("Post"),
          Divider(
            color: Get.theme.colorScheme.primary,
            thickness: 2,
          ),
          const Gap(3),
          Row(
            children: [
              const Gap(5),
              const CircleAvatar(
                child: Image(
                  image: AssetImage(
                    "assets/picture/welcome.png",
                  ),
                  width: 35,
                ),
              ),
              const Gap(10),
              RichText(
                text: const TextSpan(
                  text: 'Anuj Lowanshi\n',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Indore, India',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
              Gap(Get.width-260),
              Obx(()=>
                 IconButton(
                  padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(maxWidth: 10),
                    icon:Icon( communityPageController.tempLikeToggle.value?Icons.heart_broken:Icons.heart_broken_outlined,color: Colors.red,size: 30,),
                  onPressed: ()=> communityPageController.likeToggle()),
              ),
              const Text("5k")
            ],
          ),
          const Gap(6),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "sadfas fasfdsafdsfa dffdf flf fjkdsaj ffj dsajfksad fkdsajfk sajfkj safkjdsakfjsakfjasfkldsajfk jaskfjsal fjsadklfj;asfj sadkljf askfjsadklfjsal;fjasfjsakldjf sadklfjsadkljf sakjfkls j;sadklfj sajf sajfkj safkjdsakfjsakfjasfkldsajfk jaskfjsal fjsadklfj;asfj sadkljf askfjsadklfjsal;fjasfjsakldjf sadklfjsadkljf sakjfkls j;sadklfj sajf sajfkj safkjdsakfjsakfjasfkldsajfk jaskfjsal fjsadklfj;asfj sadkljf askfjsadklfjsal;fjasfjsakldjf sadklfjsadkljf sakjfkls j;sadklfj sajf",
              overflow: TextOverflow.ellipsis,
              maxLines: 9,
              softWrap: false,
            ),
          )
        ],
      ),
    );
  }


Widget myFeed(CommunityPageController communityPageController){
    return  Column(
      children: [
        Obx(() => postingWidget(communityPageController)),
        Divider(
          color: Get.theme.colorScheme.primary,
          thickness: 4,
          height: 20,
          indent: 40,
          endIndent: 40,
        ),
        Expanded(
          child: ListView(
            
            children: [
              postWidget(communityPageController),
              const Gap(10),
              postWidget(communityPageController),
              const Gap(10),
              postWidget(communityPageController),
              Gap(20)
            ],
          ),
        ),
      ],
    );
}

Widget myCommunity(){
    return Container(
      height: 100,
      width: 100,
      color: Colors.black,
    );
}
}

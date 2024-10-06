import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/HomeController/home_page_controller.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.put(HomePageController());
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            homeCarousel(homePageController),
            Column(
              children: [
                Gap(5),
                title("Pets"),
                const Gap(10),
                SizedBox(
                  height: 105,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Gap(15),
                        petContainer("assets/picture/puppy.png", "Dogs"),
                        const Gap(10),
                        petContainer("assets/picture/cat.png", "Cats"),
                        const Gap(10),
                        petContainer("assets/picture/fish.png", "Fish"),
                        const Gap(10),
                        petContainer("assets/picture/mammal.png", "Mammals"),
                        const Gap(10),
                        petContainer("assets/picture/birds.png", "birds"),
                        const Gap(10),
                      ]
                  ),
                ),
                const Gap(15),
                title("Food & Accessories"),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 163,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Get.theme.colorScheme.primary,
                              width: 1
                          ),
                          image: DecorationImage(
                            image: AssetImage("assets/picture/petFood.png"),
                            fit: BoxFit.fitWidth,)
                      ),
                    ),
                    Container(
                      height: 163,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Get.theme.colorScheme.primary,
                              width: 1
                          ),
                          image: const DecorationImage(
                            image: AssetImage("assets/picture/acessories.png"),
                            fit: BoxFit.fill,)
                      ),
                    ),
      
                    const Gap(5)
                  ],
                ),
                title("Adoption"),
                adoptionCarousel(homePageController),
      
      
              ],
            )
      
          ]),
    );
  }

  adoptionCarousel(HomePageController homePageController) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: GestureDetector(

           onTap: (){
             //TODO: implement page shifting to adoption
           },
            child: CarouselSlider(
              items: [
                //TODO:implement add and ontap nav to adoption process
              ],
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: false,
                height: 140.0,
                // onPageChanged: (index, reason) {
                //   homePageController.updateIndex(index);
                // },
              ),

            ),
          ),
        ),

      ],
    );
  }
}
  homeCarousel(HomePageController homePageController) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: CarouselSlider(
            items: homePageController.imgList.map((item) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              height: 140.0,
              onPageChanged: (index, reason) {
                homePageController.updateIndex(index);
              },
            ),
          ),
        ),

        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: homePageController.imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => Get.find<HomePageController>().updateIndex(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Get.theme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(homePageController.currentIndexCarou.value == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

petContainer(String imgsrc, String text) {
  return Container(
    width: 100,

    height: 100,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Get.theme.colorScheme.primary,
            width: 1
        )
    ),
    child: Column(
      children: [

        Padding(
            padding: const EdgeInsets.all(3),
            child: Image(image: AssetImage(imgsrc))
        ),
        Text(text,style: const TextStyle(
          fontWeight: FontWeight.bold
        ),)
      ],
    ),
  );
}

title(String text){
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(text,
        style: TextStyle(
            color: Get.theme.colorScheme.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
      ),
    ),
  );
}
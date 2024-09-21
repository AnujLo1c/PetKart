import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/google_sign_in.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(20),
                  Center(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 150,
                        width: 150,
                        imageUrl: "",
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: Get.theme.colorScheme.primary,
                          radius: 100,
                          child: const Icon(
                            Icons.person,
                            size: 90,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Text("Anuj", style: const TextStyle(fontSize: 24)),
                  const Gap(20),
                  Column(
                    children: [
                      profileTile("Booking Status",
                              () {},
                          Icons.bookmark_add_outlined),
                      profileTile("Favourite",
                              () {},
                          Icons.history),
                      profileTile("Help",
                              () {},
                          Icons.help_outline),
                      profileTile("Settings",
                              () {},
                          Icons.settings),
                      profileTile("Log Out", () {
                        GoogleSignInAL().signOutGoogle();
                      }, Icons.logout),
                    ],
                  ),
                ],
              ),

    );
  }
  Widget profileTile(String text, dynamic onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height / 16,
        width: Get.width,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
            color: Get.theme.colorScheme.secondary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.white
            ),
            boxShadow: [
              BoxShadow(
                  color: Get.theme.colorScheme.shadow
                  ,
                  blurRadius: 5,
                  spreadRadius: 3),
            ]),
        child: Row(
          children: [
            const Gap(10),
            Icon(icon),
            const Gap(10),
            Text(text),
            const Spacer(),
            const Icon(Icons.chevron_right),
            const Gap(10)
          ],
        ),
      ),
    );
  }
}
  import 'package:cached_network_image/cached_network_image.dart';
  import 'package:flutter/material.dart';
  import 'package:gap/gap.dart';
  import 'package:get/get.dart';
  import 'package:pet_kart/Firebase/FirebaseAuth/google_sign_in.dart';
  import 'package:pet_kart/SControllers/ProfileController/profile_page_controller.dart';
  class ProfilePage extends StatelessWidget {
    const ProfilePage({super.key});
  
    @override
    Widget build(BuildContext context) {
      ProfilePageController profilePageController=Get.put(ProfilePageController());
      return SimpleBuilder(
  
        builder: (p0) => SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
                      Center(
                        child: ClipOval(
                          child: Obx(()=>
                            CachedNetworkImage(
                              fit: BoxFit.fill,
                              height: 150,
                              width: 150,
                              imageUrl: profilePageController.profileurl.value,
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
                      ),
                      // Container(color: Get.theme.colorScheme.primary,height: 100,width: 100,),
                      const Gap(10),
                      Obx(()=> Text(profilePageController.name.value, style: const TextStyle(fontSize: 24))),
                      const Gap(20),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     uploadGuineaPigData();
                      //   },
                      //   child: Text("Upload Dog Data"),
                      // ),
  
                      Column(
                        children: [
                          profileTile("Booking Status",
                                  () {
                            Get.toNamed("/booking_status");
                                  },
                              Icons.bookmark_add_outlined),
                          profileTile("History",
                                  () {
                            Get.toNamed("/history");
                                  },
                              Icons.history),
                          profileTile("Help",
                                  () {
                            Get.toNamed("/help");
                                  },
                              Icons.help_outline),
                          profileTile("Settings",
                                  () {
                            Get.offNamed("/settings",arguments: profilePageController.uid);
                                  },
                              Icons.settings),
                          profileTile("Log Out", () {
                            GoogleSignInAL().signOutGoogle();
                            Get.offAllNamed('/login_signup_screen');
  
                          }, Icons.logout),
                        ],
                      ),
                    ],
                  ),
  
        ),
      );
    }
    Widget profileTile(String text, dynamic onTap, IconData icon) {
      Color onPrimary= Get.theme.colorScheme.onPrimary;
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
              border: Border.all(width: 2, color: Get.theme.colorScheme.onPrimary
              ),
              boxShadow: [
                BoxShadow(
                    color: Get.theme.colorScheme.shadow,
                    blurRadius: 5,
                    spreadRadius: 3),
              ]),
          child: Row(
            children: [
              const Gap(10),
              Icon(icon,color: onPrimary,),
              const Gap(10),
              Text(text,style: TextStyle(color: onPrimary),),
              const Spacer(),
              Icon(Icons.chevron_right,color: onPrimary,),
              const Gap(10)
            ],
          ),
        ),
      );
    }
  }
  
  // void uploadGuineaPigData() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   // Guinea Pig Data
  //   List<Map<String, dynamic>> guineaPigData = [
  //     {
  //       'name': 'Abyssinian Guinea Pig',
  //       'alternateNames': ['Rosette Guinea Pig'],
  //       'origin': 'South America',
  //       'colors': [
  //         'Wide range including brown, black, white, and mixed colors, often with "rosettes" or swirls in their fur'
  //       ],
  //       'height': '8-12 inches (20-30 cm)',
  //       'weight': '0.7-1.2 kg (700-1200 grams)',
  //       'exerciseNeeds': 'Moderate to high; enjoys exploring and needs daily playtime outside the cage',
  //       'training': 'Can be trained for basic behaviors, like litter box usage and coming for food; enjoys socializing with humans',
  //       'grooming': 'Requires more grooming due to its rough-textured coat with swirls; weekly brushing helps prevent matting',
  //       'health': 'Similar to other guinea pigs, prone to dental issues, vitamin C deficiency, and skin problems if not groomed properly; a balanced diet is essential'
  //     },
  //     {
  //       'name': 'Teddy Guinea Pig',
  //       'alternateNames': [],
  //       'origin': 'South America (a variation of the American breed)',
  //       'colors': ['Commonly found in brown, white, black, and multi-color'],
  //       'height': '8-10 inches (20-25 cm)',
  //       'weight': '0.7-1.2 kg (700-1200 grams)',
  //       'exerciseNeeds': 'Moderate; requires daily playtime and room to explore',
  //       'training': 'Can be litter trained and will respond to food sounds; enjoys gentle handling',
  //       'grooming': 'Medium maintenance; its dense, wiry coat needs brushing a few times a week',
  //       'health': 'Generally healthy but prone to dental problems and skin conditions; a proper diet with plenty of vitamin C is necessary'
  //     }
  //   ];
  //
  //   // Upload data to Firestore
  //   CollectionReference guineaPigCollection = firestore.collection('rabbits_info');
  //
  //   for (var guineaPig in guineaPigData) {
  //     String documentId = guineaPig['name'].toLowerCase().replaceAll(' ', '_');
  //     await guineaPigCollection.doc(documentId).set(guineaPig).then((value) {
  //       print('Guinea pig data uploaded successfully!');
  //     }).catchError((error) {
  //       print('Failed to upload guinea pig data: $error');
  //     });
  //   }
  // }
  //
  // void uploadHamsterData() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   // Hamster Data
  //   List<Map<String, dynamic>> hamsterData = [
  //     {
  //       'name': 'Syrian Hamster',
  //       'alternateNames': ['Golden Hamster', 'Teddy Bear Hamster'],
  //       'origin': 'Syria',
  //       'colors': ['Golden', 'Cream', 'Black', 'White', 'Sable', 'More'],
  //       'height': '4-7 inches (10-18 cm)',
  //       'weight': '120-150 grams',
  //       'exerciseNeeds': 'High; requires a large cage and a running wheel for daily exercise',
  //       'training': 'Can be tamed with regular handling but not easily trained for tricks',
  //       'grooming': 'Short-haired varieties need minimal grooming, while long-haired types need occasional brushing',
  //       'health': 'Prone to respiratory infections, obesity, and overgrown teeth; needs a clean, stress-free environment'
  //     },
  //     {
  //       'name': 'Dwarf Winter White Russian Hamster',
  //       'alternateNames': ['Winter White Hamster', 'Djungarian Hamster'],
  //       'origin': 'Siberia, Kazakhstan',
  //       'colors': ['Gray-brown in summer', 'White in winter (though color change may not occur in captivity)'],
  //       'height': '3-4 inches (8-10 cm)',
  //       'weight': '30-45 grams',
  //       'exerciseNeeds': 'Moderate; enjoys running wheels and tunnels',
  //       'training': 'Can be trained to be friendly with regular handling',
  //       'grooming': 'Minimal; usually self-sufficient with grooming',
  //       'health': 'Prone to diabetes and obesity; requires a balanced, low-sugar diet'
  //     },
  //     {
  //       'name': 'Roborovski Dwarf Hamster',
  //       'alternateNames': ['Robo Hamster'],
  //       'origin': 'Central Asia (Mongolia, Northern China)',
  //       'colors': ['Sandy brown with white underbelly'],
  //       'height': '2-3 inches (5-7 cm)',
  //       'weight': '20-30 grams',
  //       'exerciseNeeds': 'High; very active, needs space to run and explore, including wheels and tunnels',
  //       'training': 'Difficult to tame and handle due to their fast and skittish nature',
  //       'grooming': 'Minimal; requires very little grooming',
  //       'health': 'Generally healthy but may develop respiratory issues and obesity if improperly cared for'
  //     },
  //     {
  //       'name': 'Hybrid Dwarf Hamster',
  //       'alternateNames': [],
  //       'origin': 'Crossbreed of Campbell’s and Winter White Russian hamsters',
  //       'colors': ['Various shades of gray, brown, and white'],
  //       'height': '3-4 inches (8-10 cm)',
  //       'weight': '30-45 grams',
  //       'exerciseNeeds': 'Moderate; needs a wheel and space to explore',
  //       'training': 'Can be socialized with gentle, regular handling',
  //       'grooming': 'Minimal; does not require additional grooming',
  //       'health': 'Prone to diabetes, especially due to their hybrid nature; requires special attention to diet'
  //     }
  //   ];
  //
  //   // Upload data to Firestore
  //   CollectionReference hamsterCollection = firestore.collection('rabbits_info');
  //
  //   for (var hamster in hamsterData) {
  //     String documentId = hamster['name'].toLowerCase().replaceAll(' ', '_');
  //     await hamsterCollection.doc(documentId).set(hamster).then((value) {
  //       print('Hamster data uploaded successfully!');
  //     }).catchError((error) {
  //       print('Failed to upload hamster data: $error');
  //     });
  //   }
  // }
  
  
  // List<BirdBreed> birdBreeds = [
  //   BirdBreed(
  //       name: 'Cockatiel',
  //       alternateNames: ['Nymphicus Hollandicus'],
  //       origin: 'Australia',
  //       colors: ['Grey', 'White', 'Yellow', 'Orange (varieties include lutino and pied)'],
  //       heightMin: 12,
  //       heightMax: 14,
  //       weightMin: 2.5,
  //       weightMax: 4,
  //       exerciseNeeds: 'Moderate; needs time outside the cage to fly and explore.',
  //       training: 'Highly trainable; can learn to whistle tunes and perform tricks.',
  //       grooming: 'Requires regular bathing; keep feathers clean; beak and nails may need trimming.',
  //       health: 'Prone to respiratory issues and feather plucking.'
  //   ),
  //   BirdBreed(
  //       name: 'Budgerigar (Budgie)',
  //       alternateNames: ['Parakeet'],
  //       origin: 'Australia',
  //       colors: ['Green', 'Yellow', 'Blue', 'White (varieties include English and American)'],
  //       heightMin: 7,
  //       heightMax: 8,
  //       weightMin: 1,
  //       weightMax: 1.5,
  //       exerciseNeeds: 'Moderate; needs plenty of space to fly and play.',
  //       training: 'Intelligent and easily trained; can learn to talk and perform tricks.',
  //       grooming: 'Regular cage cleaning; provides cuttlebone for beak health.',
  //       health: 'Susceptible to respiratory infections and obesity.'
  //   ),
  //   BirdBreed(
  //       name: 'African Grey Parrot',
  //       alternateNames: ['Congo African Grey'],
  //       origin: 'Central Africa',
  //       colors: ['Grey with red tail feathers'],
  //       heightMin: 12,
  //       heightMax: 14,
  //       weightMin: 12,
  //       weightMax: 18,
  //       exerciseNeeds: 'High; requires daily out-of-cage time and mental stimulation.',
  //       training: 'Highly intelligent; excellent at mimicry and learning complex commands.',
  //       grooming: 'Requires regular feather care; beak and nail trimming may be necessary.',
  //       health: 'Prone to feather plucking and nutritional deficiencies.'
  //   ),
  //   BirdBreed(
  //       name: 'Canary',
  //       alternateNames: ['Serinus canaria'],
  //       origin: 'Canary Islands, Azores, Madeira',
  //       colors: ['Yellow', 'Orange', 'Red', 'White', 'Brown (varieties include Gloster and Border)'],
  //       heightMin: 4,
  //       heightMax: 5,
  //       weightMin: 0.9,
  //       weightMax: 1.2,
  //       exerciseNeeds: 'Low; needs a spacious cage and occasional time outside to fly.',
  //       training: 'Limited training; primarily kept for companionship and singing.',
  //       grooming: 'Minimal grooming needed; keep cage clean and provide fresh food.',
  //       health: 'Prone to respiratory issues and obesity.'
  //   ),
  //   BirdBreed(
  //       name: 'Lovebird',
  //       alternateNames: ['Agapornis'],
  //       origin: 'Africa',
  //       colors: ['Green', 'Yellow', 'Peach', 'Various mutations'],
  //       heightMin: 5,
  //       heightMax: 7,
  //       weightMin: 2,
  //       weightMax: 2.5,
  //       exerciseNeeds: 'Moderate; requires time outside the cage to interact and fly.',
  //       training: 'Can learn basic commands; social and enjoy human interaction.',
  //       grooming: 'Needs regular bathing; keep the cage clean; nails may need trimming.',
  //       health: 'Susceptible to respiratory infections and behavioral issues without companionship.'
  //   ),
  //   BirdBreed(
  //       name: 'Amazon Parrot',
  //       alternateNames: [],
  //       origin: 'Central and South America',
  //       colors: ['Green with various splashes of yellow, red, and blue'],
  //       heightMin: 10,
  //       heightMax: 18,
  //       weightMin: 10,
  //       weightMax: 30,
  //       exerciseNeeds: 'High; needs ample space and mental stimulation through toys.',
  //       training: 'Very intelligent; can learn to talk and perform tricks.',
  //       grooming: 'Requires regular bathing; watch for overgrown nails and beak.',
  //       health: 'Prone to obesity and feather plucking.'
  //   ),
  //   BirdBreed(
  //       name: 'Finch',
  //       alternateNames: [],
  //       origin: 'Worldwide (various species from different regions)',
  //       colors: ['Varies greatly; includes yellow, red, orange, brown, and black'],
  //       heightMin: 4,
  //       heightMax: 6,
  //       weightMin: 0.5,
  //       weightMax: 1,
  //       exerciseNeeds: 'Low; social birds that thrive in groups but require space to fly.',
  //       training: 'Limited; primarily kept for companionship and song.',
  //       grooming: 'Minimal; regular cage cleaning and fresh food are essential.',
  //       health: 'Susceptible to respiratory issues and stress.'
  //   ),
  //   BirdBreed(
  //       name: 'Pionus Parrot',
  //       alternateNames: [],
  //       origin: 'Central and South America',
  //       colors: ['Mostly green with blue and red accents'],
  //       heightMin: 9,
  //       heightMax: 10,
  //       weightMin: 8,
  //       weightMax: 12,
  //       exerciseNeeds: 'Moderate; requires time outside the cage to fly and socialize.',
  //       training: 'Intelligent and can learn some words and tricks.',
  //       grooming: 'Regular bathing and cage cleaning needed; beak trimming if necessary.',
  //       health: 'Prone to obesity and feather plucking if not stimulated.'
  //   ),
  //   BirdBreed(
  //       name: 'Macaw',
  //       alternateNames: [],
  //       origin: 'Central and South America',
  //       colors: ['Bright blue, yellow, green, red (varies by species)'],
  //       heightMin: 24,
  //       heightMax: 40,
  //       weightMin: 1,
  //       weightMax: 3.5,
  //       exerciseNeeds: 'Very high; needs ample space to fly and play.',
  //       training: 'Highly intelligent; can learn complex commands and mimic speech.',
  //       grooming: 'Requires regular feather care; beak and nails may need trimming.',
  //       health: 'Prone to obesity and various infections without proper care.'
  //   ),
  //   BirdBreed(
  //       name: 'Eurasian Collared-Dove',
  //       alternateNames: ['Eurasian Dove'],
  //       origin: 'Europe, Asia, and North Africa',
  //       colors: ['Pale grey with black crescent on the neck'],
  //       heightMin: 12,
  //       heightMax: 14,
  //       weightMin: 4,
  //       weightMax: 5,
  //       exerciseNeeds: 'Moderate; needs space to fly and room to explore.',
  //       training: 'Limited training; primarily kept for companionship.',
  //       grooming: 'Minimal; regular cage cleaning and fresh food are essential.',
  //       health: 'Prone to respiratory issues and stress.'
  //   ),
  // ];
  // Future<void> uploadBirdBreeds(List<BirdBreed> birdBreeds) async {
  //   // Get the Firestore instance
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   // Reference to the 'info_fish' collection (you can change this to 'info_birds' if needed)
  //   CollectionReference birdBreedsCollection = firestore.collection('birds_info');
  //
  //   for (var breed in birdBreeds) {
  //     // Create the document ID by converting multi-word name to underscore format
  //     String documentId = breed.name.toLowerCase().replaceAll(' ', '_');
  //
  //     // Create or update the document for each bird breed using documentId
  //     await birdBreedsCollection.doc(documentId).set({
  //       'name': breed.name,
  //       'alternateNames': breed.alternateNames,
  //       'origin': breed.origin,
  //       'colors': breed.colors,
  //       'heightMin': breed.heightMin,
  //       'heightMax': breed.heightMax,
  //       'weightMin': breed.weightMin,
  //       'weightMax': breed.weightMax,
  //       'exerciseNeeds': breed.exerciseNeeds,
  //       'training': breed.training,
  //       'grooming': breed.grooming,
  //       'health': breed.health,
  //     }).then((docRef) {
  //       print('Bird breed ${breed.name} uploaded with ID: $documentId');
  //     }).catchError((error) {
  //       print('Error uploading bird breed ${breed.name}: $error');
  //     });
  //   }
  // }
  // class BirdBreed {
  //   final String name;
  //   final List<String> alternateNames;
  //   final String origin;
  //   final List<String> colors;
  //   final int heightMin;
  //   final int heightMax;
  //   final double weightMin;
  //   final double weightMax;
  //   final String exerciseNeeds;
  //   final String training;
  //   final String grooming;
  //   final String health;
  //
  //   BirdBreed({
  //     required this.name,
  //     required this.alternateNames,
  //     required this.origin,
  //     required this.colors,
  //     required this.heightMin,
  //     required this.heightMax,
  //     required this.weightMin,
  //     required this.weightMax,
  //     required this.exerciseNeeds,
  //     required this.training,
  //     required this.grooming,
  //     required this.health,
  //   });
  //
  //   // Method to convert BirdBreed object to a Map for Firestore upload
  //   Map<String, dynamic> toMap() {
  //     return {
  //       'name': name,
  //       'alternateNames': alternateNames,
  //       'origin': origin,
  //       'colors': colors,
  //       'heightMin': heightMin,
  //       'heightMax': heightMax,
  //       'weightMin': weightMin,
  //       'weightMax': weightMax,
  //       'exerciseNeeds': exerciseNeeds,
  //       'training': training,
  //       'grooming': grooming,
  //       'health': health,
  //     };
  //   }
  //
  //   // Factory method to create BirdBreed object from a Map (e.g., from Firestore data)
  //   factory BirdBreed.fromMap(Map<String, dynamic> map) {
  //     return BirdBreed(
  //       name: map['name'],
  //       alternateNames: List<String>.from(map['alternateNames']),
  //       origin: map['origin'],
  //       colors: List<String>.from(map['colors']),
  //       heightMin: map['heightMin'],
  //       heightMax: map['heightMax'],
  //       weightMin: map['weightMin'],
  //       weightMax: map['weightMax'],
  //       exerciseNeeds: map['exerciseNeeds'],
  //       training: map['training'],
  //       grooming: map['grooming'],
  //       health: map['health'],
  //     );
  //   }
  // }
  
  // class FishBreed {
  //   final String name;
  //   final String alternateNames;
  //   final String origin;
  //   final String colors;
  //   final double heightMin;
  //   final double heightMax;
  //   final double weightMin;
  //   final double weightMax;
  //   final String exerciseNeeds;
  //   final String training;
  //   final String grooming;
  //   final String health;
  //
  //   FishBreed({
  //     required this.name,
  //     required this.alternateNames,
  //     required this.origin,
  //     required this.colors,
  //     required this.heightMin,
  //     required this.heightMax,
  //     required this.weightMin,
  //     required this.weightMax,
  //     required this.exerciseNeeds,
  //     required this.training,
  //     required this.grooming,
  //     required this.health,
  //   });
  // }
  //
  // List<FishBreed> fishBreeds = [
  //   FishBreed(
  //     name: 'Betta Fish',
  //     alternateNames: 'Siamese Fighting Fish',
  //     origin: 'Southeast Asia (Thailand, Cambodia, Laos)',
  //     colors: 'Various (red, blue, green, purple, yellow, etc.)',
  //     heightMin: 2.5,
  //     heightMax: 3,
  //     weightMin: 0.5,
  //     weightMax: 1,
  //     exerciseNeeds: 'Moderate; requires swimming space and enrichment.',
  //     training: 'Can be trained to perform tricks; responsive to interaction.',
  //     grooming: 'Regular tank maintenance is essential; clean water is crucial.',
  //     health: 'Prone to fin rot, ich, and stress-related diseases.',
  //   ),
  //   FishBreed(
  //     name: 'Goldfish',
  //     alternateNames: 'None',
  //     origin: 'China',
  //     colors: 'Orange, red, white, black, calico.',
  //     heightMin: 6,
  //     heightMax: 8,
  //     weightMin: 0.5,
  //     weightMax: 2,
  //     exerciseNeeds: 'Moderate; needs ample swimming space and tank mates.',
  //     training: 'Can be trained to recognize feeding times and perform simple tricks.',
  //     grooming: 'Regular water changes and tank cleaning; can be prone to algae.',
  //     health: 'Susceptible to swim bladder disease and fungal infections.',
  //   ),
  //   FishBreed(
  //     name: 'Neon Tetra',
  //     alternateNames: 'None',
  //     origin: 'South America (Amazon Basin)',
  //     colors: 'Blue body with a red stripe.',
  //     heightMin: 1.5,
  //     heightMax: 1.5,
  //     weightMin: 0.1,
  //     weightMax: 0.1,
  //     exerciseNeeds: 'Low; prefers schooling in groups.',
  //     training: 'Minimal; not typically trained but responds well to routine.',
  //     grooming: 'Keep tank clean and well-filtered; requires stable water conditions.',
  //     health: 'Prone to neon tetra disease and stress.',
  //   ),
  //   FishBreed(
  //     name: 'Guppy',
  //     alternateNames: 'Millions Fish, Rainbow Fish',
  //     origin: 'Northeastern South America',
  //     colors: 'Various (blue, red, green, yellow, etc.)',
  //     heightMin: 1,
  //     heightMax: 2.5,
  //     weightMin: 0.5,
  //     weightMax: 0.5,
  //     exerciseNeeds: 'Moderate; enjoys swimming space and plants.',
  //     training: 'Can be conditioned to recognize feeding times.',
  //     grooming: 'Regular water changes and tank maintenance are necessary.',
  //     health: 'Susceptible to fin rot and velvet disease.',
  //   ),
  //   FishBreed(
  //     name: 'Angelfish',
  //     alternateNames: 'None',
  //     origin: 'South America (Amazon River)',
  //     colors: 'Black, silver, gold, marbled.',
  //     heightMin: 6,
  //     heightMax: 6,
  //     weightMin: 0.5,
  //     weightMax: 0.5,
  //     exerciseNeeds: 'Moderate; requires vertical swimming space.',
  //     training: 'Can be trained to recognize feeding times.',
  //     grooming: 'Regular water changes and tank maintenance; avoid overcrowding.',
  //     health: 'Prone to angelfish disease and parasites.',
  //   ),
  //   FishBreed(
  //     name: 'Oscar Fish',
  //     alternateNames: 'None',
  //     origin: 'South America (Amazon River)',
  //     colors: 'Various (orange, black, red, etc.)',
  //     heightMin: 12,
  //     heightMax: 18,
  //     weightMin: 3,
  //     weightMax: 4,
  //     exerciseNeeds: 'High; requires large tank space to swim.',
  //     training: 'Can be trained to perform tricks and recognize owners.',
  //     grooming: 'Regular tank maintenance; requires clean water.',
  //     health: 'Susceptible to hole-in-the-head disease and other infections.',
  //   ),
  //   FishBreed(
  //     name: 'Clownfish',
  //     alternateNames: 'Anemone Fish',
  //     origin: 'Indo-Pacific (Great Barrier Reef)',
  //     colors: 'Orange with white bands.',
  //     heightMin: 4,
  //     heightMax: 5,
  //     weightMin: 0.5,
  //     weightMax: 0.5,
  //     exerciseNeeds: 'Moderate; enjoys swimming and anemones for hiding.',
  //     training: 'Minimal training; can be conditioned to recognize feeding times.',
  //     grooming: 'Keep tank clean; provide appropriate tank mates.',
  //     health: 'Prone to ich and other parasites.',
  //   ),
  //   FishBreed(
  //     name: 'Discus Fish',
  //     alternateNames: 'None',
  //     origin: 'South America (Amazon River)',
  //     colors: 'Various (blue, green, red, brown).',
  //     heightMin: 6,
  //     heightMax: 8,
  //     weightMin: 1,
  //     weightMax: 3,
  //     exerciseNeeds: 'Moderate; requires stable water conditions.',
  //     training: 'Can be trained to recognize feeding times; social with other discus.',
  //     grooming: 'Regular water changes and tank maintenance; requires high-quality water.',
  //     health: 'Susceptible to discus disease and stress-related issues.',
  //   ),
  //   FishBreed(
  //     name: 'Koi Fish',
  //     alternateNames: 'None',
  //     origin: 'Japan',
  //     colors: 'Various (white, red, black, blue, yellow).',
  //     heightMin: 12,
  //     heightMax: 36,
  //     weightMin: 1,
  //     weightMax: 9,
  //     exerciseNeeds: 'High; needs a large pond to swim freely.',
  //     training: 'Can be trained to recognize feeding times and respond to call.',
  //     grooming: 'Pond maintenance and water quality are essential; regular checks.',
  //     health: 'Prone to koi herpes virus and bacterial infections.',
  //   ),
  //   FishBreed(
  //     name: 'Pufferfish',
  //     alternateNames: 'Tetraodon',
  //     origin: 'Various (marine and freshwater environments).',
  //     colors: 'Various (brown, yellow, spotted).',
  //     heightMin: 4,
  //     heightMax: 12,
  //     weightMin: 1,
  //     weightMax: 4,
  //     exerciseNeeds: 'Moderate; needs space to swim and explore.',
  //     training: 'Can be trained to recognize feeding times.',
  //     grooming: 'Regular tank maintenance; sensitive to water quality.',
  //     health: 'Prone to diseases related to poor water conditions and stress.',
  //   ),
  // ];
  // Future<void> uploadFishBreeds(List<FishBreed> fishBreeds) async {
  //   // Get the Firestore instance
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   // Reference to the 'info_fish' collection
  //   CollectionReference fishBreedsCollection = firestore.collection('fish_info');
  //
  //   for (var breed in fishBreeds) {
  //     // Create the document ID by converting multi-word name to underscore format
  //     String documentId = breed.name.toLowerCase().replaceAll(' ', '_');
  //
  //     // Create or update the document for each fish breed using documentId
  //     await fishBreedsCollection.doc(documentId).set({
  //       'name': breed.name,
  //       'alternateNames': breed.alternateNames,
  //       'origin': breed.origin,
  //       'colors': breed.colors,
  //       'heightMin': breed.heightMin,
  //       'heightMax': breed.heightMax,
  //       'weightMin': breed.weightMin,
  //       'weightMax': breed.weightMax,
  //       'exerciseNeeds': breed.exerciseNeeds,
  //       'training': breed.training,
  //       'grooming': breed.grooming,
  //       'health': breed.health,
  //     }).then((docRef) {
  //       print('Fish breed ${breed.name} uploaded with ID: $documentId');
  //     }).catchError((error) {
  //       print('Error uploading fish breed ${breed.name}: $error');
  //     });
  //   }
  // }
  
  
  // Future<void> uploadCatBreeds(List<CatBreed> catBreeds) async {
  //   // Get the Firestore instance
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   // Reference to the 'Cat_info' collection
  //   CollectionReference catBreedsCollection = firestore.collection('cat_info');
  //
  //   for (var breed in catBreeds) {
  //     // Create a valid document ID from the breed name
  //     String docId = breed.name.toLowerCase().replaceAll(' ', '_');
  //
  //     // Create or update the document for each cat breed using the custom docId
  //     await catBreedsCollection.doc(docId).set({
  //       'name': breed.name,
  //       'alternateNames': breed.alternateNames,
  //       'origin': breed.origin,
  //       'colors': breed.colors,
  //       'heightMin': breed.heightMin,
  //       'heightMax': breed.heightMax,
  //       'weightMin': breed.weightMin,
  //       'weightMax': breed.weightMax,
  //       'exerciseNeeds': breed.exerciseNeeds,
  //       'training': breed.training,
  //       'grooming': breed.grooming,
  //       'health': breed.health,
  //     }).then((_) {
  //       print('Cat breed ${breed.name} uploaded with ID: $docId');
  //     }).catchError((error) {
  //       print('Error uploading cat breed ${breed.name}: $error');
  //     });
  //   }
  // }
  //
  //
  // Future<void> uploadDogDetails() async {
  //   // Define the list of dog data
  //
  //   List<Map<String, dynamic>> dogDetails = [
  //   {
  //   "id": "poodle_miniature_toy",
  //   "name": "Poodle (Miniature, Toy)",
  //   "alternateNames": "None",
  //   "origin": "Germany",
  //   "lifeSpan": "12-15 years",
  //   "description": "Curly, hypoallergenic coat. Intelligent and elegant.",
  //   "colors": "Black, White, Apricot, Silver, Blue, Gray, Cream, Brown",
  //   "weight_miniature": "5-9 kg",
  //   "height_miniature": "11-15 inches",
  //   "weight_toy": "2-3 kg",
  //   "height_toy": "9-11 inches",
  //   "exerciseNeeds": "Moderate to high. Poodles enjoy activities such as fetch, agility, and obedience training.",
  //   "training": "Highly trainable and excels in obedience and agility.",
  //   "grooming": "Regular brushing and professional grooming every 4-6 weeks.",
  //   "health": "Generally healthy but may be prone to hip dysplasia, Addison’s disease, eye problems, and Sebaceous Adenitis (SA) in Standards."
  //   },
  //   {
  //   "id": "boxer",
  //   "name": "Boxer",
  //   "alternateNames": "None",
  //   "origin": "Germany",
  //   "lifeSpan": "10-12 years",
  //   "description": "Medium-large, muscular, short coat. Playful and energetic.",
  //   "colors": "Fawn, Brindle, White (rare), with or without Black Mask",
  //   "weight": "23-36 kg",
  //   "height": "21-25 inches",
  //   "exerciseNeeds": "30-60 minutes of exercise per day.",
  //   "training": "Easy to train with positive reinforcement.",
  //   "grooming": "Weekly brushing.",
  //   "health": "Prone to hip dysplasia, elbow dysplasia, cancer, and heart disease."
  //   },
  //   {
  //   "id": "siberian_husky",
  //   "name": "Siberian Husky",
  //   "alternateNames": "Husky",
  //   "origin": "Siberia",
  //   "lifeSpan": "12-14 years",
  //   "description": "Medium-sized, thick double coat. Independent and energetic.",
  //   "colors": "Black & White, Red & White, Gray & White, Sable & White, All White",
  //   "weight": "16-27 kg",
  //   "height": "20-23 inches",
  //   "exerciseNeeds": "High energy levels, require plenty of exercise. Love running, hiking, and pulling sleds.",
  //   "training": "Intelligent but stubborn. Early socialization and consistent, positive reinforcement training are important.",
  //   "grooming": "Heavy shedding coat, regular brushing helps manage shedding, especially during shedding periods.",
  //   "health": "Generally healthy but prone to hip dysplasia and eye issues."
  //   },
  //   {
  //   "id": "pomeranian",
  //   "name": "Pomeranian",
  //   "alternateNames": "Pom",
  //   "origin": "Germany/Poland",
  //   "lifeSpan": "12-16 years",
  //   "description": "Small, fluffy coat, fox-like face. Lively and bold.",
  //   "colors": "Orange, Black, White, Cream, Blue, Chocolate, Beaver",
  //   "weight": "1.4-3.2 kg",
  //   "height": "7-12 inches",
  //   "exerciseNeeds": "Low to moderate.",
  //   "training": "Easy to train with positive reinforcement methods.",
  //   "health": "Generally healthy but may be prone to luxating patellas, intervertebral disc disease (IVDD), and hypothyroidism."
  //   },
  //   {
  //   "id": "gaddi_kutta",
  //   "name": "Gaddi Kutta",
  //   "alternateNames": "Indian Leopard Hound, Indian Panther Hound",
  //   "origin": "India (Himalayas)",
  //   "lifeSpan": "10-14 years",
  //   "description": "Large, thick coat, livestock guardian. Strong and independent.",
  //   "colors": "Black, White, Brindle, Fawn, Gray",
  //   "weight": "35-45 kg",
  //   "height": "28–35 inches",
  //   "exerciseNeeds": "High-energy breed needing 1-2 hours of exercise daily. Best suited for open spaces.",
  //   "training": "Independent and intelligent but can be stubborn. Requires firm, consistent training from an experienced handler.",
  //   "grooming": "Thick double coat needs regular brushing to prevent matting.",
  //   "health": "Prone to hip dysplasia and joint issues. Regular vet checkups and a protein-rich diet with joint supplements are recommended."
  //   },
  //   {
  //   "id": "bully_kutta",
  //   "name": "Bully Kutta",
  //   "alternateNames": "Indian Mastiff, Pakistani Mastiff",
  //   "origin": "India/Pakistan",
  //   "lifeSpan": "8-12 years",
  //   "description": "Large-giant, muscular build. Strong and protective.",
  //   "colors": "White, Brindle, Fawn, Black, Brown, Red",
  //   "weight": "70-90 kg",
  //   "height": "30-44 inches",
  //   "exerciseNeeds": "High energy breed requiring 1-2 hours of exercise daily. Needs intense physical activities.",
  //   "training": "Strong-willed and dominant; requires an experienced handler. Early socialization and firm, consistent obedience training are essential.",
  //   "grooming": "Short coat requires minimal grooming. Brush once a week and occasional baths.",
  //   "health": "Prone to hip dysplasia, arthritis, and heart issues. Regular vet checkups and maintaining a healthy weight are crucial."
  //   }
  //   ];
  //
  //   // Reference to the Firestore collection
  //   CollectionReference dogsCollection = FirebaseFirestore.instance.collection('info');
  //
  //   // Upload each dog's details to Firestore
  //   for (var dog in dogDetails) {
  //     try {
  //       await dogsCollection.doc(dog["id"]).set(dog);
  //       print('${dog["name"]} details uploaded successfully.');
  //     } catch (e) {
  //       print('Error uploading ${dog["name"]} details: $e');
  //     }
  //   }
  // }
  // class CatBreed {
  //   String name;
  //   String alternateNames;
  //   String origin;
  //   List<String> colors;
  //   double heightMin;
  //   double heightMax;
  //   double weightMin;
  //   double weightMax;
  //   String exerciseNeeds;
  //   String training;
  //   String grooming;
  //   String health;
  //
  //   CatBreed({
  //     required this.name,
  //     required this.alternateNames,
  //     required this.origin,
  //     required this.colors,
  //     required this.heightMin,
  //     required this.heightMax,
  //     required this.weightMin,
  //     required this.weightMax,
  //     required this.exerciseNeeds,
  //     required this.training,
  //     required this.grooming,
  //     required this.health,
  //   });
  // }
  //
  // List<CatBreed> catBreeds = [
  //   CatBreed(
  //     name: 'Persian Cat',
  //     alternateNames: 'None',
  //     origin: 'Persia (Iran)',
  //     colors: ['White', 'Black', 'Blue', 'Cream'],
  //     heightMin: 10.0,
  //     heightMax: 15.0,
  //     weightMin: 3.0,
  //     weightMax: 5.5,
  //     exerciseNeeds: 'Moderate; indoor play and short sessions.',
  //     training: 'Generally responsive to training but can be independent; positive reinforcement works best.',
  //     grooming: 'Requires daily brushing to prevent matting.',
  //     health: 'Prone to breathing issues due to flat face, kidney disease, and eye problems.',
  //   ),
  //   CatBreed(
  //     name: 'Maine Coon',
  //     alternateNames: 'None',
  //     origin: 'United States (Maine)',
  //     colors: ['Tabby', 'Solid', 'Bicolor'],
  //     heightMin: 10.0,
  //     heightMax: 16.0,
  //     weightMin: 4.5,
  //     weightMax: 11.3,
  //     exerciseNeeds: 'High; enjoys interactive play and climbing.',
  //     training: 'Intelligent and trainable; enjoys learning tricks.',
  //     grooming: 'Requires weekly brushing; can develop matting.',
  //     health: 'Prone to hip dysplasia and heart conditions.',
  //   ),
  //   CatBreed(
  //     name: 'Siamese',
  //     alternateNames: 'None',
  //     origin: 'Thailand',
  //     colors: ['Pointed (cream body with darker extremities)'],
  //     heightMin: 8.0,
  //     heightMax: 10.0,
  //     weightMin: 3.6,
  //     weightMax: 6.8,
  //     exerciseNeeds: 'Moderate; enjoys play and interaction.',
  //     training: 'Highly intelligent; responds well to training and socialization.',
  //     grooming: 'Short coat requires minimal grooming; occasional brushing.',
  //     health: 'Prone to respiratory issues and dental problems.',
  //   ),
  //   CatBreed(
  //     name: 'Bengal',
  //     alternateNames: 'None',
  //     origin: 'United States (hybrid breed)',
  //     colors: ['Spotted', 'Marbled (Brown, Silver, Snow)'],
  //     heightMin: 8.0,
  //     heightMax: 10.0,
  //     weightMin: 3.6,
  //     weightMax: 6.8,
  //     exerciseNeeds: 'High; very active and playful; needs stimulation.',
  //     training: 'Intelligent and curious; can learn commands and tricks.',
  //     grooming: 'Short coat requires minimal grooming; occasional brushing.',
  //     health: 'Prone to hip dysplasia and certain heart issues.',
  //   ),
  //   CatBreed(
  //     name: 'Ragdoll',
  //     alternateNames: 'None',
  //     origin: 'United States',
  //     colors: ['Blue', 'Seal', 'Lilac', 'Cream'],
  //     heightMin: 9.0,
  //     heightMax: 11.0,
  //     weightMin: 4.5,
  //     weightMax: 9.0,
  //     exerciseNeeds: 'Moderate; enjoys interactive play but can be laid-back.',
  //     training: 'Friendly and trainable; responds well to positive reinforcement.',
  //     grooming: 'Requires weekly brushing; prone to matting.',
  //     health: 'Prone to heart disease and certain genetic conditions.',
  //   ),
  //   CatBreed(
  //     name: 'Scottish Fold',
  //     alternateNames: 'None',
  //     origin: 'Scotland',
  //     colors: ['White', 'Black', 'Blue', 'Tabby'],
  //     heightMin: 8.0,
  //     heightMax: 10.0,
  //     weightMin: 2.7,
  //     weightMax: 5.9,
  //     exerciseNeeds: 'Moderate; enjoys play but can be calm.',
  //     training: 'Intelligent; responds well to positive reinforcement.',
  //     grooming: 'Short coat requires minimal grooming; occasional brushing.',
  //     health: 'Prone to joint issues and certain genetic disorders.',
  //   ),
  //   CatBreed(
  //     name: 'Sphynx',
  //     alternateNames: 'None',
  //     origin: 'Canada',
  //     colors: ['All colors and patterns'],
  //     heightMin: 8.0,
  //     heightMax: 10.0,
  //     weightMin: 2.7,
  //     weightMax: 5.4,
  //     exerciseNeeds: 'Moderate; playful and active but can be lazy.',
  //     training: 'Intelligent; can be trained with positive reinforcement.',
  //     grooming: 'Requires regular bathing to remove oils from skin.',
  //     health: 'Prone to skin issues and heart disease.',
  //   ),
  //   CatBreed(
  //     name: 'British Shorthair',
  //     alternateNames: 'None',
  //     origin: 'United Kingdom',
  //     colors: ['Blue', 'Black', 'White', 'Tabby'],
  //     heightMin: 12.0,
  //     heightMax: 14.0,
  //     weightMin: 4.0,
  //     weightMax: 8.2,
  //     exerciseNeeds: 'Moderate; enjoys play but is generally laid-back.',
  //     training: 'Generally easy to train; responds well to routine.',
  //     grooming: 'Short coat requires minimal grooming; occasional brushing.',
  //     health: 'Prone to obesity, heart disease, and certain genetic conditions.',
  //   ),
  //   CatBreed(
  //     name: 'Norwegian Forest Cat',
  //     alternateNames: 'None',
  //     origin: 'Norway',
  //     colors: ['Tabby', 'Solid'],
  //     heightMin: 9.0,
  //     heightMax: 12.0,
  //     weightMin: 5.4,
  //     weightMax: 7.3,
  //     exerciseNeeds: 'High; enjoys climbing and interactive play.',
  //     training: 'Intelligent and trainable; enjoys learning.',
  //     grooming: 'Requires weekly brushing to prevent matting.',
  //     health: 'Prone to hip dysplasia and heart disease.',
  //   ),
  //   CatBreed(
  //     name: 'Abyssinian',
  //     alternateNames: 'None',
  //     origin: 'Ethiopia',
  //     colors: ['Ruddy', 'Red', 'Blue', 'Fawn'],
  //     heightMin: 8.0,
  //     heightMax: 10.0,
  //     weightMin: 2.7,
  //     weightMax: 4.5,
  //     exerciseNeeds: 'High; active and playful, needs stimulation.',
  //     training: 'Intelligent; responds well to training and play.',
  //     grooming: 'Short coat requires minimal grooming; occasional brushing.',
  //     health: 'Generally healthy, but may be prone to dental issues.',
  //   ),
  // ];

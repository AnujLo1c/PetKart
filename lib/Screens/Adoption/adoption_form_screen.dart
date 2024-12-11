import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../SControllers/AdoptionPageController/adoption_form_controller.dart';


class AdoptionFormScreen extends StatelessWidget {

  const AdoptionFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final AdoptionFormController controller = Get.put(AdoptionFormController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption Form'),
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField(' Full Name', controller.fullNameController),
              buildTextField(' Address', controller.addressController),
              buildTextField(' Contact No', controller.contactNoController),
              // buildTextField(' Email', controller.emailController),
              // const Gap( 5),
              const Text(' House Type', style: TextStyle(fontWeight: FontWeight.bold)),
              buildRadioListTile('Rent', 'Own', controller.houseType),
              buildTextField(' Members', controller.membersController),
              const Gap( 5),
              const Text(' Have you owned a pet before?', style: TextStyle(fontWeight: FontWeight.bold)),
              buildYesNoRadio(controller.ownedPetBefore),
              const Gap( 5),
              const Text(' Do you currently have a pet?', style: TextStyle(fontWeight: FontWeight.bold)),
              buildYesNoRadio(controller.currentlyHavePet),
              buildTextField(' Reason of Adoption', controller.reasonForAdoptionController),
              buildTextField(' Are you financially prepared?', controller.financiallyPreparedController),
              buildTextField(' Who will take care of it when you are away?', controller.caretakerController),

              Row(
                mainAxisSize: MainAxisSize.min, // Reduces space between children
                children: [
                  Obx(() => Checkbox(
                    visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                    value: controller.termsAccepted.value,
                    onChanged: (value) {
                      controller.termsAccepted.value = value!;
                    },
                  )),
                  TextButton(
                    onPressed: () {
                      // Handle Terms & Conditions link here
                    },
                    child: const Text('Term & Condition'),
                  ),
                ],
              )
,

              Center(
                child: ElevatedButton(
                  onPressed: ()=>controller.submitForm(),
                  style: ElevatedButton.styleFrom(
           minimumSize: Size(Get.width-20, 50)
                  ),
                  child: const Text('Request'),
                ),
              ),
              Gap(20)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController textController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Gap( 3),
        TextField(
          controller: textController,
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0), ),
            contentPadding: EdgeInsets.all(8.0),
          ),
        ),

        const Gap(12),
      ],
    );
  }

  Widget buildRadioListTile(String option1, String option2, RxString selectedOption) {
    return Obx(
          () => Column(

        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(option1),
            leading: Radio<String>(
              value: option1,
              groupValue: selectedOption.value,
              onChanged: (value) {
                selectedOption.value = value!;
              },
            ),
            visualDensity: VisualDensity(vertical: -4),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(option2),
            leading: Radio<String>(
              value: option2,
              groupValue: selectedOption.value,
              onChanged: (value) {
                selectedOption.value = value!;
              },
            ),
            visualDensity: VisualDensity(vertical: -4),
          ),
        ],
      ),
    );
  }


  Widget buildYesNoRadio(RxBool obsBool) {
    return Obx(
          () => Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Yes'),
            leading: Radio<bool>(
              value: true,
              groupValue: obsBool.value,
              onChanged: (value) {
                obsBool.value = value!;
              },
            ),
            visualDensity: VisualDensity(vertical: -4),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('No'),
            leading: Radio<bool>(
              value: false,
              groupValue: obsBool.value,
              onChanged: (value) {
                obsBool.value = value!;
              },
            ),
            visualDensity: VisualDensity(vertical: -4),
          ),
        ],
      ),
    );
  }
}

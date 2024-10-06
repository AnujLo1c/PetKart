import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommunityPageController extends GetxController{
Rx<bool> postBoxBool=false.obs;
TextEditingController postController=TextEditingController();
Rx<bool> onMyFeed=true.obs;

postingToggle(){
  postBoxBool.value=!postBoxBool.value;
  postController.clear();
}
myFeedToggle(){
  onMyFeed.value=!onMyFeed.value;
  postController.clear();
}

Rx<bool> tempLikeToggle=false.obs;
likeToggle(){
  //TODO: MAKE IT FOR POST LIST
  tempLikeToggle.value=!tempLikeToggle.value;
}
// @override
//   void onInit() {
//
//     super.onInit();
//     postFocusNode.addListener(focusListenFun);
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//     postFocusNode.removeListener(focusListenFun);
//     postFocusNode.dispose();
//   }

}
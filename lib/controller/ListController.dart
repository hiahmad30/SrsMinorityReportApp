import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  Rx<QuerySnapshot> ratingList = Rx<QuerySnapshot>();
  QuerySnapshot get rating => ratingList.value;

  @override
  Future<void> onInit() async {
    // await db.open();
    // String id = Get.find<AuthController>().firebaseUser.uid;
    ratingList.bindStream(FirebaseFirestore.instance
        .collection("Bussiness List")
        .snapshots()); //id)); //Stream Comming from
    super.onInit();
  }

  @override
  void onClose() {
    // db.close();
    super.onClose();
  }
}

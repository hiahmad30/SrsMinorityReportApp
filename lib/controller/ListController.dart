import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  Rx<QuerySnapshot> ratingList = Rx<QuerySnapshot>();
  QuerySnapshot get rating => ratingList.value;
  final businessList = FirebaseFirestore.instance.collection('Bussiness List');

  @override
  Future<void> onInit() async {
    getList();
    // await db.open();
    // String id = Get.find<AuthController>().firebaseUser.uid;
    //id)); //Stream Comming from
    super.onInit();
  }

  getList() {
    ratingList.bindStream(businessList.snapshots());
  }

  @override
  void onClose() {
    // db.close();
    super.onClose();
  }
}

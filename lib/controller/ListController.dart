import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListRController extends GetxController {
  // Rx<QuerySnapshot> querySnapshot = ?.obs;
  @override
  void onInit() {
    //  businessList.bindStream(getRatingStream());
    // TODO: implement onInit
    super.onInit();
  }

  Stream<QuerySnapshot> getRatingStream() {
    print('[MinorityReport] : stream is going on');
    return (FirebaseFirestore.instance
        .collection("Bussiness List")
        .snapshots());
  }
}

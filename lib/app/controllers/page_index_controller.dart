import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kasir_jeruk_ayang/app/routes/app_pages.dart';
import 'package:kasir_jeruk_ayang/app/controllers/transaksi_controller.dart';

class PageIndexController extends GetxController {
  // final feederController = Get.find<FeederController>();
  final transaksiController = Get.find<TransaksiController>();

  RxInt pageIndex = 0.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void changePage(int index) async {
    pageIndex.value = index;

    switch (index) {
      case 1:
        // feederController.feeder();
        transaksiController.transaksi();
        break;
      case 2:
        Get.offAllNamed(Routes.SETTING);
      case 3:
        Get.offAllNamed(Routes.MAIN);
      case 4:
        logout();
      default:
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }
}

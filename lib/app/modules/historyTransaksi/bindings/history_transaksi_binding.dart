import 'package:get/get.dart';

import '../controllers/history_transaksi_controller.dart';

class HistoryTransaksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryTransaksiController>(
      () => HistoryTransaksiController(),
    );
  }
}

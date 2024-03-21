import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_transaksi_controller.dart';

class HistoryTransaksiView extends GetView<HistoryTransaksiController> {
  const HistoryTransaksiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HistoryTransaksiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HistoryTransaksiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

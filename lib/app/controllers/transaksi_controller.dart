import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasir_jeruk_ayang/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:kasir_jeruk_ayang/app/widgets/dialog/custom_notification.dart';

class TransaksiController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  transaksi() async {}
}

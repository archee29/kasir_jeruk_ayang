import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kasir_jeruk_ayang/app/widgets/dialog/custom_notification.dart';

class ResetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendEmail() async {
    if (emailController.text.isNotEmpty) {
      isLoading.value = true;
      // print("called");
      try {
        // print("success");
        auth.sendPasswordResetEmail(email: emailController.text);
        Get.back();
        CustomNotification.successNotification("Success",
            "Kami Telah mengirimkan link untuk ubah Password Ke Email Anda");
      } catch (e) {
        CustomNotification.errorNotification("Error",
            "Tidak Dapat Mengirimkan Link Untuk Ubah Password Karena : ${e.toString()}");
      } finally {
        isLoading.value = false;
      }
    } else {
      CustomNotification.errorNotification(
          "Error", "Masukkan Email Terlebih Dahulu");
    }
  }
}

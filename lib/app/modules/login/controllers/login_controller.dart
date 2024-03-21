import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kasir_jeruk_ayang/app/controllers/page_index_controller.dart';
import 'package:kasir_jeruk_ayang/app/routes/app_pages.dart';
import 'package:kasir_jeruk_ayang/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:kasir_jeruk_ayang/app/widgets/dialog/custom_notification.dart';

class LoginController extends GetxController {
  final pageIndexController = Get.find<PageIndexController>();

  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  checkDefaultPassword() {
    // ignore: unrelated_type_equality_checks
    if (passwordController == 'qwertyuiop') {
      Get.toNamed(Routes.NEW_PASSWORD);
    } else {
      Get.offAllNamed(Routes.HOME);
      pageIndexController.changePage(0);
    }
  }

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        if (credential.user != null) {
          if (credential.user!.emailVerified) {
            isLoading.value = false;
            checkDefaultPassword();
          } else {
            CustomAlertDialog.showFeederAlert(
              title: "Email belum di Verifikasi",
              message: "Verifikasi Email Terlebih Dahulu",
              onCancel: () => Get.back(),
              onConfirm: () async {
                try {
                  await credential.user!.sendEmailVerification();
                  CustomNotification.successNotification("Sukses",
                      "Verifikasi Email telah dikirimkan ke Email User");
                  isLoading.value = false;
                } catch (e) {
                  CustomNotification.errorNotification(
                      "Error", "Tidak Dapat Mengirimkan Verifikasi Email");
                }
              },
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == "user-not-found") {
          CustomNotification.errorNotification("Error", "Akun Belum Terdaftar");
        } else if (e.code == "wrong-password") {
          CustomNotification.errorNotification("Error", "Password Salah");
        }
      } catch (e) {
        CustomNotification.errorNotification(
            "Error", "Terjadi Kesalahan Karena ${e.toString()}");
      }
    } else {
      CustomNotification.errorNotification(
          "Error", "Isi Form Data Terlebih dahulu");
    }
  }
}

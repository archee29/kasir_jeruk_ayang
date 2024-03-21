import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kasir_jeruk_ayang/app/widgets/dialog/custom_notification.dart';

class NewPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  RxBool oldPasswordObs = true.obs;
  RxBool newPasswordObs = true.obs;
  RxBool newPasswordControllerObs = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePassword() async {
    if (currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmNewPasswordController.text.isNotEmpty) {
      if (newPasswordController.text == confirmNewPasswordController.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currentPasswordController.text);
          await auth.currentUser!.updatePassword(newPasswordController.text);
          Get.back();
          CustomNotification.successNotification(
              "Sukses", "Berhasil Ubah Password");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            CustomNotification.errorNotification(
                "Error", 'Password Lama Salah');
          } else {
            CustomNotification.errorNotification(
                "error", "Tidak Dapat Mengubah Password Karena : ${e.code}");
          }
        } catch (e) {
          CustomNotification.errorNotification(
              "Error", "Error : ${e.toString()}");
        } finally {
          isLoading.value = false;
        }
      } else {
        CustomNotification.errorNotification("Error",
            "Password Baru dan Konfirmasi Password yang Dimasukkan Tidak Sama");
      }
    } else {
      CustomNotification.errorNotification(
          "Error", "Isi Formulir Terlebih Dahulu");
    }
  }
}

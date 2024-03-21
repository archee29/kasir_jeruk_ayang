import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasir_jeruk_ayang/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:kasir_jeruk_ayang/app/widgets/dialog/custom_notification.dart';
import 'package:kasir_jeruk_ayang/data_pengguna.dart';

class SignupController extends GetxController {
  @override
  onClose() {
    idController.dispose();
    nameController.dispose();
    emailController.dispose();
    adminPasswordController.dispose();
  }

  RxBool isLoading = false.obs;
  RxBool isLoadingCreateUser = false.obs;

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String getDefaultPassword() {
    return DataPengguna.defaultPassword;
  }

  String getDefaultRole() {
    return DataPengguna.defaultRole;
  }

  Future<void> addUser() async {
    if (idController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        jobController.text.isNotEmpty) {
      isLoading.value = true;
      CustomAlertDialog.confirmAdmin(
        title: "Konfirmasi Admin",
        message: "Perlu Konfirmasi Admin untuk melakukan registrasi",
        onCancel: () {
          isLoading.value = false;
          Get.back();
        },
        onConfirm: () async {
          if (isLoadingCreateUser.isFalse) {
            await createUserData();
            isLoading.value = false;
          }
        },
        controller: adminPasswordController,
      );
    } else {
      isLoading.value = false;
      CustomNotification.errorNotification("Error", "Isi Form Terlebih Dahulu");
    }
  }

  createUserData() async {
    if (adminPasswordController.text.isNotEmpty) {
      isLoadingCreateUser.value = true;
      String adminEmail = auth.currentUser!.email!;
      try {
        await auth.signInWithEmailAndPassword(
            email: adminEmail, password: adminPasswordController.text);
        String defaultPassword = getDefaultPassword();
        String defaultRole = getDefaultRole();
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: defaultPassword,
        );

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          DocumentReference user = firestore.collection("user").doc(uid);
          await user.set({
            "user_id": idController.text,
            "name": nameController.text,
            "email": emailController.text,
            "role": defaultRole,
            "job": jobController.text,
            "created_at": DateTime.now().toIso8601String(),
          });
          await userCredential.user!.sendEmailVerification();
          Get.back();
          Get.back();
          CustomNotification.successNotification(
              "Sukses", "Berhasil Menambahkan User");
          isLoadingCreateUser.value = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingCreateUser.value = false;
        if (e.code == 'weak-password') {
          // print('the password provided is too weak.');
          CustomNotification.errorNotification(
              "Error", "default password too short");
        } else if (e.code == 'email-already-in-use') {
          // print('The account already exists for that email.');
          CustomNotification.errorNotification(
              'Error', 'Employee already exist');
        } else if (e.code == 'wrong-password') {
          CustomNotification.errorNotification('Error', 'wrong passowrd');
        } else {
          CustomNotification.errorNotification('Error', 'error : ${e.code}');
        }
      } catch (e) {
        isLoadingCreateUser.value = false;
        CustomNotification.errorNotification(
            'Error', 'error : ${e.toString()}');
      }
    } else {
      CustomNotification.errorNotification(
          "Error", "Masukkan Password Terlebih Dahulu");
    }
  }
}

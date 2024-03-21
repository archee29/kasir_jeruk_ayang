import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:kasir_jeruk_ayang/app/widgets/dialog/custom_notification.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController userIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> updateProfile() async {
    String uid = auth.currentUser!.uid;
    if (userIdController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameController.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          String upDir = "$uid/avatar.$ext";
          await storage.ref(upDir).putFile(file);
          String avatarUrl = await storage.ref(upDir).getDownloadURL();

          data.addAll({"avatar": avatarUrl});
        }
        await firestore.collection("user").doc(uid).update(data);
        image = null;
        Get.back();
        CustomNotification.successNotification(
            "Sukses", "Sukses Update Profile");
      } catch (e) {
        CustomNotification.errorNotification(
            "Error", "Tidak Dapat Update Profile. Error : ${e.toString()}");
      } finally {
        isLoading.value = false;
      }
    } else {
      CustomNotification.errorNotification("Error", "Isi Form Terlebih Dahulu");
    }
  }

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // print(image!.path);
      // print(image!.name.split(".").last);
    }
    update();
  }

  void deleteProfile() async {
    String uid = auth.currentUser!.uid;
    try {
      await firestore.collection("user").doc(uid).update({
        "avatar": FieldValue.delete(),
      });
      Get.back();
      Get.snackbar("Berhasil", "Berhasil Delete Avatar profile");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Tidak Dapat Delete Avatar Profile");
    } finally {
      update();
    }
  }
}

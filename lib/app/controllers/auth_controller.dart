import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kasir_jeruk_ayang/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  // method login
  void login(String email, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (myUser.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: "Verfikasi Email",
          middleText:
              "Kamu Perlu verifikasi Email Terlebih Dahulu, Apakah Kamu ingin dikirimkan verifikasi ulang?",
          onConfirm: () async {
            await myUser.user!.sendEmailVerification();
            Get.back();
          },
          textConfirm: "Kirim Ulang",
          textCancel: "Kembali",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Wrong password provided for that user.",
        );
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak Dapat Login dengan Akun Ini",
      );
    }
  }

  // method register
  void signup(String email, String password) async {
    try {
      UserCredential myUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await myUser.user!.sendEmailVerification();
      Get.defaultDialog(
        title: "Verifikasi Email",
        middleText: "Kami Telah Mengirimkan email verifikasi ke $email",
        onConfirm: () {
          Get.back(); // Close Dialog
          Get.back(); // go to login
        },
        textConfirm: "Ya, Saya Akan Cek Email.",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "The account already exists for that email.",
        );
      }
    } catch (e) {
      // print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Account Doesn't Exist",
      );
    }
  }

  // method reset password
  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
            title: "Berhasil",
            middleText:
                "Kami Telah mengirimkan reset password ke email $email.",
            onConfirm: () {
              Get.back();
              Get.back();
            },
            textConfirm: "Ya, Aku Mengerti.");
      } catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak Dapat Mengirimkan Reset Password",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjaadi Kesalahan",
        middleText: "Email tidak valid",
      );
    }
  }

  // method logout
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}

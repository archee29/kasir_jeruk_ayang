import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kasir_jeruk_ayang/app/styles/app_colors.dart';
import 'package:kasir_jeruk_ayang/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 35 / 100,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              image: const DecorationImage(
                image: AssetImage('assets/images/pattern-1-1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Automatic Cat Feeder\nMobile Application",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'poppins',
                    height: 150 / 100,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "by Muhammad Aswin Sigit",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 65 / 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 84),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: AppColors.secondaryExtraSoft,
                    ),
                  ),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'poppins',
                    ),
                    maxLines: 1,
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      label: Text(
                        "Email",
                        style: TextStyle(
                          color: AppColors.secondarySoft,
                          fontSize: 14,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      hintText: "email@gmail.com",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondarySoft,
                      ),
                    ),
                  ),
                ),
                Material(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: AppColors.secondaryExtraSoft,
                      ),
                    ),
                    child: Obx(
                      () => TextField(
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'poppins'),
                        maxLines: 1,
                        controller: controller.passwordController,
                        obscureText: controller.obsecureText.value,
                        decoration: InputDecoration(
                          label: Text(
                            "Password",
                            style: TextStyle(
                              color: AppColors.secondarySoft,
                              fontSize: 14,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: InputBorder.none,
                          hintText: "*********",
                          suffixIcon: IconButton(
                            icon: (controller.obsecureText != false)
                                ? SvgPicture.asset('assets/icons/show.svg')
                                : SvgPicture.asset('assets/icons/hide.svg'),
                            onPressed: () {
                              controller.obsecureText.value =
                                  !(controller.obsecureText.value);
                            },
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondarySoft,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        (controller.isLoading.isFalse)
                            ? 'Masuk'
                            : 'Loading ....',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 4),
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.secondarySoft,
                    ),
                    child: const Text(
                      "Lupa Password?",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFFF92C85),
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

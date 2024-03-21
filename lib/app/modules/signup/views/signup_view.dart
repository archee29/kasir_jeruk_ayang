import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kasir_jeruk_ayang/app/styles/app_colors.dart';
import 'package:kasir_jeruk_ayang/app/widgets/CustomWidgets/custom_input.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah User",
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColors.secondaryExtraSoft,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          CustomInput(
            controller: controller.idController,
            label: 'User ID',
            hint: '01110101',
          ),
          CustomInput(
            controller: controller.nameController,
            label: 'Nama Lengkap',
            hint: 'John Deo',
          ),
          CustomInput(
            controller: controller.emailController,
            label: 'Email',
            hint: 'youremail@email.com',
          ),
          CustomInput(
            controller: controller.jobController,
            label: 'Job',
            hint: 'User Job',
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.addUser();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  (controller.isLoading.isFalse)
                      ? 'Tambah User'
                      : 'Loading ...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

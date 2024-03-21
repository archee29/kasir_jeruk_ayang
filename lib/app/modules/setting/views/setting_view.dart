import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kasir_jeruk_ayang/app/controllers/page_index_controller.dart';
import 'package:kasir_jeruk_ayang/app/routes/app_pages.dart';
import 'package:kasir_jeruk_ayang/app/styles/app_colors.dart';
import 'package:kasir_jeruk_ayang/app/widgets/CustomWidgets/custom_bottom_navbar.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  final pageIndexController = Get.find<PageIndexController>();

  SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              Map<String, dynamic> userData = snapshot.data!.data()!;
              return ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 36),
                children: [
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 124,
                          height: 124,
                          color: Colors.pink,
                          child: Image.network(
                            (userData["avatar"] == null ||
                                    userData['avatar'] == "")
                                ? "https://ui-avatars.com/api/?name${userData['name']}/"
                                : userData['avatar'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 4),
                        child: Text(
                          userData["name"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        userData["job"],
                        style: TextStyle(color: AppColors.secondarySoft),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 42),
                    child: Column(
                      children: [
                        MenuTile(
                          title: 'Update Profile',
                          icon: SvgPicture.asset('assets/icons/profile-1.svg'),
                          onTap: () => Get.offAndToNamed(
                            Routes.UPDATE_PROFILE,
                            arguments: userData,
                          ),
                        ),
                        MenuTile(
                          title: "Ubah Password",
                          icon: SvgPicture.asset(
                            'assets/icons/password.svg',
                          ),
                          onTap: () => Get.toNamed(Routes.NEW_PASSWORD),
                        ),
                        MenuTile(
                          title: "History Feeder",
                          icon: SvgPicture.asset(
                            'assets/icons/history.svg',
                          ),
                          onTap: () => Get.toNamed(Routes.HISTORY_TRANSAKSI),
                        ),
                        MenuTile(
                          isDanger: true,
                          title: 'Keluar',
                          icon: SvgPicture.asset(
                            'assets/icons/logout.svg',
                          ),
                          onTap: controller.logout,
                        ),
                        Container(
                          height: 1,
                          color: AppColors.primaryExtraSoft,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;

  const MenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.secondaryExtraSoft,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: const EdgeInsets.only(right: 24),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryExtraSoft,
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: (isDanger == false)
                      ? AppColors.secondary
                      : AppColors.error,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: SvgPicture.asset(
                'assets/icon/arrow-right.svg',
                // ignore: deprecated_member_use
                color:
                    (isDanger == false) ? AppColors.secondary : AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

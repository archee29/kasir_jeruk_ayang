import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kasir_jeruk_ayang/app/controllers/page_index_controller.dart';
import 'package:kasir_jeruk_ayang/app/styles/app_colors.dart';

class CustomBottomNavigationBar extends GetView<PageIndexController> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 97,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Stack(
        alignment: const FractionalOffset(.5, 1.0),
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  top:
                      BorderSide(color: AppColors.secondaryExtraSoft, width: 1),
                ),
              ),
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Button Home
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(0),
                        child: SizedBox(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: (controller.pageIndex.value == 0)
                                    ? SvgPicture.asset(
                                        'assets/icons/home-active.svg')
                                    : SvgPicture.asset("assets/icons/home.svg"),
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Button Statistik
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(3),
                        child: SizedBox(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: (controller.pageIndex.value == 3)
                                    ? SvgPicture.asset(
                                        'assets/icons/chart-inactive.svg')
                                    : SvgPicture.asset(
                                        "assets/icons/chart-active.svg"),
                              ),
                              Text(
                                "Statistic",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Container untuk Text pada Button Feeder
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      margin: const EdgeInsets.only(top: 24),
                      alignment: Alignment.center,
                      child: Text(
                        "Feeder",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    //  Button Settings
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(2),
                        child: SizedBox(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: (controller.pageIndex.value == 2)
                                    ? SvgPicture.asset(
                                        'assets/icons/setting-black.svg')
                                    : SvgPicture.asset(
                                        'assets/icons/setting.svg'),
                              ),
                              Text(
                                "Settings",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.secondary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //  Button Logout
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(4),
                        child: SizedBox(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: (controller.pageIndex.value == 4)
                                    ? SvgPicture.asset(
                                        'assets/icons/logout-black.svg')
                                    : SvgPicture.asset(
                                        'assets/icons/logout-button.svg'),
                              ),
                              Text(
                                "Keluar",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.secondary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            child: Obx(
              () => SizedBox(
                width: 64,
                height: 64,
                child: FloatingActionButton(
                  onPressed: () => controller.changePage(1),
                  elevation: 0,
                  backgroundColor: AppColors.primary,
                  child: (controller.transaksiController.isLoading.isFalse)
                      ? SvgPicture.asset('assets/icons/feeder.svg',
                          // ignore: deprecated_member_use
                          color: Colors.white)
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
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

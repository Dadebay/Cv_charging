// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/home/controllers/home_controller.dart';
import '../constants.dart';

class AgreeButton extends StatelessWidget {
  final Function() onTap;
  final String name;
  final bool style;

  AgreeButton({
    required this.onTap,
    Key? key,
    required this.name,
    required this.style,
  }) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: animatedContaner());
  }

  Widget animatedContaner() {
    return Obx(() {
      return AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: borderRadius20,
          color: style ? Colors.white : kPrimaryColor,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: homeController.agreeButton.value ? 0 : 10),
        width: homeController.agreeButton.value ? 60 : Get.size.width,
        duration: const Duration(milliseconds: 1000),
        child: homeController.agreeButton.value
            ? const Center(
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Text(
                name.tr,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: style ? Colors.black : Colors.white, fontFamily: gilroySemiBold, fontSize: 22),
              ),
      );
    });
  }
}

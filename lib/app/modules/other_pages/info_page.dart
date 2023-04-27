import 'package:carousel_slider/carousel_slider.dart';
import 'package:cv_charing/app/modules/other_pages/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor3,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            IconlyLight.arrowLeftCircle,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Information Page'.tr,
          style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold),
        ),
      ),
      body: CarouselSlider.builder(
        itemCount: 4,
        itemBuilder: (context, index, count) {
          return GestureDetector(
              onTap: () {
                Get.to(
                  () => PhotoViewPage(
                    image: 'assets/image/instruction/${index + 1}.png',
                    networkImage: false,
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(8),
                color: Colors.red,
              ));
        },
        options: CarouselOptions(
          onPageChanged: (index, CarouselPageChangedReason a) {},
          height: Get.size.height,
          viewportFraction: 0.8,
          autoPlay: true,
          scrollPhysics: const BouncingScrollPhysics(),
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          autoPlayAnimationDuration: const Duration(milliseconds: 2000),
        ),
      ),
    );
  }
}

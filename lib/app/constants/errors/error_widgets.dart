import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';

dynamic referalPageError() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(noData),
        Text(
          'noData'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroyMedium),
        )
      ],
    ),
  );
}

dynamic locationPageError() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(pinLottie, width: 300, height: 300),
        Text(
          'emptyLocations'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroyMedium),
        )
      ],
    ),
  );
}

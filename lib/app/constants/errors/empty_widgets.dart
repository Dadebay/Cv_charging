import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';

dynamic referalPageEmptyData() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(noData),
        Text(
          'noData1'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroyMedium),
        )
      ],
    ),
  );
}

dynamic orderPageEmpty() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(noData),
        Text(
          'noHistoryOrders'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroyMedium),
        )
      ],
    ),
  );
}

dynamic emptyCart() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(emptyCartLottie, fit: BoxFit.cover, animate: true, width: 400, height: 400),
        Text(
          'cartEmpty'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
        ),
        Text(
          'cartEmptySubtitle'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 20),
        ),
        const SizedBox(
          height: 125,
        )
      ],
    ),
  );
}

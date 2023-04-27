import 'package:cv_charing/app/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';

class InvoicesAndPayments extends StatelessWidget {
  const InvoicesAndPayments({super.key});

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
          'invoicesAndPayments'.tr,
          style: nwtsM,
        ),
      ),
      backgroundColor: kPrimaryColor3,
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "0.00 \$",
            style: TextStyle(color: kPrimaryColor, fontFamily: gilroySemiBold, fontSize: 24),
          ),
          Container(
            width: Get.size.width,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: ElevatedButton(
                onPressed: () {
                  showSnackBar('error2', 'notWorkSubtitle', Colors.red);
                },
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor1, shape: RoundedRectangleBorder(borderRadius: borderRadius5, side: BorderSide(color: kPrimaryColor1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      IconlyLight.wallet,
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'makePayment'.tr,
                        style: TextStyle(color: Colors.grey.shade300, fontFamily: gilroyMedium, fontSize: 18),
                      ),
                    ),
                    Icon(
                      IconlyLight.arrowRightCircle,
                      color: Colors.grey.shade300,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

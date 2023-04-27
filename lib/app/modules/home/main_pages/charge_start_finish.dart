import 'package:cv_charing/app/constants/constants.dart';
import 'package:cv_charing/app/constants/text_fields/custom_text_field.dart';
import 'package:cv_charing/app/constants/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ChargeStartAndFinishView extends StatefulWidget {
  @override
  State<ChargeStartAndFinishView> createState() => _ChargeStartAndFinishViewState();
}

class _ChargeStartAndFinishViewState extends State<ChargeStartAndFinishView> {
  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor3,
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
          'startCharge'.tr,
          style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'withQRCode'.tr,
                  style: TextStyle(color: kPrimaryColor, fontFamily: gilroyRegular, fontSize: 16),
                ),
                qrCodeScanner(context),
                Text(
                  'or'.tr,
                  style: TextStyle(color: kPrimaryColor, fontFamily: gilroyRegular, fontSize: 16),
                ),
                greenButton(),
              ],
            ),
          ),
          bottomButton()
        ],
      ),
    );
  }

  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();
  Container greenButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(top: 15),
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: () {
          Get.defaultDialog(
            titlePadding: EdgeInsets.only(top: 15),
            title: 'enterCode',
            backgroundColor: kPrimaryColor1,
            titleStyle: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 18),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(labelName: 'enterStationCode', controller: controller, focusNode: node, requestfocusNode: node, isNumber: true, unFocus: false, cursorColor: Colors.black),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xfffff1f0)),
                        child: Text(
                          'no'.tr,
                          style: TextStyle(color: Colors.red, fontFamily: gilroyRegular),
                        )),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xfff8fdeb)),
                        child: Text(
                          'yes'.tr,
                          style: TextStyle(color: kPrimaryColor, fontFamily: gilroyRegular),
                        )),
                  ],
                )
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 226, 239, 194),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: borderRadius5, side: BorderSide(color: kPrimaryColor)),
        ),
        child: Text(
          'enterStationCode'.tr,
          style: TextStyle(color: kPrimaryColor, fontFamily: gilroyMedium, fontSize: 16),
        ),
      ),
    );
  }

  Container qrCodeScanner(BuildContext context) {
    return Container(
      width: Get.size.width / 1.2,
      height: Get.size.height / 2.8,
      child: ClipRRect(
        borderRadius: borderRadius30,
        child: MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            final Uint8List? image = capture.image;
            showSnackBar('startCharge', 'startChargeSub', Colors.green);
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pop(context);
            });
          },
        ),
      ),
    );
  }

  SizedBox bottomButton() {
    return SizedBox(
      width: Get.size.width,
      child: ElevatedButton(
          onPressed: () {
            showSnackBar('error2', "error4", Colors.red);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          child: Text(
            'ongoingCharges'.tr,
            style: nbtsM,
          )),
    );
  }
}

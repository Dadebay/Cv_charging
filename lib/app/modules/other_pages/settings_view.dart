import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../constants/widgets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
          'settings'.tr,
          style: nwtsM,
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          cardWidget(),
          SizedBox(
            height: 25,
          ),
          Divider(
            color: Colors.grey.shade300,
            height: 1,
          ),
          textFieldNameWidget('text7', "Dadebay"),
          Divider(
            color: Colors.grey.shade300,
            height: 1,
          ),
          SizedBox(
            height: 8,
          ),
          textFieldNameWidget('text8', 'Gurbanow'),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Colors.grey.shade300,
            height: 1,
          ),
          textFieldNameWidget('text3', 'dadebaygurbanow333@gmail.com'),
          SizedBox(
            height: 15,
          ),
          button('select_language', () {
            changeLanguage();
          }, true),
          button('sendOtp', () {}, true),
          button('changePhoneNumber', () {}, true),
          button('changePassword', () {}, true),
          button('passivateContract', () {}, false),
          button('deleteContract', () {}, false),
        ],
      ),
    );
  }

  Container cardWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Color(0xffe8e8e8),
        borderRadius: borderRadius10,
      ),
      child: Material(
        elevation: 1,
        color: Color(0xffe8e8e8),
        borderRadius: borderRadius10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'contractType'.tr,
                      style: TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 14),
                    ),
                    Text(
                      'personal'.tr,
                      style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'contractCode'.tr,
                      style: TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 14),
                    ),
                    Text(
                      'CFYUN4WTF',
                      style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container button(String name, VoidCallback onTapp, bool style) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(top: 15),
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: onTapp,
        style: ElevatedButton.styleFrom(
          backgroundColor: style ? Color(0xfff8fdeb) : Color(0xfffff1f0),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: borderRadius10, side: BorderSide(color: style ? kPrimaryColor : Colors.red)),
        ),
        child: Text(
          name.tr,
          style: TextStyle(color: style ? kPrimaryColor : Colors.red, fontFamily: gilroyRegular, fontSize: 16),
        ),
      ),
    );
  }
}

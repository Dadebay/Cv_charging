import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/constants.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            IconlyLight.arrowLeftCircle,
            color: Colors.black,
          ),
        ),
        title: Text(
          'contactInformation'.tr,
          style: nbtsM,
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('contactInformation'.tr, style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20)),
          Text('contactUsSubtitle'.tr, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20)),
          Column(
            children: [
              button('support@cv-charging.com', IconlyLight.message, () {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'support@cv-charging.com',
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Example Subject & Symbols are allowed!',
                  }),
                );

                launchUrl(emailLaunchUri);
              }),
              button(' 444 22 07 (CV Charging Vehicles)', IconlyLight.call, () async {
                final Uri smsLaunchUri = Uri(
                  scheme: 'tel',
                  path: '+99362990344',
                );
                await launchUrl(smsLaunchUri);
              }),
            ],
          ),
          SizedBox(),
          SizedBox(),
          SizedBox()
        ],
      ),
    );
  }

  Container button(String name, IconData icon, VoidCallback onTapp) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(top: 15),
      width: Get.size.width,
      child: ElevatedButton.icon(
        onPressed: onTapp,
        style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, shape: RoundedRectangleBorder(borderRadius: borderRadius5), elevation: 1),
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          name,
          style: nwtsM,
        ),
      ),
    );
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
}

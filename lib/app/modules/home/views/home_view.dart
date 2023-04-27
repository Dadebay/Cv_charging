import 'package:cv_charing/app/constants/constants.dart';
import 'package:cv_charing/app/modules/auth/views/connection_check_view.dart';
import 'package:cv_charing/app/modules/home/drawer_pages/credit_cards.dart';
import 'package:cv_charing/app/modules/other_pages/contact_us.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';

import '../../../constants/buttons/home_page_button.dart';
import '../../../constants/buttons/settings_button.dart';
import '../../other_pages/settings_view.dart';
import '../controllers/home_controller.dart';
import '../drawer_pages/invoices_and_payments.dart';
import '../drawer_pages/my_users_view.dart';
import '../main_pages/charge_start_finish.dart';
import '../main_pages/closest_stations.dart';
import '../main_pages/favorite_stations.dart';

class HomeView extends GetView<HomeController> {
  final String userDisplayName;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeView(this.userDisplayName);
  @override
  Widget build(BuildContext context) {
    print(userDisplayName);
    return Scaffold(
      backgroundColor: kPrimaryColor1,
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor1,
        title: Text(
          userDisplayName == '' ? 'Cv Charging Vehicles' : userDisplayName,
          style: TextStyle(color: kPrimaryColor, fontFamily: gilroySemiBold, fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(
            IconlyLight.category,
            color: kPrimaryColor,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: drawer(),
      body: Column(
        children: [body(), bottom()],
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
        backgroundColor: kPrimaryColor3,
        child: ListView(
          children: [
            DrawerHeader(
                child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                logo,
                fit: BoxFit.contain,
              ),
            )),
            SettingButton2(
                icon: IconlyLight.home,
                name: 'home'.tr,
                onTap: () {
                  Get.to(() => HomeView(userDisplayName));
                }),
            SettingButton2(
                icon: Icons.electric_car_outlined,
                name: 'startCharge2'.tr,
                onTap: () {
                  Get.to(() => ChargeStartAndFinishView());
                }),
            SettingButton2(
                icon: CupertinoIcons.map_pin_ellipse,
                name: 'stationsClosest',
                onTap: () {
                  Get.to(() => ClosestStations());
                }),
            SettingButton2(
                icon: IconlyLight.star,
                name: 'favStations',
                onTap: () {
                  Get.to(() => FavoritesStations(
                        docID: FirebaseAuth.instance.currentUser!.uid,
                      ));
                }),
            SettingButton2(icon: IconlyLight.timeCircle, name: 'chargeHistory', onTap: () {}),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Divider(
                color: Colors.white24,
              ),
            ),
            SettingButton2(
                icon: IconlyLight.document,
                name: 'invoicesAndPayments',
                onTap: () {
                  Get.to(() => InvoicesAndPayments());
                }),
            SettingButton2(
                icon: IconlyLight.user3,
                name: 'myUsers',
                onTap: () {
                  Get.to(() => MyUserView());
                }),
            SettingButton2(
                icon: CupertinoIcons.creditcard,
                name: 'cards',
                onTap: () {
                  print('Itapped');
                  Get.to(() => CreditCardsView());
                }),
            SettingButton2(
                icon: IconlyLight.profile,
                name: 'myAccount',
                onTap: () {
                  Get.to(() => SettingsView());
                }),
            SettingButton2(
                icon: IconlyLight.logout,
                name: 'log_out',
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.to(() => ConnectionCheckView());
                }),
          ],
        ));
  }

  Row bottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              // Get.to(() => InstructionPage());
            },
            icon: Icon(
              CupertinoIcons.info_circle_fill,
              color: Colors.white,
              size: 30,
            )),
        IconButton(
            onPressed: () {
              Get.to(() => SettingsView());
            },
            icon: Icon(
              IconlyBold.setting,
              color: Colors.white,
              size: 30,
            )),
        IconButton(
            onPressed: () {
              Get.to(() => ContactUsView());
            },
            icon: Icon(
              CupertinoIcons.chat_bubble_2_fill,
              color: Colors.white,
              size: 30,
            ))
      ],
    );
  }

  Expanded body() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              HomePageButton(
                icon: Icons.electric_car_outlined,
                name: 'startCharge2',
                onTap: () {
                  Get.to(() => ChargeStartAndFinishView());
                },
              ),
              HomePageButton(
                icon: CupertinoIcons.map_pin_ellipse,
                name: 'stationsClosest',
                onTap: () {
                  Get.to(() => ClosestStations());
                },
              ),
            ],
          ),
          Row(
            children: [
              HomePageButton(
                icon: IconlyLight.timeCircle,
                name: 'chargeHistory'.tr + '\n',
                onTap: () {
                  // Get.to(() => AdminPage());
                },
              ),
              HomePageButton(
                icon: IconlyLight.star,
                name: 'favStations',
                onTap: () {
                  Get.to(() => FavoritesStations(
                        docID: FirebaseAuth.instance.currentUser!.uid,
                      ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

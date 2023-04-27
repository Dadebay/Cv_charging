import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../../../constants/constants.dart';

class CreditCardsView extends StatefulWidget {
  const CreditCardsView({super.key});

  @override
  State<CreditCardsView> createState() => _CreditCardsViewState();
}

class _CreditCardsViewState extends State<CreditCardsView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List cards = [
    {'user': 'Dadebay Gurbanow', 'cardID': 'LZrJOTBNGA', 'status': 'active'}
  ];
  List cardRequested = [
    {
      'user': 'Dadebay Gurbanow',
      'date': '25 Apr 2023 03:18:11',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            'cards'.tr,
            style: nwtsM,
          ),
        ),
        backgroundColor: kPrimaryColor3,
        body: Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  tabbars(),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [page1(), page2()],
                    ),
                  )
                ],
              ),
            )),
            bottomButtons(),
          ],
        ),
      ),
    );
  }

  Column page1() {
    return Column(
      children: [
        Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('type'.tr, style: TextStyle(color: kPrimaryColor)),
              Text('profil'.tr, style: TextStyle(color: kPrimaryColor)),
              Text('cardID'.tr, style: TextStyle(color: kPrimaryColor)),
              Text('status'.tr, style: TextStyle(color: kPrimaryColor)),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    shadowColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    shape: RoundedRectangleBorder(borderRadius: borderRadius10, side: BorderSide(color: Colors.grey.shade200)),
                    elevation: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("VR")),
                    dividerr(),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            cards[index]['user'],
                            textAlign: TextAlign.center,
                          ),
                        )),
                    dividerr(),
                    Expanded(
                        flex: 2,
                        child: Text(
                          cards[index]['cardID'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    dividerr(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        decoration: BoxDecoration(color: index % 2 == 0 ? Colors.green : Colors.red, borderRadius: borderRadius10),
                        child: Text(
                          index % 2 == 0 ? 'active'.tr : 'notActive'.tr,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ))
      ],
    );
  }

  Container dividerr() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  Column page2() {
    return Column(
      children: [
        Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('type'.tr, style: TextStyle(color: kPrimaryColor)),
              Text('requestBy'.tr, style: TextStyle(color: kPrimaryColor)),
              Text('requestDate'.tr, style: TextStyle(color: kPrimaryColor)),
              Text('status'.tr, style: TextStyle(color: kPrimaryColor)),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemCount: cardRequested.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    shadowColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    shape: RoundedRectangleBorder(borderRadius: borderRadius10, side: BorderSide(color: Colors.grey.shade200)),
                    elevation: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("VR")),
                    dividerr(),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            cardRequested[index]['user'],
                            textAlign: TextAlign.center,
                          ),
                        )),
                    dividerr(),
                    Expanded(
                        flex: 2,
                        child: Text(
                          cardRequested[index]['date'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    dividerr(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.blue, borderRadius: borderRadius10),
                        child: Text(
                          'waiting'.tr,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ))
      ],
    );
  }

  Container tabbars() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: borderRadius25),
      child: TabBar(
        controller: _tabController,
        isScrollable: false,
        labelPadding: EdgeInsets.symmetric(horizontal: 6),
        indicator: BoxDecoration(
          borderRadius: borderRadius25,
          color: Colors.white,
        ),
        labelColor: Colors.white,
        automaticIndicatorColorAdjustment: false,
        labelStyle: nbtsM,
        unselectedLabelStyle: nbtsR,
        padding: EdgeInsets.symmetric(vertical: 4),
        dividerColor: Colors.transparent,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            child: Container(
              width: Get.size.width,
              alignment: Alignment.center,
              child: Text(
                'cards',
                style: nbtsR,
              ),
            ),
          ),
          Tab(
            child: Container(
              width: Get.size.width,
              alignment: Alignment.center,
              child: Text(
                'requests'.tr,
                style: nbtsR,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row bottomButtons() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              String a = generateRandomString(10);
              cards.add({'user': 'Ulanyjy ady', 'cardID': a, 'status': 'active'});
              setState(() {});
            },
            style: TextButton.styleFrom(backgroundColor: kPrimaryColor3, elevation: 0.0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
            child: Text(
              'activateCard'.tr,
              style: TextStyle(color: Colors.white, fontFamily: gilroyRegular, fontSize: 18),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
              String string = dateFormat.format(DateTime.now());
              cardRequested.add({'user': 'Ulanyjy ady', 'date': string});
              setState(() {});
            },
            style: TextButton.styleFrom(backgroundColor: kPrimaryColor3, elevation: 0.0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
            child: Text(
              'requestCard'.tr,
              style: TextStyle(color: Colors.white, fontFamily: gilroyRegular, fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

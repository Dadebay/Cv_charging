import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class HomePageButton extends StatelessWidget {
  const HomePageButton({super.key, required this.onTap, required this.icon, required this.name});
  final VoidCallback onTap;
  final IconData icon;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius30,
              ),
              elevation: 1,
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Icon(
                    icon,
                    color: kPrimaryColor,
                    size: 60,
                  ),
                ),
                Text(
                  name.tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 17),
                )
              ],
            )),
      ),
    );
  }
}

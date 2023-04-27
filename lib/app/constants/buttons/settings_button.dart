// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class SettingButton extends StatelessWidget {
  final String name;
  final Function() onTap;
  final Widget icon;
  const SettingButton({
    required this.name,
    required this.onTap,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: 23,
      title: Text(
        name.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(color: Colors.white, fontFamily: gilroyMedium),
      ),
      trailing: icon,
    );
  }
}

class SettingButton2 extends StatelessWidget {
  final String name;
  final Function() onTap;
  final IconData icon;
  const SettingButton2({
    required this.name,
    required this.onTap,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        name.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(color: Colors.white, fontFamily: gilroyRegular, fontSize: 16),
      ),
      leading: Icon(
        icon,
        size: 25,
        color: Colors.white,
      ),
    );
  }
}

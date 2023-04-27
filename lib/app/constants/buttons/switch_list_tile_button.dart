import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class SwitchListTileButton extends StatefulWidget {
  const SwitchListTileButton({super.key, required this.name, required this.icon});
  final String name;
  final IconData icon;
  @override
  State<SwitchListTileButton> createState() => _SwitchListTileButtonState();
}

class _SwitchListTileButtonState extends State<SwitchListTileButton> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        activeTrackColor: kPrimaryColor,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 15),
              child: Icon(
                widget.icon,
                size: 28,
                color: Colors.grey.shade400,
              ),
            ),
            Expanded(
              child: Text(
                widget.name.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: nbtsM,
              ),
            ),
          ],
        ),
        value: value,
        onChanged: (v) {
          value = v;
          setState(() {});
        });
  }
}

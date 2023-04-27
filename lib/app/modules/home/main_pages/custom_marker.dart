import 'package:cv_charing/app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({
    super.key,
    required this.name,
    required this.count,
  });
  final String name;
  final String count;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: borderRadius10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Icon(
                Icons.electric_car_outlined,
                color: kPrimaryColor,
              ),
            ),
            Text(
              name,
              style: const TextStyle(color: kPrimaryColor, fontFamily: gilroySemiBold),
            ),
          ]),
        ),
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kPrimaryColor, width: 6)),
          child: Text(
            count,
            style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/assets.dart';
import '../../utils/config.dart';
class MyContainer extends StatelessWidget {
  // MyContainer({Key key}) : super(key: key);
  String name;
  String vehicleType;
  MyContainer({Key? key, 
    required this.name,required this.vehicleType
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context)*0.08,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5 ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconProfile,
                scale: 5,
              ),
              SizedBox(width: screenWidth(context)*0.05,),
              SizedBox(
                width: screenWidth(context)*0.3,
                child: Text(
            name,
            style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w400, color: primaryColor),
          ),
              ),
            ],
          ),
          
          Text(
            vehicleType,
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.w400, color: primaryColor),
          )
        ],
      ),
    );
  }}
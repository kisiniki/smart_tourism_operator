import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tourism_operator/utils/assets.dart';

import '../../utils/config.dart';

class SepedaContainer extends StatelessWidget {
  const SepedaContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0, top: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: screenWidth(context) * 0.48,
            width: screenWidth(context) * 0.43,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: primaryColor),
          ),
          Positioned(
              top: -40,
              right: -60,
              child: Image.asset(
                imageSepeda,
                height: screenWidth(context) * 0.55,
                width: screenWidth(context) * 0.55,
              )),
          Positioned(
              bottom: 15,
              left: 10,
              child: Text('Sepeda',
                  style: GoogleFonts.roboto(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: white))),
        ],
      ),
    );
  }
}

class ATVContainer extends StatelessWidget {
  const ATVContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, top: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: screenWidth(context) * 0.48,
            width: screenWidth(context) * 0.43,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: primaryColor),
          ),
          Positioned(
              top: -20,
              right: -10,
              child: Image.asset(
                'assets/images/image-ATV.png',
                height: screenWidth(context) * 0.40,
                width: screenWidth(context) * 0.40,
              )),
          Positioned(
              bottom: 15,
              left: 10,
              child: Text('ATV',
                  style: GoogleFonts.roboto(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: white))),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String keyToken='token', fcmToken='token';
const storage = FlutterSecureStorage();
Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}

double screenWidth(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}

double screenHeightExcludingToolbar(BuildContext context,
    {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}

const Color primaryColor = Color.fromRGBO(112, 42, 45, 1);
const Color secondaryColor = Color.fromRGBO(196, 73, 79, 1);
const Color white = Colors.white;
const Color black = Colors.black;

String valideEmail (String email){
  String? _msg;
   RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
   if (email.isEmpty) {
     _msg = 'Isi email terlebih dahulu!';
   } else if (regex.hasMatch(email)) {
     _msg = 'Isi Email dengan benar';
   }
  return _msg!;
}
Widget loadingIndicator = const Center(
    child: CircularProgressIndicator(color: primaryColor,),
  );

final oCcy = NumberFormat("#,##0", "en_US");
bool isUsing = false;
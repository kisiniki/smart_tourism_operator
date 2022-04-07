import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smart_tourism_operator/router/constants.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    _init();
  }

  void _init() async {
    // if (jailBroken)
    //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     deviceRootedRoute,
    //     (route) => false,
    //   );
    // else {
    // if (hasSeenOnBoarding == null) {
    //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     onBoardingRoute,
    //     (p) => false,
    //   );
    //   return;
    // }

    // if (token == null)
    //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     phoneLoginRoute,
    //     (p) => false,
    //   );
    // else
    WidgetsBinding.instance!.addPostFrameCallback((_){

Navigator.pushNamedAndRemoveUntil(
      context, loginRoute, (p) => false,
      // arguments: CommonArgument<int>(object: 0,)
    );
    // }
});
    
  }

  // Future<bool> _jailBreakDetection() async {
  //   try {
  //     final bool jailBroken = await FlutterJailbreakDetection.jailbroken;
  //     return jailBroken;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white);
  }
}

import 'package:flutter/material.dart';
import 'package:smart_tourism_operator/presentation/bot_nav_bar.dart';
import 'package:smart_tourism_operator/presentation/screen/history/tagihan_route.dart';
import 'package:smart_tourism_operator/presentation/screen/home/home_screen.dart';
import 'package:smart_tourism_operator/presentation/screen/main/root.dart';
import 'package:smart_tourism_operator/presentation/screen/sign_in/sign_in_screen.dart';
import 'package:smart_tourism_operator/presentation/screen/sign_up/sign_up.dart';
import 'package:smart_tourism_operator/router/constants.dart';
import '../presentation/screen/sepeda_detail_route/sepeda_detail_route.dart';
import '../presentation/screen/sepeda_detail_routes/sepeda_detail_routes.dart';
import '../presentation/screen/sepeda_running/sepeda_running_route.dart';
import '../presentation/screen/vehicle_detail_route/vehicle_detail_route.dart';

class Router {
   static Route<dynamic> routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case rootRoute:
        return MaterialPageRoute(settings: settings, builder: (_) => Root());
      case bottomNavBar:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BottomNavigation());
      case signUpRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const SignUpRoute(
                  // emailValidator: (String value) {},
                  // namaValidator: (String value) {},
                  // onSaved: (String newValue) {},
                ));
      case loginRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginRoute());
      case homeRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case sepedaDetailSRout:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SepedaDetailSRoute());
      case atvDetailSRout:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const VehicleDetailRoute());
      case sepedaDetailRoute:
        Map detail = settings.arguments as Map;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SepedaDetailRoute(
                  id: detail['id'],
                ));
      case sepedaRunningRoute:
        Map detail = settings.arguments as Map;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SepedaRunningRoute(
                  idVehicle: detail['idVehicle'],
                  idRental: detail['idRental'],
                ));
      case tagihanRoute:
        Map detail = settings.arguments as Map;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => TagihanRoute(
                  idVehicle: detail['idVehicle'],
                  idRental: detail['idRental'],
                ));
      // case atvRoute:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => ATVMainRoute());
      default:
        return _errorRoute();
    }
   }
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error Route'),
        ),
        body: const Center(
          child: Text('Page Not Found'),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_tourism_operator/presentation/screen/home/home_screen.dart';
import 'package:smart_tourism_operator/router/constants.dart';
import 'package:smart_tourism_operator/utils/config.dart';

import 'screen/history/history_route.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  final List _widgetOptions = [
    const HomeScreen(),
     const HistoryRoute(),
  ];
  late String barcodeScanRes;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    barcodeScanRes = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: primaryColor),
            label: 'Utama',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: primaryColor,
            ),
            label: 'Riwayat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(
          Icons.camera_alt,
          color: white,
        ),
        onPressed: () async {
          await scanBarcodeNormal();
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  Future<void> scanBarcodeNormal() async {
    
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // await getVehicleDetail(barcodeScanRes);
      Navigator.pushNamed(context, sepedaDetailRoute,
          arguments: {'id': barcodeScanRes});
          barcodeScanRes = '';
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {});
  }
}

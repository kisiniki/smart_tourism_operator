// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism_operator/presentation/widget/my_container.dart';
import 'package:smart_tourism_operator/presentation/widget/sepeda_containter.dart';
import 'package:smart_tourism_operator/utils/config.dart';
import 'package:smart_tourism_operator/main.dart';

import '../../../data/model/profile.dart';
import '../../../data/model/running.dart';
import '../../../data/model/vehicle.dart';
import '../../../router/constants.dart';
import '../../../utils/api.dart';
import '../../../utils/assets.dart';
import '../../../utils/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final storage = FlutterSecureStorage();
  final circular = false;
  Future readSecureData(String key) async {
    var readData = await storage.read(key: keyToken);
    return readData;
  }
  Location location = Location();
  LocationService locationService = LocationService();
  Set<Marker> marker = {};
  String barcode = "";
  List<String> listVehicle = [iconMenuSepeda, imageATV];
  // var vehicleId, rentalid;
AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    refreshList();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        var vehicleID = int.parse(message.data['vehicle_id']);
        var rentalID = int.parse(message.data['rental_id']);
        await Navigator.pushNamed(context, sepedaRunningRoute,
            arguments: {'idVehicle': vehicleID, 'idRental': rentalID});
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel!.id,
              channel!.name,
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      var vehicleID = int.parse(message.data['vehicle_id']);
      var rentalID = int.parse(message.data['rental_id']);
      // print(
      //     'onMessageOpenedApp adalah OpenApp vehicle Id 2 ${message.data['vehicle_id']}');
      await Navigator.pushNamed(context, sepedaRunningRoute,
          arguments: {'idVehicle': vehicleID, 'idRental': rentalID});
    });
  }

  @override
  void dispose() {
    super.dispose();
    
  }

  Future<void> refreshList() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getListPesanan();
      getListBerjalan();
      getListEnded();
    });
    return;
  }

  void getDataFcm(Map<String, dynamic> message) {
    String rentalId = '';
    String vehicleId = '';
    if (Platform.isIOS) {
      rentalId = message['rental']['user_id'];
      vehicleId = message['rental']['vehicle_id'];
    } else if (Platform.isAndroid) {
      var data = message['data'];
      rentalId = data['rental']['user_id'];
      vehicleId = data['rental']['vehicle_id'];
    }
    if (rentalId.isNotEmpty && vehicleId.isNotEmpty) {
      setState(() {});
    }
    debugPrint('getDataFcm: name: $rentalId & age: $vehicleId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refreshList,
        child: SingleChildScrollView(
            child: FutureBuilder<ProfileModel>(
                future: getProfile(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (snapshot.hasError) {
                    Center(
                      child: Text(snapshot.hasError.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: screenHeight(context) * 0.4,
                          width: screenWidth(context),
                          color: white,
                          child: Stack(
                            children: [
                              Image.asset(
                                backgroundMain,
                                height: screenHeight(context) * 0.35,
                                width: screenWidth(context),
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                  top: 30,
                                  right: 20,
                                  child: InkWell(
                                    onTap: logout,
                                    child: Icon(
                                      Icons.logout_outlined,
                                      color: white,
                                      size: 27,
                                    ),
                                  )),
                              Positioned(
                                  left: 30,
                                  top: 50,
                                  child: Text(
                                    'Hallo,',
                                    style: GoogleFonts.roboto(
                                        fontSize: 31,
                                        fontWeight: FontWeight.w700,
                                        color: white),
                                  )),
                              Positioned(
                                left: 10,
                                right: 10,
                                bottom: 0,
                                child: Container(
                                  width: screenWidth(context) * 0.9,
                                  height: screenHeight(context) * 0.25,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: primaryColor,
                                            offset: Offset(0, 7),
                                            blurStyle: BlurStyle.normal,
                                            blurRadius: 3)
                                      ]),
                                  padding: EdgeInsets.all(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data!.user!.name!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 33,
                                              color: primaryColor),
                                        ),
                                        Row(
                                          children: [
                                            Text('Total Meminjam    :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    color: primaryColor)),
                                            Text(
                                                data.totalPaidRental.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    color: primaryColor)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth(context),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight(context) * 0.03,
                              ),
                              Text('Mau naik apa Sekarang?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                      color: primaryColor)),
                              SizedBox(
                                  height: screenHeight(context) * 0.26,
                                  child: ListView(
                                    // shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            await Navigator.pushNamed(
                                                context, sepedaDetailSRout);
                                          },
                                          child: SepedaContainer()),
                                      InkWell(
                                          onTap: () async {
                                            await Navigator.pushNamed(
                                                context, atvDetailSRout);
                                          },
                                          child: ATVContainer())
                                    ],
                                  )),
                              SizedBox(
                                height: screenHeight(context) * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Pesanan',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        color: primaryColor),
                                  ),
                                  SizedBox(
                                    height: screenHeight(context) * 0.02,
                                  ),
                                  SizedBox(
                                    // height: screenHeight(context) * 0.5,
                                    child: FutureBuilder<List<Waiting>>(
                                        future: getListPesanan(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<Waiting> data = snapshot.data!;
                                            List vehicleTypeList = [];
                                            for (var e in data) {
                                              vehicleTypeList.add(
                                                  e.vehicle!.vehicleTypeId);
                                            }
                                            List serialNumberList = [];
                                            for (var e in data) {
                                              serialNumberList
                                                  .add(e.vehicle!.serialNumber);
                                            }
                                            // print(vehicleTypeList);
                                            return ListView.builder(
                                                primary: false,
                                                shrinkWrap: true,
                                                // scrollDirection: Axis.horizontal,
                                                itemCount: data.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: InkWell(
                                                      child: MyContainer(
                                                          name:
                                                              serialNumberList[
                                                                  index],
                                                          vehicleType:
                                                              vehicleTypeList[
                                                                          index] ==
                                                                      1
                                                                  ? 'sepeda'
                                                                  : 'ATV'),
                                                    ),
                                                  );
                                                });
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }
                                          return Center(
                                              child: loadingIndicator);
                                        }),
                                  ),
                                  const Text(
                                    'Sedang Berjalan',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        color: primaryColor),
                                  ),
                                  SizedBox(
                                    child: FutureBuilder<List<Ongoing>>(
                                        future: getListBerjalan(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<Ongoing> data = snapshot.data!;
                                            List vehicleTypeList = [];
                                            for (var e in data) {
                                              vehicleTypeList.add(
                                                  e.vehicle!.vehicleTypeId);
                                            }
                                            List rentalList = [];
                                            for (var e in data) {
                                              rentalList.add(e.id);
                                            }
                                            List vehicleIdList = [];
                                            for (var e in data) {
                                              vehicleIdList.add(e.vehicleId);
                                            }
                                            List serialNumberList = [];
                                            for (var e in data) {
                                              serialNumberList
                                                  .add(e.vehicle!.serialNumber);
                                            }
                                            return ListView.builder(
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: data.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        await Navigator.pushNamed(
                                                            context,
                                                            sepedaRunningRoute,
                                                            arguments: {
                                                              'idVehicle':
                                                                  vehicleIdList[
                                                                      index],
                                                              'idRental':
                                                                  rentalList[
                                                                      index]
                                                            });
                                                      },
                                                      child: MyContainer(
                                                          name:
                                                              '${serialNumberList[index]}',
                                                          vehicleType:
                                                              vehicleTypeList[
                                                                          index] ==
                                                                      1
                                                                  ? 'sepeda'
                                                                  : 'ATV'),
                                                    ),
                                                  );
                                                });
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }
                                          return Center(
                                              child: loadingIndicator);
                                        }),
                                  ),
                                  SizedBox(
                                    height: screenHeight(context) * 0.02,
                                  ),
                                  Text(
                                    'Tagihan',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        color: primaryColor),
                                  ),
                                  SizedBox(
                                    height: screenHeight(context) * 0.02,
                                  ),
                                  SizedBox(
                                    child: FutureBuilder<List<Ended>>(
                                        future: getListEnded(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<Ended> data = snapshot.data!;
                                            List vehicleTypeList = [];
                                            for (var e in data) {
                                              vehicleTypeList.add(
                                                  e.vehicle!.vehicleTypeId);
                                            }
                                            List rentalList = [];
                                            for (var e in data) {
                                              rentalList.add(e.id);
                                            }
                                            List vehicleIdList = [];
                                            for (var e in data) {
                                              vehicleIdList.add(e.vehicleId);
                                            }
                                            List serialNumberList = [];
                                            for (var e in data) {
                                              serialNumberList
                                                  .add(e.vehicle!.serialNumber);
                                            }
                                            return ListView.builder(
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: data.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            tagihanRoute,
                                                            arguments: {
                                                              'idVehicle':
                                                                  vehicleIdList[
                                                                      index],
                                                              'idRental':
                                                                  rentalList[
                                                                      index]
                                                            });
                                                      },
                                                      child: MyContainer(
                                                          name: data
                                                              .elementAt(0)
                                                              .vehicle!
                                                              .serialNumber!,
                                                          vehicleType: data
                                                                      .elementAt(
                                                                          0)
                                                                      .vehicle!
                                                                      .vehicleTypeId ==
                                                                  1
                                                              ? 'sepeda'
                                                              : 'ATV'),
                                                    ),
                                                  );
                                                });
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }
                                          return Center(
                                              child: loadingIndicator);
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text('Cek shelter kami',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: primaryColor)),
                        SizedBox(
                          height: screenHeight(context) * 0.02,
                        ),
                        Container(
                          height: screenHeight(context) * 0.4,
                          width: screenWidth(context) * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GoogleMap(
                            markers: marker,
                            zoomControlsEnabled: true,
                            zoomGesturesEnabled: true,
                            tiltGesturesEnabled: true,
                            mapToolbarEnabled: true,
                            circles: Set.from([
                              Circle(
                                strokeColor: Colors.transparent,
                                fillColor: Color.fromRGBO(255, 54, 54, 0.2),
                                circleId: CircleId('1'),
                                center: LatLng(latitude, longitude),
                                radius: 500,
                              )
                            ]),
                            onMapCreated: (GoogleMapController controller) {
                              setState(() {
                                marker.add(Marker(
                                    // icon: iconMarker,
                                    infoWindow: const InfoWindow(
                                        title: 'SHELTER KENDARAAN'),
                                    markerId: MarkerId('id-1'),
                                    position: LatLng(latitude, longitude)));
                              });
                            },
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(-4.5419856, 105.09096),
                              zoom: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight(context) * 0.1,
                        )
                      ],
                    );
                  }
                  return Center(child: loadingIndicator);
                })),
      ),
    );
  }

  Future<List<Waiting>> getListPesanan() async {
    Uri url = Uri.parse(AppUrl.getAllVehicleAPI);
    // var jsonResponse;
    // var tokenResponse = await storage.read(key: keyToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
    if (res.statusCode == 200) {
      List waitingList = json.decode(res.body)['waiting'];
      // List userList = [];
      // waitingList.forEach((element) {
      //   userList.add(element['user']);
      // });
      return waitingList.map((rsList) => Waiting.fromJson(rsList)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<Ongoing>> getListBerjalan() async {
    Uri url = Uri.parse(AppUrl.getAllVehicleAPI);
    // var jsonResponse;
    // var tokenResponse = await storage.read(key: keyToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
    if (res.statusCode == 200) {
      List waitingList = json.decode(res.body)['ongoing'];
      return waitingList.map((rsList) => Ongoing.fromJson(rsList)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<Ended>> getListEnded() async {
    Uri url = Uri.parse(AppUrl.getAllVehicleAPI);
    // var tokenResponse = await storage.read(key: keyToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
    if (res.statusCode == 200) {
      List waitingList = json.decode(res.body)['ended'];
      return waitingList.map((rsList) => Ended.fromJson(rsList)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<void> logout() async {
    Uri url = Uri.parse(AppUrl.logoutAPI);
    // var tokenResponse = await storage.read(key: keyToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    var res = await http.post(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
    if (res.statusCode == 200) {
      var jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {
        // setState(() {
        //   // isLoading = false;
        // });
        prefs.remove('email');
        prefs.remove('token');
        await storage.deleteAll();
        Navigator.popAndPushNamed(context, loginRoute);
      }
    } else {
      Flushbar(
        message: res.body,
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: primaryColor,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      ).show(context);
      // setState(() {
      //   // isLoading = false;
      // });
      // print('status ${res.body}');
    }
  }

  Future<VehicleDetailModel> getVehicleDetail(int id) async {
    // var tokenResponse = await storage.read(key: keyToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    final response = await http.get(Uri.parse(AppUrl.getVehicleDetailAPI(id)),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
    if (response.statusCode == 200) {
      // print('Berhasil mendapatkan getVehicleDetail');
      var jsonResponse = json.decode(response.body);
      // print('==$id');
      Navigator.pushNamed(context, sepedaDetailRoute, arguments: {'id': id});
      return VehicleDetailModel.fromJson(jsonResponse);
    } else {
      Flushbar(
        message: response.body,
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: primaryColor,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      ).show(context);
      // setState(() {
      //   // isLoading = false;
      // });
      // print('status ${response.body}');
    }
    return json.decode(response.body);
  }

  double longitude = 105.09096;
  double latitude = -4.5419856;
  late GoogleMapController mapController;

  Future<ProfileModel> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    final response = await http.get(Uri.parse(AppUrl.getProfileAPI),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return ProfileModel.fromJson(jsonResponse);
    } else {
      Flushbar(
        message: response.body,
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: primaryColor,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      ).show(context);
      // print('status ${response.body}');
    }
    return json.decode(response.body);
  }
}

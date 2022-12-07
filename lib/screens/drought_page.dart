import 'dart:convert';

import 'package:drought_sphere/model/marker_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sphere_maps_flutter/sphere_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLng;
import '../utils/my_dialog.dart';

class DroughtPage extends StatefulWidget {
  const DroughtPage({super.key});

  @override
  State<DroughtPage> createState() => _DroughtPageState();
}

class _DroughtPageState extends State<DroughtPage> {
  final map = GlobalKey<SphereMapState>();
  double? lat, lng;
  String xxy = '';
  List<latLng.LatLng> addPicker = [];
  List<String> addPickerString = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
  }

  Future<void> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;
    locationService = await Geolocator.isLocationServiceEnabled();

    if (locationService) {
      // print('Service Location Open');
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(context, 'ไม่อนุญาตเเชร์ Location', 'โปรดแชร์ Location');
        } else {
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(context, 'ไม่อนุญาตเเชร์ Location', 'โปรดแชร์ Location');
        } else {
          findLatLng();
        }
      }
    } else {
      // print('Service Location Close');
      MyDialog().alertLocationService(context, 'Location Service ปิดอยู่?', 'กรุณาเปิด Location Service ด้วยครับ');
    }
  }

  Future<void> findLatLng() async {
    print("FindLatLong Work");
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print("lat = $lat, long = $lng");
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เช็คแล้ง'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SphereMapWidget(
              key: map,
              apiKey: "test2022",
              bundleId: "",
              eventName: [
                JavascriptChannel(
                  name: 'Location',
                  onMessageReceived: (_) async {
                    final location = await map.currentState?.call("location");
                    if (location != null) {
                      debugPrint(location.toString());
                    }
                  },
                ),
                // JavascriptChannel(
                //   name: 'OverlayUpdate',
                //   onMessageReceived: (message) {
                //     debugPrint(message.message);
                //   },
                // ),
                // JavascriptChannel(
                //   name: 'Click',
                //   onMessageReceived: (message) {
                //     xxy = (message.message).replaceAll('\$', '');
                //     // print(xxy);
                //     MarkerModel tutorial = MarkerModel.fromJson(jsonDecode(xxy));
                //     // Tutorial tutorial = Tutorial.fromJson(jsonDecode(xxy));

                //     var marker = map.currentState?.SphereObject(
                //       "Marker",
                //       id: "basic",
                //       args: [
                //         {
                //           "lon": tutorial.data?.lon,
                //           "lat": tutorial.data?.lat,
                //         },
                //         {
                //           "title": tutorial.event,
                //         }
                //       ],
                //     );
                //     // if (marker != null) {
                //     map.currentState?.call("Overlays.add", args: [marker!]);
                //     // }
                //   },
                // ),
                JavascriptChannel(
                  name: 'Click',
                  onMessageReceived: (message) {
                    xxy = (message.message).replaceAll('\$', '');
                    print(xxy);
                    MarkerModel tutorial = MarkerModel.fromJson(jsonDecode(xxy));
                    double ln = tutorial.data!.lon!;
                    double lt = tutorial.data!.lat!;
                    // addPicker.add(latLng.LatLng(lt, ln));
                    addPickerString.add('{lon: ${tutorial.data?.lon}, lat: ${tutorial.data?.lat}}');

                    // var marker = map.currentState?.SphereObject(
                    //   "Marker",
                    //   id: "basic",
                    //   args: [
                    //     {
                    //       "lon": tutorial.data?.lon,
                    //       "lat": tutorial.data?.lat,
                    //     },
                    //     {
                    //       "title": tutorial.event,
                    //     }
                    //   ],
                    // );
                    // // if (marker != null) {
                    // //   map.currentState?.call("Overlays.add", args: [marker]);
                    // // }
                    // var polygon = map.currentState?.SphereObject(
                    //   "Polygon",
                    //   id: "basic",
                    //   args: [
                    //     [
                    //       {
                    //         "lon": tutorial.data?.lon,
                    //         "lat": tutorial.data?.lat,
                    //       },
                    //       {
                    //         "lon": tutorial.data?.lon,
                    //         "lat": tutorial.data!.lat! + 1,
                    //       },
                    //       {
                    //         "lon": tutorial.data!.lon! + 1,
                    //         "lat": tutorial.data!.lat,
                    //       },
                    //     ],
                    //     {
                    //       "title": tutorial.event,
                    //     }
                    //   ],
                    // );

                    // if (polygon != null) {
                    //   map.currentState?.call("Overlays.add", args: [polygon]);
                    // }
                  },
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              print(addPickerString);

              var polygon = map.currentState?.SphereObject(
                "Polygon", id: "basic",
                args: [
                  addPickerString,
                ],
                // args: [
                //   [
                //     {
                //       "lon": 100.12664927734653,
                //       "lat": 13.635917731768345,
                //     },
                //     {
                //       "lon": 99.84100474609693,
                //       "lat": 14.238368273568753,
                //     },
                //     {
                //       "lon": 100.9231580664084,
                //       "lat": 14.323542874048258,
                //     },
                //     {
                //       "lon": 101.04950083984647,
                //       "lat": 13.710642513710113,
                //     }
                //   ]
                // ],
              );
              if (polygon != null) {
                map.currentState?.call("Overlays.add", args: [polygon]);
                print(polygon);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}

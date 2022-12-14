import 'dart:convert';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:drought_sphere/model/marker_model.dart';
import 'package:drought_sphere/utils/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:sphere_maps_flutter/sphere_maps_flutter.dart';
import '../utils/my_dialog.dart';

class DroughtPage extends StatefulWidget {
  const DroughtPage({super.key});

  @override
  State<DroughtPage> createState() => _DroughtPageState();
}

class _DroughtPageState extends State<DroughtPage> {
  static const FloatingActionButtonLocation centerDocked = _CenterDockedFloatingActionButtonLocation();
  final sphere = GlobalKey<SphereMapState>();
  double? lat, lng;
  String markerSet = '';
  List<Object> markerBoundary = [];
  int pointCount = 0;
  double? ln;
  double? lt;
  bool isDrawEnabled = false;
  bool isClearEnabled = false;
  int visit = 0;
  bool mapZoom = false;

  // //-- map location
  // late CenterOnLocationUpdate _centerOnLocationUpdate;
  // late StreamController<double> _centerCurrentLocationStreamController;

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
        title: const Text('Polygon Sphere'),
      ),
      body: Stack(
        children: [
          SphereMapWidget(
            key: sphere,
            apiKey: "test2022",
            bundleId: "",
            eventName: [
              JavascriptChannel(
                name: 'Ready',
                onMessageReceived: (_) {
                  sphere.currentState?.call("Ui.LayerSelector.visible", args: [false]);
                  // sphere.currentState?.call("Ui.DPad.visible", args: [false]);
                },
              ),
              JavascriptChannel(
                name: 'Click',
                onMessageReceived: (message) {
                  markerSet = (message.message).replaceAll('\$', '');
                  MarkerModel tutorial = MarkerModel.fromJson(jsonDecode(markerSet));

                  ln = tutorial.data!.lon!;
                  lt = tutorial.data!.lat!;

                  pointCount = pointCount + 1;
                  if (pointCount >= 3) {
                    setState(() {
                      isDrawEnabled = true;
                    });
                  }
                  markerBoundary.add({
                    "lon": ln,
                    "lat": lt,
                  });

                  var marker = Sphere.SphereObject(
                    "Marker",
                    args: [
                      {
                        "lon": ln,
                        "lat": lt,
                      },
                      {
                        "draggable": true,
                        "zindex": 999,
                      },
                    ],
                  );
                  sphere.currentState?.call("Overlays.add", args: [marker]);
                },
              ),
            ],
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              child: FloatingActionButton.small(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () {
                  Dialogs.bottomMaterialDialog(
                    msg: 'Are you sure? you can\'t undo this action',
                    title: 'Delete',
                    context: context,
                    color: Colors.black,
                    actions: [
                      IconsOutlineButton(
                        onPressed: () {
                          markerBoundary.clear();
                          pointCount = 0;
                          sphere.currentState?.call("Overlays.clear");
                          setState(() {
                            isDrawEnabled = false;
                            isClearEnabled = false;
                          });
                          Navigator.of(context).pop();
                        },
                        text: 'Clear',
                        iconData: Icons.cancel_outlined,
                        textStyle: TextStyle(color: Colors.grey),
                        iconColor: Colors.grey,
                      ),
                      IconsButton(
                        onPressed: () {
                          var polygon = Sphere.SphereObject(
                            "Polygon",
                            args: [
                              markerBoundary,
                            ],
                          );
                          if (pointCount >= 3) {
                            sphere.currentState?.call("Overlays.add", args: [polygon]);
                            Navigator.of(context).pop();
                            setState(() {
                              isDrawEnabled = false;
                              isClearEnabled = true;
                            });
                          }
                        },
                        text: 'Draw',
                        iconData: Icons.delete,
                        color: Colors.red,
                        textStyle: TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                      ),
                    ],
                  );
                },
                child: Icon(
                  Icons.layers_rounded,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          mapZoom = !mapZoom;
          if (mapZoom == true) {
            final marker = Sphere.SphereObject("Marker", args: [
              {
                'lon': lng,
                'lat': lat,
              },
              {
                "title": "Custom Marker",
                "icon": {
                  "html": 'test',
                  "offset": {
                    "x": 18,
                    "y": 21,
                  }
                },
                "popup": {"html": "<div>popup</div>"}
              }
            ]);
            sphere.currentState?.call("Overlays.add", args: [marker]);
            sphere.currentState?.call("location", args: [
              {
                'lon': lng,
                'lat': lat,
              }
            ]);
          } else {
            print('click2');
          }
        },
        mini: true,
        child: const Icon(Icons.location_searching_sharp),
      ),
      bottomNavigationBar: BottomBarFloating(
        items: const [
          TabItem(icon: Icons.rice_bowl_rounded, title: 'ข้าว'),
          TabItem(icon: Icons.filter_frames_rounded, title: 'ข้าวโพด'),
          TabItem(icon: Icons.home, title: ''),
          TabItem(icon: Icons.dining_sharp, title: 'มันสำปะหลัง'),
          TabItem(icon: Icons.dinner_dining_rounded, title: 'อ้อย'),
        ],
        backgroundColor: Colors.blue,
        color: Colors.white,
        colorSelected: Colors.black38,
        indexSelected: visit,
        paddingVertical: 24,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}

// Widget selectBaseMapMenu2(BuildContext context) {
//   return Column(children: [
//     Container(
//       child: SizedBox(
//         height: 100,
//         child: ListView.builder(
//           shrinkWrap: true,
//           padding: EdgeInsets.all(10),
//           physics: const BouncingScrollPhysics(
//             parent: AlwaysScrollableScrollPhysics(),
//           ),
//           // itemCount: items.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             return Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     // setState(() {
//                     //   currentBaseMap = index;
//                     // });
//                   },
//                   child: AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     margin: EdgeInsets.all(5),
//                     width: 90,
//                     height: 60,
//                     decoration: BoxDecoration(
//                         // color: currentBaseMap == index
//                         //     ? Constant.dark
//                         //     : Constant.light,
//                         // borderRadius: currentBaseMap == index
//                         //     ? BorderRadius.circular(15)
//                         //     : BorderRadius.circular(10),
//                         // border: currentBaseMap == index
//                         //     ? Border.all(color: Colors.blue, width: 2)
//                         //     : null
//                         ),
//                     child: Center(
//                         // child: Text(
//                         //   items[index],
//                         // ),
//                         ),
//                   ),
//                 ),
//                 Visibility(
//                   // visible: currentBaseMap == index,
//                   child: Container(
//                     width: 8,
//                     height: 8,
//                     decoration: BoxDecoration(
//                       color: Colors.amber,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     ),
//   ]);
// }

class _CenterDockedFloatingActionButtonLocation extends _DockedFloatingActionButtonLocation {
  const _CenterDockedFloatingActionButtonLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width) - 5;
    return Offset(fabX, getDockedY(scaffoldGeometry));
  }
}

abstract class _DockedFloatingActionButtonLocation extends FloatingActionButtonLocation {
  const _DockedFloatingActionButtonLocation();
  @protected
  double getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double maxFabY = scaffoldGeometry.scaffoldSize.height - 175;
    return maxFabY;
  }
}

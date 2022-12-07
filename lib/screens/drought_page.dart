import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sphere_maps_flutter/view.dart';

import '../utils/my_dialog.dart';

class DroughtPage extends StatefulWidget {
  const DroughtPage({super.key});

  @override
  State<DroughtPage> createState() => _DroughtPageState();
}

class _DroughtPageState extends State<DroughtPage> {
  final map = GlobalKey<SphereMapState>();
  double? lat, lng;

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
            ),
          ),
          OutlinedButton(
            onPressed: () {
              var marker = map.currentState?.SphereObject(
                "Marker",
                id: "basic",
                args: [
                  {
                    "lon": lng,
                    "lat": lat,
                  },
                  {
                    "title": "$lat+$lng",
                    "draggable": true,
                    // "icon": Icon(Icons.abc),
                  }
                ],
              );
              if (marker != null) {
                map.currentState?.call("Overlays.add", args: [marker]);
                print(marker);
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}

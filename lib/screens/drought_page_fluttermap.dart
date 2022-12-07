import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DrougtFlutterMap extends StatefulWidget {
  const DrougtFlutterMap({super.key});

  @override
  State<DrougtFlutterMap> createState() => _DrougtFlutterMapState();
}

class _DrougtFlutterMapState extends State<DrougtFlutterMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.location_on_rounded),
      ),
    );
  }
}

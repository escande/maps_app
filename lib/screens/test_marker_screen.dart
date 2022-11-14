import 'package:flutter/material.dart';
import 'package:maps_app/markers/aa_markers.dart';
import '../markers/start_marker.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: 350,
        height: 150,
        //color: Colors.red,
        child: CustomPaint(
          painter: EndMarkerPainter(
              destination: 'Rooster Rest & Snack Bar Hola Mundo', kilometers: 50),
        ),
      )),
    );
  }
}

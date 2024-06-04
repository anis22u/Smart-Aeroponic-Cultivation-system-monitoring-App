import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'firbasepointer.dart';

class GaugeSolutionWidget extends StatefulWidget {
  const GaugeSolutionWidget({Key? key}) : super(key: key);

  @override
  _GaugeSolutionWidgetState createState() => _GaugeSolutionWidgetState();
}

class _GaugeSolutionWidgetState extends State<GaugeSolutionWidget> {
  double gaugeValue = 0.0;

  @override
  void initState() {
    super.initState();
    listenToFirebaseData();
  }

  void listenToFirebaseData() {
    DatabaseReference disRef =
        FirebaseDatabase.instance.ref().child("Ultrasonic Level");

    disRef.onValue.listen((event) {
      // print("Firebase Event: ${event.snapshot.value}");
      if (event.snapshot.value != null) {
        setState(() {
          var value = event.snapshot.value as Map<dynamic, dynamic>;
          //print("Value Before Parsing: $value");
          var distance = value?['Distance'];
          //print("Distance Value: $distance");
          gaugeValue = double.tryParse(distance!.toString()) ?? 0.0;
          // print("Gauge Value: $gaugeValue");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      /* title: GaugeTitle(
        text: 'Solution level',
        textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),*/
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 23,
          // radiusFactor: 0.5,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 5,
              color: Colors.green,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 5,
              endValue: 10,
              color: Colors.yellow,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 10,
              endValue: 15,
              color: Colors.orange,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 15,
              endValue: 20,
              color: Color.fromARGB(255, 113, 186, 247),
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 20,
              endValue: 23,
              color: Colors.red,
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: gaugeValue,
            ), // Use NeedlePointer or any suitable pointer for your gauge
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  '${gaugeValue.toString()} cm',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:percent_indicator/percent_indicator.dart';

class solutionpercentage extends StatefulWidget {
  const solutionpercentage({super.key});

  @override
  State<solutionpercentage> createState() => _solutionpercentageState();
}

class _solutionpercentageState extends State<solutionpercentage> {
  @override
  Widget build(BuildContext context) {
    var disref = FirebaseDatabase.instance.ref("Ultrasonic Level");

    return Container(
      //width: MediaQuery.of(context).size.width - 40,
      width: 290,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey[300],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 15.0,
            offset: Offset(4.0, 4.0),
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 15.0,
            offset: Offset(-4.0, -4.0),
            spreadRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.circular(21),
      ),
      child: FirebaseAnimatedList(
        query: disref,
        itemBuilder: (context, snapshot, animation, index) {
          final student = snapshot.key;
          final value = double.parse((snapshot.value ?? 0).toString());
          final maximumValue = 24; // Set the desired maximum value
          final percent = (1 - (value / maximumValue)) * 100;
          final displayedPercent = percent.clamp(0, 100);

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    animation: true,
                    animationDuration: 2000,
                    radius: 120,
                    lineWidth: 20,
                    percent: percent / 100.0,
                    progressColor: Color.fromARGB(255, 22, 143, 42),
                    backgroundColor: Color.fromARGB(113, 22, 245, 14),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      '${percent.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    'Solution percentage',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

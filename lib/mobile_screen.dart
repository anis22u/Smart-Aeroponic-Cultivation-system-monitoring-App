//import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
//import 'package:smart_aeroponics/BackgroundImageContainer.dart';
import 'package:smart_aeroponics/Sensors_reading.dart';
import 'package:smart_aeroponics/Solution_data.dart';
import 'package:smart_aeroponics/fan.dart';
import 'package:smart_aeroponics/light.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_aeroponics/mistC.dart';
import 'package:smart_aeroponics/phC.dart';
import 'package:smart_aeroponics/gaugepointer/gaugeforsolution.dart';
import 'package:smart_aeroponics/gaugepointer/soluton%.dart';
import 'package:fswitch_nullsafety/fswitch_nullsafety.dart';
import 'package:smart_aeroponics/NotificationWindow.dart';
//import 'package:syncfusion_flutter_gauges/gauges.dart';

class MobileScreen extends StatefulWidget {
  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  bool showNotifications = false;

  void openNotificationWindow() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationWindow(),
      ),
    );
  }

  //final _formKey = GlobalKey<FormState>();
  bool isautoon = false;
  @override
  Widget build(BuildContext context) {
    var AutoRef = FirebaseDatabase.instance.ref("Automatic");

    // for auto
    changeautostatusToon() {
      AutoRef.update({"Auto": "On"});
    }

    changeautostatusTooff() {
      AutoRef.update({"Auto": "Off"});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Smart Aeroponic System",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 22, 143, 42),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: openNotificationWindow,
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () {
            // Handle home icon button press
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                //Auto

                Container(
                  margin: EdgeInsets.all(8),
                  height: 110,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 22, 143, 42),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 15.0,
                          offset: Offset(4.0, 4.0),
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 15.0,
                          offset: Offset(-4.0, -4.0),
                          spreadRadius: 1.0),
                    ],
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(
                          1000.0), // Adjust the radius value as needed
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Automatic status",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                          query: AutoRef,
                          itemBuilder: (context, snapshot, animation, index) {
                            final student = snapshot.key;
                            return ListTile(
                              title: Text(
                                student.toString() +
                                    ": " +
                                    snapshot.value.toString(),
                                style: TextStyle(fontSize: 17),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: FSwitch(
                          width: 85.0,
                          height: 40.538,
                          onChanged: (value) {
                            setState(() {
                              isautoon = value;
                            });
                            if (isautoon) {
                              changeautostatusToon();
                            } else {
                              changeautostatusTooff();
                            }
                          },
                          closeChild: Text(
                            "Off",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          openChild: Text(
                            "On",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          openColor: Colors.red,
                          shadowColor: Colors.black.withOpacity(0.5),
                          shadowBlur: 3.0,

                          //closeColor: Colors.green.withOpacity(0.5),
                          open: isautoon,
                        ),
                      ),
                    ],
                  ),
                ),

                // gaugepoiter
                Container(
                  width: 290, // Adjust the width as per your requirements
                  height: 280, // Adjust the height as per your requirements
                  decoration: BoxDecoration(
                    shape: BoxShape
                        .rectangle, // Change the shape to the desired beautiful shape
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 15.0,
                          offset: Offset(4.0, 4.0),
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 15.0,
                          offset: Offset(-4.0, -4.0),
                          spreadRadius: 1.0),
                    ],
                    borderRadius: BorderRadius.circular(21),

                    // Change the color of the container
                  ),

                  child: Stack(
                    children: [
                      GaugeSolutionWidget(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            'Ultrasonic Level',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // fan and grow light

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Fan
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => fan(),
                          ),
                        );
                      },
                      child: Container(
                        width: 125, // Adjust the width as per your requirements
                        height:
                            130, // Adjust the height as per your requirements
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .rectangle, // Change the shape to the desired beautiful shape
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                blurRadius: 15.0,
                                offset: Offset(4.0, 4.0),
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 15.0,
                                offset: Offset(-4.0, -4.0),
                                spreadRadius: 1.0),
                          ],
                          borderRadius: BorderRadius.circular(21),
                          // Change the color of the container
                        ),

                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  12), // Change the border radius to the desired shape
                              child: SvgPicture.asset(
                                'assets/icons/fan_icon.svg', // Replace with the path to your SVG icon
                                width: 120, // Adjust the width of the SVG icon
                                height:
                                    120, // Adjust the height of the SVG icon
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Text(
                                'Fan',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Change the color of the text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                        width: 25), // Add a small distance between the buttons

                    // light
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => light(),
                          ),
                        );
                      },
                      child: Container(
                        width: 125, // Adjust the width as per your requirements
                        height:
                            130, // Adjust the height as per your requirements
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .rectangle, // Change the shape to the desired beautiful shape
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                blurRadius: 15.0,
                                offset: Offset(4.0, 4.0),
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 15.0,
                                offset: Offset(-4.0, -4.0),
                                spreadRadius: 1.0),
                          ],
                          borderRadius: BorderRadius.circular(21),
                          // Change the color of the container
                        ),

                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  12), // Change the border radius to the desired shape
                              child: SvgPicture.asset(
                                'assets/icons/growl_icon.svg', // Replace with the path to your SVG icon
                                width: 100, // Adjust the width of the SVG icon
                                height:
                                    100, // Adjust the height of the SVG icon
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Text(
                                'Grow light',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Change the color of the text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // solution   and   sensor reading

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // solution
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => solutiondata(),
                          ),
                        );
                      },
                      child: Container(
                        width: 125, // Adjust the width as per your requirements
                        height:
                            130, // Adjust the height as per your requirements
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .rectangle, // Change the shape to the desired beautiful shape
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                blurRadius: 15.0,
                                offset: Offset(4.0, 4.0),
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 15.0,
                                offset: Offset(-4.0, -4.0),
                                spreadRadius: 1.0),
                          ],
                          borderRadius: BorderRadius.circular(21),
                          // Change the color of the container
                        ),

                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  12), // Change the border radius to the desired shape
                              child: SvgPicture.asset(
                                'assets/icons/water_icon.svg', // Replace with the path to your SVG icon
                                width: 100, // Adjust the width of the SVG icon
                                height:
                                    100, // Adjust the height of the SVG icon
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Text(
                                'Solution Data',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Change the color of the text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                        width: 25), // Add a small distance between the buttons

                    // sensor reading
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => sensorreadings(),
                          ),
                        );
                      },
                      child: Container(
                        width: 125, // Adjust the width as per your requirements
                        height:
                            130, // Adjust the height as per your requirements
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .rectangle, // Change the shape to the desired beautiful shape
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                blurRadius: 15.0,
                                offset: Offset(4.0, 4.0),
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 15.0,
                                offset: Offset(-4.0, -4.0),
                                spreadRadius: 1.0),
                          ],
                          borderRadius: BorderRadius.circular(21),
                          // Change the color of the container
                        ),

                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  12), // Change the border radius to the desired shape
                              child: SvgPicture.asset(
                                'assets/icons/tem_icon.svg', // Replace with the path to your SVG icon
                                width: 100, // Adjust the width of the SVG icon
                                height:
                                    100, // Adjust the height of the SVG icon
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Text(
                                'Sensor reading',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Change the color of the text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // mist and ph condition

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // mist
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => mistcondition(),
                          ),
                        );
                      },
                      child: Container(
                        width: 125, // Adjust the width as per your requirements
                        height:
                            130, // Adjust the height as per your requirements
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .rectangle, // Change the shape to the desired beautiful shape
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                blurRadius: 15.0,
                                offset: Offset(4.0, 4.0),
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 15.0,
                                offset: Offset(-4.0, -4.0),
                                spreadRadius: 1.0),
                          ],
                          borderRadius: BorderRadius.circular(21),
                          // Change the color of the container
                        ),

                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  12), // Change the border radius to the desired shape
                              child: SvgPicture.asset(
                                'assets/icons/mist_icon.svg', // Replace with the path to your SVG icon
                                width: 100, // Adjust the width of the SVG icon
                                height:
                                    100, // Adjust the height of the SVG icon
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Text(
                                'Mist',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Change the color of the text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                        width: 25), // Add a small distance between the buttons

                    // ph condition
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => phcondition(),
                          ),
                        );
                      },
                      child: Container(
                        width: 125, // Adjust the width as per your requirements
                        height:
                            130, // Adjust the height as per your requirements
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .rectangle, // Change the shape to the desired beautiful shape
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                blurRadius: 15.0,
                                offset: Offset(4.0, 4.0),
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 15.0,
                                offset: Offset(-4.0, -4.0),
                                spreadRadius: 1.0),
                          ],
                          borderRadius: BorderRadius.circular(21),
                          // Change the color of the container
                        ),

                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  12), // Change the border radius to the desired shape
                              child: SvgPicture.asset(
                                'assets/icons/phc_icon.svg', // Replace with the path to your SVG icon
                                width: 100, // Adjust the width of the SVG icon
                                height:
                                    100, // Adjust the height of the SVG icon
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Text(
                                'ph conditions',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Change the color of the text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // solution level (%)
                //solutionpercentage(),
                SingleChildScrollView(
                  child: solutionpercentage(),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

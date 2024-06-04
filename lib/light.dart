import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:smart_aeroponics/BackgroundImageContainer.dart';

import 'package:flutter/material.dart';

class light extends StatefulWidget {
  const light({super.key});

  @override
  State<light> createState() => _lightState();
}

class _lightState extends State<light> {
  bool islighton = false;
  @override
  Widget build(BuildContext context) {
    var LightRef = FirebaseDatabase.instance.ref("Light");
    var LightTimeRef = FirebaseDatabase.instance.ref("Light-Time");

    final TextEditingController _lightTimeOn = TextEditingController();
    final TextEditingController _lightTimeOff = TextEditingController();

    changeLightStatuson() {
      LightRef.update({"Power": "On"});
    }

    changeLightStatusToOff() {
      LightRef.update({"Power": "Off"});
    }

    changeLightTimeOff() {
      LightTimeRef.update({"Off": _lightTimeOff.text});
    }

    changeLightTimeOn() {
      LightTimeRef.update({"On": _lightTimeOn.text});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LIGHT",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 22, 143, 42),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                //light status
                Container(
                  margin: EdgeInsets.all(8),
                  height: 200,
                  width: 300,
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Light Status",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: LightRef,
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
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              islighton ? Colors.red : Colors.green,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              islighton = !islighton;
                            });
                            if (islighton) {
                              changeLightStatuson();
                            } else {
                              changeLightStatusToOff();
                            }
                          },
                          icon: Icon(islighton ? Icons.power_off : Icons.power),
                          label: Text(islighton ? "Turn Off" : "Turn On"),
                        ),
                      ),
                    ],
                  ),
                ),
                // light time
                Container(
                  margin: EdgeInsets.all(8),
                  height: 300,
                  width: 300,
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Light Time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: LightTimeRef,
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
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(1.0),
                                    //spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                controller: _lightTimeOn,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  hintText: "Set Light Time On",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                changeLightTimeOn();
                              },
                              child: Text("set Light on"),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(
                                    3), // Adjust the elevation value as per your preference
                                shadowColor: MaterialStateProperty.all(
                                    Colors.black), // Set the shadow color
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(1.0),
                                    //spreadRadius: 2,
                                    blurRadius: 4,
                                    //offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                controller: _lightTimeOff,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  hintText: "Set Light Time Off",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                changeLightTimeOff();
                              },
                              child: Text("set Light Time off"),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(
                                    3), // Adjust the elevation value as per your preference
                                shadowColor: MaterialStateProperty.all(
                                    Colors.black), // Set the shadow color
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

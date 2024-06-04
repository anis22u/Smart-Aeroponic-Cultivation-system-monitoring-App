import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:smart_aeroponics/BackgroundImageContainer.dart';

import 'package:flutter/material.dart';

class fan extends StatefulWidget {
  const fan({super.key});

  @override
  State<fan> createState() => _fanState();
}

class _fanState extends State<fan> {
  bool isfanon = false;
  bool isufanon = false;
  @override
  Widget build(BuildContext context) {
    var FansRef = FirebaseDatabase.instance.ref("Fan");
    var FANconditionRef = FirebaseDatabase.instance.ref("Fan Condition");
    var ufanref = FirebaseDatabase.instance.ref('Upper Fan');
    var ufanconditionref = FirebaseDatabase.instance.ref("Upper Fan Condition");

    final TextEditingController _FANconditionTemperature =
        TextEditingController();
    final TextEditingController _UpperFANconditionTemperature =
        TextEditingController();

    changFanToOn() {
      FansRef.update({"Power": "On"});
    }

    changFanToOff() {
      FansRef.update({"Power": "Off"});
    }

    changeFancondition() {
      FANconditionRef.update({"Temperature": _FANconditionTemperature.text});
    }

    //for upper fan

    changuFanToOn() {
      ufanref.update({"Power": "On"});
    }

    changuFanToOff() {
      ufanref.update({"Power": "Off"});
    }

    changeuFancondition() {
      ufanconditionref
          .update({"Temperature": _UpperFANconditionTemperature.text});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FAN",
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
                // lower Fan
                Container(
                  margin: EdgeInsets.all(8),
                  height: 160,
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
                          "Lower Fan Data",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: FansRef,
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
                            elevation: MaterialStateProperty.all(5),
                            backgroundColor: MaterialStateProperty.all(
                              isfanon ? Colors.red : Colors.green,
                            ),
                            shadowColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              isfanon = !isfanon;
                            });
                            if (isfanon) {
                              changFanToOn();
                            } else {
                              changFanToOff();
                            }
                          },
                          icon: Icon(isfanon ? Icons.power_off : Icons.power),
                          label: Text(isfanon ? "Turn Off" : "Turn On"),
                        ),
                      ),
                    ],
                  ),
                ),

                // lower Fan Condition
                Container(
                  margin: EdgeInsets.all(8),
                  height: 170,
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
                          " Lower Fan Condition",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: FANconditionRef,
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
                                    //offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                controller: _FANconditionTemperature,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  hintText: "Set Fan Condition",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                changeFancondition();
                              },
                              child: Text("Set Temperature"),
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
                    ],
                  ),
                ),

                // upper Fan
                Container(
                  margin: EdgeInsets.all(8),
                  height: 160,
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
                          "Upper Fan Data",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: ufanref,
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
                            elevation: MaterialStateProperty.all(5),
                            backgroundColor: MaterialStateProperty.all(
                              isufanon ? Colors.red : Colors.green,
                            ),
                            shadowColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              isufanon = !isufanon;
                            });
                            if (isufanon) {
                              changuFanToOn();
                            } else {
                              changuFanToOff();
                            }
                          },
                          icon: Icon(isufanon ? Icons.power_off : Icons.power),
                          label: Text(isufanon ? "Turn Off" : "Turn On"),
                        ),
                      ),
                    ],
                  ),
                ),

                // lower Fan Condition
                Container(
                  margin: EdgeInsets.all(8),
                  height: 170,
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
                          " Upper Fan Condition",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: ufanconditionref,
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
                                    //offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                controller: _UpperFANconditionTemperature,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  hintText: "Set Fan Condition",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                changeuFancondition();
                              },
                              child: Text("Set Temperature"),
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

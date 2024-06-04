import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class mistcondition extends StatefulWidget {
  const mistcondition({super.key});

  @override
  State<mistcondition> createState() => _mistconditionState();
}

class _mistconditionState extends State<mistcondition> {
  bool isPumpon = false;
  @override
  Widget build(BuildContext context) {
    var MistTimeRef = FirebaseDatabase.instance.ref("Mist-Time");
    var PumpRef = FirebaseDatabase.instance.ref("Pump");

    final TextEditingController _mistTimeOffTime = TextEditingController();

    final TextEditingController _mistRun = TextEditingController();

    changeMistimeOffTime() {
      MistTimeRef.update({'Offtime': _mistTimeOffTime.text});
    }

    RunStatus() {
      MistTimeRef.update({"Run": _mistRun.text});
    }

    changePumpStatusToOn() {
      PumpRef.update({"Power": "On"});
    }

    changePumpStatusToOff() {
      PumpRef.update({"Power": "Off"});
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Mist Time",
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
                  //Pump
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
                            "Pump Status",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: FirebaseAnimatedList(
                              query: PumpRef,
                              itemBuilder:
                                  (context, snapshot, animation, index) {
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
                                isPumpon ? Colors.red : Colors.green,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isPumpon = !isPumpon;
                              });
                              if (isPumpon) {
                                changePumpStatusToOn();
                              } else {
                                changePumpStatusToOff();
                              }
                            },
                            icon:
                                Icon(isPumpon ? Icons.power_off : Icons.power),
                            label: Text(isPumpon ? "Turn Off" : "Turn On"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Mist Time
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
                            "Mist Time",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: FirebaseAnimatedList(
                              query: MistTimeRef,
                              itemBuilder:
                                  (context, snapshot, animation, index) {
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
                                  controller: _mistTimeOffTime,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    hintText: "Mist Off",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  changeMistimeOffTime();
                                },
                                child: Text("Set Mist Off"),
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
                                  controller: _mistRun,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    hintText: "Mist Run",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  RunStatus();
                                },
                                child: Text("Set Mist Run"),
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
        ));
  }
}

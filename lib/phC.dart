import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class phcondition extends StatefulWidget {
  const phcondition({super.key});

  @override
  State<phcondition> createState() => _phconditionState();
}

class _phconditionState extends State<phcondition> {
  @override
  Widget build(BuildContext context) {
    var PHConditionRef = FirebaseDatabase.instance.ref("pH Conditions");
    var PHLEVELRef = FirebaseDatabase.instance.ref("pH Alert");

    final TextEditingController _phConditionMax = TextEditingController();
    final TextEditingController _phConditionMin = TextEditingController();

    changePhConditionMax() {
      PHConditionRef.update({"Max pH": _phConditionMax.text});
    }

    changePhConditionMin() {
      PHConditionRef.update({"Min pH": _phConditionMin.text});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ph condition",
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
                //ph condition
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
                          "PH Condition",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: PHConditionRef,
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
                                    decimal: true, signed: false),
                                controller: _phConditionMax,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  hintText: "Set PH max",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                changePhConditionMax();
                              },
                              child: Text("Max pH"),
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
                                    // spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true, signed: false),
                                controller: _phConditionMin,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  hintText: "Set PH min",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                changePhConditionMin();
                              },
                              child: Text("Min pH"),
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

                // ph level

                Container(
                  margin: EdgeInsets.all(8),
                  height: 100,
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
                          "PH Alert",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: PHLEVELRef,
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

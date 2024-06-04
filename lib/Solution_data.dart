import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:smart_aeroponics/BackgroundImageContainer.dart';

class solutiondata extends StatefulWidget {
  const solutiondata({super.key});

  @override
  State<solutiondata> createState() => _solutiondataState();
}

class _solutiondataState extends State<solutiondata> {
  @override
  Widget build(BuildContext context) {
    var SolutionLevelRef = FirebaseDatabase.instance.ref("Solution Level");
    var SolutionPHRef = FirebaseDatabase.instance.ref("Solution pH");
    var SolutionleveconditionRef =
        FirebaseDatabase.instance.ref("Solution Level Condition");
    var UltraSonicLevelRef = FirebaseDatabase.instance.ref("Ultrasonic Level");

    final TextEditingController _LevelThreshold = TextEditingController();

    changeThresholdlevel() {
      SolutionleveconditionRef.update(
          {"Level Threshold": _LevelThreshold.text});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Solution Data",
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
                // solution level
                Container(
                  margin: EdgeInsets.all(8),
                  height: 110,
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
                          "Solution Level",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: SolutionLevelRef,
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

                // Solution level condition
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
                          "Solution Level condition",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: SolutionleveconditionRef,
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
                                controller: _LevelThreshold,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  hintText: "Set Threshold",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                changeThresholdlevel();
                              },
                              child: Text("Set Threshold"),
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

                //solution ph
                Container(
                  margin: EdgeInsets.all(8),
                  height: 110,
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
                          "Solution PH",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: SolutionPHRef,
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
                // ultrasonic
                Container(
                  margin: EdgeInsets.all(8),
                  height: 110,
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
                          "Ultrasonic level",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: UltraSonicLevelRef,
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

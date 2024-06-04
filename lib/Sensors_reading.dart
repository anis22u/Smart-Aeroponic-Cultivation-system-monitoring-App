import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:smart_aeroponics/BackgroundImageContainer.dart';

class sensorreadings extends StatefulWidget {
  const sensorreadings({super.key});

  @override
  State<sensorreadings> createState() => _sensorreadingsState();
}

class _sensorreadingsState extends State<sensorreadings> {
  @override
  Widget build(BuildContext context) {
    var DHTLowerRef = FirebaseDatabase.instance.ref("DHTLower");
    var DHTUpperRef = FirebaseDatabase.instance.ref("DHTUpper");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sensors reading",
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
                //DHTLOWER

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
                          "DHT LOWER DATA",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: DHTLowerRef,
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

                //DHT UPPER DATA
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
                          "DHT UPPER DATA",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: DHTUpperRef,
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

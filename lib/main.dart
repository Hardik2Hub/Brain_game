import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picturematch/notimelimit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: picture(),
    debugShowCheckedModeBanner: false,
  ));
}

class picture extends StatefulWidget {
  static SharedPreferences? prefs;

  @override
  State<picture> createState() => _pictureState();
}

class _pictureState extends State<picture> {
  int level = 0;
  List h = [];

  @override
  void initState() {
    super.initState();
    getpref();
  }

  getpref() async {
    picture.prefs = await SharedPreferences.getInstance();
    level = picture.prefs!.getInt('level') ?? 0;

    h = List.filled(60, '');

    for (int i = 0; i < level; i++) {
      h[i] = picture.prefs!.getString("level_st$i") ?? '';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select mode",
                style: TextStyle(color: Colors.white),
              ),
              Row(
                children: [
                  Icon(Icons.volume_up),
                  Icon(Icons.density_medium_outlined),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("imgs/fondo_imagenes.png"),
                  ),
                ),
                child: Column(children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 50, right: 50, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border:
                                    Border.all(width: 3, color: Colors.teal),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                  builder: (context) {
                                                    return notimelimit();
                                                  },
                                                ));
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: double.infinity,
                                                child: Text("NO TIME LIMIT",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white)),
                                                margin: EdgeInsets.all(10),
                                                color: Colors.teal,
                                              )))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        alignment: Alignment.center,
                                        height: double.infinity,
                                        child: Text("NORMAL",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                        margin: EdgeInsets.all(10),
                                        color: Colors.teal,
                                      ))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        alignment: Alignment.center,
                                        height: double.infinity,
                                        child: Text("HARD",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                        margin: EdgeInsets.all(10),
                                        color: Colors.teal,
                                      ))
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 80, right: 80, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border:
                                    Border.all(width: 3, color: Colors.teal),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        alignment: Alignment.center,
                                        height: double.infinity,
                                        child: Text("REMOVE ADS",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                        margin: EdgeInsets.all(10),
                                        color: Colors.teal,
                                      ))
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 40, right: 40, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border:
                                    Border.all(width: 3, color: Colors.teal),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: double.infinity,
                                          child: Text("SHARE",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          margin: EdgeInsets.all(5),
                                          color: Colors.teal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: double.infinity,
                                          child: Text("MORE GAMES",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          margin: EdgeInsets.all(5),
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Are you Exit"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return picture();
                        },
                      ));
                    },
                    child: Text("CANCLE")),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          exit(0);
                        },
                      ));
                    },
                    child: Text("OK")),
              ],
            );
          },
        );
        return true;
      },
    );
  }
}

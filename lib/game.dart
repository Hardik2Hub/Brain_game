import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picturematch/main.dart';
import 'package:picturematch/notimelimit.dart';

class game extends StatefulWidget {
  int i;

  game(this.i);

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  double time = 5;
  List l = [];
  List l1 = [];
  List<bool> temp = [];
  int a = 0;
  int x = 1;
  int pos1 = 0, pos2 = 0;
  int cnt = 0;
  bool s = false;
  int level = 0;
  List h = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("After 5 Second Hide Picture"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    timecount();
                    _initImages();
                    s = true;
                  },
                  child: Center(child: Text("GO")))
            ],
          );
        },
      );
    });
    temp = List.filled(12, true);
    level = picture.prefs!.getInt('level') ?? 0;

    h = List.filled(60, '');

    for (int i = 0; i < level; i++) {
      h[i] = picture.prefs!.getString("level_st$i") ?? '';
    }

    setState(() {});
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('img/'))
        .where((String key) => key.contains('.png'))
        .toList();
    setState(() {
      l = imagePaths;

      l.shuffle();
      for (int i = 0; i < 6; i++) {
        l1.add(l[i]);
        l1.add(l[i]);
      }
      l1.shuffle();
    });
  }

  timecount() async {
    for (int i = 5; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      if (i == 0) {
        temp = List.filled(12, false);
      }
      a = i;
      setState(() {});
    }
    for (int i = 0; i <= 500;) {
      await Future.delayed(Duration(seconds: 1));
      if (cnt != 6) {
        i++;
      }
      a = i;
      setState(() {});
    }
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
                "Time=${a}",
                style: TextStyle(color: Colors.white),
              ),
              Row(
                children: [
                  Container(child: Text("NO TIME LIMIT")),
                  Icon(Icons.volume_up),
                  Icon(Icons.density_medium_outlined),
                ],
              ),
            ],
          ),
        ),
        body: Column(children: [
          Expanded(
            child: (s)
                ? SliderTheme(
                    child: Slider(
                      value: a.toDouble(),
                      min: 0,
                      max: 500,
                      activeColor: Colors.teal,
                      inactiveColor: Colors.grey,
                      onChanged: (value) {
                        a = value.toInt();
                        setState(() {});
                      },
                    ),
                    data: SliderTheme.of(context).copyWith(
                        thumbColor: Colors.transparent,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 0.0)))
                : Text(""),
          ),
          Expanded(
              flex: 5,
              child: GridView.builder(
                itemCount: l1.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisExtent: 100),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (!temp[index] && x == 1) {
                        temp[index] = true;
                        x = 2;
                        pos1 = index;
                      }
                      if (!temp[index] && x == 2) {
                        temp[index] = true;
                        x = 1;
                        pos2 = index;

                        if (l1[pos1] == l1[pos2]) {
                          cnt++;
                          if (cnt == 6) {
                            if (h[widget.i - 1] == "") {
                              picture.prefs!.setString('level_st$level', '${a}');
                              level++;
                              picture.prefs!.setInt('level', level);
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Center(child: Text("NEW RECORD!")),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Text("Level ${widget.i}")),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Center(child: Text("Second ${a}")),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Center(child: Text("Well Done")),
                                          ],
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return notimelimit();
                                                  },
                                                ));
                                          },
                                          child: Center(child: Text("OK")))
                                    ],
                                  );
                                },
                              );
                            } else {
                              if (a < int.parse("${h[widget.i - 1]}")) {
                                picture.prefs!.setString('level_st${widget.i - 1}', '${a}');
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Center(child: Text("NEW RECORD!")),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text("Level ${widget.i}")),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Center(child: Text("Second ${a}")),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Center(child: Text("Well Done")),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return notimelimit();
                                                    },
                                                  ));
                                            },
                                            child: Center(child: Text("OK")))
                                      ],
                                    );
                                  },
                                );
                              }
                              else
                              {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Center(child: Text("LEVEL COMPLETED")),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Center(child: Text("Congratulations !!!")),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return notimelimit();
                                                    },
                                                  ));
                                            },
                                            child: Center(child: Text("OK")))
                                      ],
                                    );
                                  },
                                );
                              }
                            }

                          }
                        } else {
                          Future.delayed(Duration(milliseconds: 150))
                              .then((value) => {
                                    temp[pos1] = false,
                                    temp[pos2] = false,
                                    setState(() {}),
                                  });
                        }
                      }
                      setState(() {});
                    },
                    child: Visibility(
                      visible: temp[index],
                      child: Container(
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('${l1[index]}')),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(width: 1)),
                      ),
                      replacement: Container(
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(width: 1)),
                      ),
                    ),
                  );
                },
              )),
        ]),
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
                    Navigator.pop(context);
                    },
                    child: Text("CANCLE")),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return notimelimit();
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

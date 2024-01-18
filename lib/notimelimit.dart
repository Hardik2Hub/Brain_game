import 'package:flutter/material.dart';
import 'package:picturematch/game.dart';
import 'package:picturematch/main.dart';

class notimelimit extends StatefulWidget {
  @override
  State<notimelimit> createState() => _notimelimitState();
}

class _notimelimitState extends State<notimelimit> {
  List t = ["MATCH 2", "MATCH 2", "MATCH 3", "MATCH 3", "MATCH 4", "MATCH 4"];

  int level = 0;
  List h = [];

  @override
  void initState() {
    super.initState();
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
                "Select level",
                style: TextStyle(color: Colors.white),
              ),
              Row(
                children: [
                  Container(child: Text("NO TIME LIMIT")),
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
                    flex: 3,
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: t.length,
                        itemBuilder: (context, myindex) {
                          return Container(
                            height: 500,
                            width: 250,
                            margin: EdgeInsets.only(
                                left: 50, right: 50, bottom: 20, top: 20),
                            decoration: BoxDecoration(
                              color: Colors.teal[50],
                              border: Border.all(width: 3, color: Colors.teal),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(children: [
                              Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    child: Text(
                                      "${t[myindex]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal,
                                          fontSize: 20),
                                    )),
                              ),
                              Divider(
                                height: 2,
                                color: Colors.teal,
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: ListView.builder(
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            if ((myindex * 10) + index <
                                                level + 1) {
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return game((myindex * 10) +
                                                      index +
                                                      1);
                                                },
                                              ));
                                            }
                                          },
                                          child: Card(
                                            color: ((myindex * 10) + index <
                                                    level + 1)
                                                ? Colors.teal
                                                : Colors.teal[50],
                                            child: ListTile(
                                              title: Center(
                                                child: ((myindex * 10) + index <
                                                        level)
                                                    ? Text(
                                                        "LEVEL ${(myindex * 10) + index + 1}  ${h[(myindex * 10) + index]} Sec",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                      )
                                                    : Text(
                                                        "LEVEL ${(myindex * 10) + index + 1}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                              ),
                            ]),
                          );
                        },
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
                      Navigator.pop(context);
                    },
                    child: Text("CANCLE")),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return picture();
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

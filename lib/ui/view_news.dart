import 'dart:convert';

import 'package:exam3/models/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewPage extends StatefulWidget {
  int index;

  ViewPage({required this.index});
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  double sizeofText = 15;
  int son = 10;
  Color colorForbody = Colors.white;
  Color colorOfTextandIcon = Colors.black;
  Icon icon = Icon(
    CupertinoIcons.moon,
    color: Colors.black,
  );
  int bottomNvabaritem = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [

        BottomNavigationBarItem(icon: Icon(Icons.home),
        label: ""
        ),
        BottomNavigationBarItem(icon: Icon(Icons.mail),
        label: ""
        )
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: bottomNvabaritem,
      iconSize: 30,
      backgroundColor: colorForbody,
      unselectedIconTheme: IconThemeData(color: Colors.black),
      onTap: (v){
        setState(() {
          bottomNvabaritem = v;
        });
      },
      ),
      backgroundColor: colorForbody,
      body: FutureBuilder(
          future: _getData(),
          builder: (context, AsyncSnapshot<List<News>> snap) {
            var data = snap.data;
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (snap.connectionState == ConnectionState.done) {
              return SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      ),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.08,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.chevron_left),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (colorForbody == Colors.white) {
                                    colorForbody = Colors.grey.shade900;
                                  } else {
                                    colorForbody = Colors.white;
                                  }
                                  if (icon ==
                                      Icon(
                                        CupertinoIcons.moon,
                                        color: Colors.black,
                                      )) {
                                    icon = Icon(
                                      CupertinoIcons.moon_fill,
                                      color: Colors.white,
                                    );
                                  } else {
                                    icon = Icon(
                                      CupertinoIcons.moon,
                                      color: Colors.black,
                                    );
                                  }
                                  if (colorOfTextandIcon == Colors.black) {
                                    colorOfTextandIcon = Colors.white70;
                                  } else {
                                    colorOfTextandIcon = Colors.black;
                                  }
                                });
                              },
                              icon: Icon(CupertinoIcons.moon_fill),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: sizeofText != 40
                                        ? () {
                                            setState(() {
                                              sizeofText += 3;
                                            });
                                          }
                                        : null,
                                    icon: Icon(Icons.add_circle),
                                  ),
                                  IconButton(
                                    onPressed: sizeofText != 12
                                        ? () {
                                            setState(() {
                                              sizeofText -= 3;
                                            });
                                          }
                                        : null,
                                    icon: Icon(Icons.remove_circle),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.13,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                    "https://source.unsplash.com/random/${widget.index}"),
                              ),
                            ),
                            Text(
                              data![widget.index].email.toString(),
                              style: TextStyle(
                                  color: colorOfTextandIcon, fontSize: 24),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Container(
                          height: size.height * 0.4,
                          width: size.width,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  data[widget.index].body.toString(),
                                  style: TextStyle(
                                      fontSize: sizeofText,
                                      color: colorOfTextandIcon),
                                ),
                                Text(
                                  data[widget.index].body.toString(),
                                  style: TextStyle(
                                      fontSize: sizeofText,
                                      color: colorOfTextandIcon),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<List<News>> _getData() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/comments");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => News.fromJson(e))
          .toList();
    } else {
      throw Exception("XATOLAR ${res.body}");
    }
  }
}

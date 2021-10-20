import 'dart:convert';

import 'package:exam3/models/data.dart';
import 'package:exam3/ui/view_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color colorForbody = Colors.white;
  Color colorOfTextandIcon = Colors.black;
  Icon icon = Icon(CupertinoIcons.moon,color: Colors.black,);
  int bottomNvabaritem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorForbody,
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

        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                setState(() {
                 if (colorForbody == Colors.white ) {
                   colorForbody = Colors.grey.shade900;
                 } else {
                   colorForbody = Colors.white;
                 }
                 if (icon == Icon(CupertinoIcons.moon,color: Colors.black,)) {
                   icon = Icon(CupertinoIcons.moon_fill,color: Colors.white,) ;
                 } else {
                   icon = Icon(CupertinoIcons.moon,color: Colors.black,);
                 }
                 if (colorOfTextandIcon == Colors.black) {
                    colorOfTextandIcon = Colors.white70;
                 } else {
                   colorOfTextandIcon = Colors.black;
                 }
                 
                });
              },
              icon: icon),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
         
          title: Text(
            "Todays News",
            style: TextStyle(color: colorOfTextandIcon, fontSize: 22),
          ),
        ),
        body: FutureBuilder(
          future: _getData(),
          builder: (context, AsyncSnapshot<List<News>> snap) {
            var data = snap.data;
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (snap.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(14),
                          gradient: LinearGradient(colors: [Colors.blue,Colors.red,],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight
                          )
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.green,
                            backgroundImage: NetworkImage("https://source.unsplash.com/random/$index"),
                        
                          ),
                          title: Text(data[index].email.toString(),style: TextStyle(color: colorOfTextandIcon),),
                          subtitle: Text(data[index].postId.toString(),style: TextStyle(color: colorOfTextandIcon),),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios_outlined,color: colorOfTextandIcon,)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPage(
                                  index: index,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
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

/*   Future<Post> _getPostFromAPI() async {
    var url = Uri.parse("https://hwasmpleapi.firebaseio.com/http");
    var responce = await http.get(url);
    if (responce.statusCode == 200) {
      return Post.fromJson(json.decode(responce.body));
    } else {
      throw Exception("Vremmeno ne Dostupno");
    }
  }
  
}
 */
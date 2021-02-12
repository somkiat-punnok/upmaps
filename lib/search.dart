import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_up/pages/appstate.dart';
import 'package:maps_up/pages/map.dart';
import 'package:provider/provider.dart';

class SearchData extends StatefulWidget {
  @override
  _SearchDataState createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  Widget _deleteButton(documentID) {
    return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          print('click Delete');
          //   users.document(documentID).delete();
          await showDialog(
            context: context,
            builder: (context) {
              return FutureBuilder(
                future: users.document(documentID).delete(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AlertDialog(
                      title: Text("ข้อมูล"),
                      backgroundColor: Colors.white,
                      content: Text("ลบข้อมูลสำเร็จ"),
                      actions: [
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          onPressed: () {
                            Navigator.of(context).maybePop();
                          },
                          child: Text("เสร็จสิ้น"),
                          color: Colors.purple,
                          textColor: Colors.white,
                        )
                      ],
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.cyanAccent,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ); //หมุนๆๆๆๆๆๆๆ
                },
              );
            },
          );

          // MaterialPageRoute materialPageRoute =
          //     MaterialPageRoute(builder: (BuildContext context) => Admin2());
          // Navigator.of(context).push(materialPageRoute);
        });
  }

  CollectionReference users = Firestore.instance.collection('database');
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("กรุณารอสักครู่...");
        }

        return new Scaffold(
            appBar: AppBar(
              title: Text('UNIVERSITY OF PHAYAO'),
              backgroundColor: Colors.purple,
              actions: <Widget>[
                searchButton(snapshot.data.documents),
              ],
              // actions: <Widget>[EventButton()],
            ),
            body: ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Card(
                  color: Colors.green[50],
                  child: Row(
                    children: [
                      Container(
                        //color: Colors.purple,
                        child: GestureDetector(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(''),
                              Text(
                                'ชื่อตึก:   ' + document['building name'],
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ชื่อห้อง:    ' + document['room name'],
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              Text(
                                'ชื่ออาจารย์:   ' + document['AJ name'],
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'เลขห้อง:   ' + document['Number of room'],
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              Text(''),
                            ],
                          ),
                          onTap: () {
                            context.read<AppState>().sendRequest(
                                  name: "${document['building name']}",
                                  address:
                                      LatLng(document['lat'], document['long']),
                                  url:
                                      "http://projectdriveup.com/%E0%B8%A0%E0%B8%B2%E0%B8%9E360%E0%B8%AD%E0%B8%87%E0%B8%A8%E0%B8%B2/",
                                );
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return MyHomePage();
                            }));
                          },
                        ),
                      ),
                      Expanded(
                        child: Visibility(
                            visible:
                                context.watch<AppState>().typeUser == "admin",
                            child:
                                _deleteButton(document.reference.documentID)),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ));
      },
    );
  }

  Widget searchButton(List<DocumentSnapshot> data) {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () async {
          await showSearch(
            context: context,
            delegate: CustomSearchDelegate(data),
          );
        });
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<DocumentSnapshot> _place;

  CustomSearchDelegate(this._place)
      : super(
          searchFieldLabel: "กรุณากรอกชื่ออาจารย์ที่ต้องการค้นหา",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.purple,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      print(_place);
      return Column(
        children: _place
            .where((p) =>
                p.data['building name'].trim().startsWith(query.trim()) ||
                p.data['Number of room'].trim().startsWith(query.trim()) ||
                p.data['AJ name'].trim().startsWith(query.trim()))
            .map<Widget>((p) => Card(
                  color: Colors.green[50],
                  child: Row(
                    children: [
                      Container(
                        //color: Colors.purple,
                        child: GestureDetector(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(''),
                              Text(
                                'ชื่อตึก:   ' + p.data['building name'],
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ชื่อห้อง:    ' + p.data['room name'],
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              Text(
                                'ชื่ออาจารย์:   ' + p.data['AJ name'],
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'เลขห้อง:   ' + p.data['Number of room'],
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              Text(''),
                            ],
                          ),
                          onTap: () {
                            context.read<AppState>().sendRequest(
                                  name: "${p.data['building name']}",
                                  address:
                                      LatLng(p.data['lat'], p.data['long']),
                                );
                            // return AlertDialog(
                            //   title: Text("ข้อมูล"),
                            //   backgroundColor: Colors.white,content: Text("ลบข้อมูลสำเร็จ"),actions: [FlatButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all( {

                            //   })),onPressed: null, child: null)],
                            // );
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return MyHomePage();
                            }));
                          },
                        ),
                      ),
                      Expanded(
                        child: Visibility(
                            visible:
                                context.watch<AppState>().typeUser == "admin",
                            child:
                                _deleteButton(context, p.reference.documentID)),
                      ),
                    ],
                  ),
                ))
            .toList(),
      );
    }

    return Column();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }

  Widget _deleteButton(context, documentID) {
    return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          print('click Delete');
          //   users.document(documentID).delete();
          await showDialog(
            context: context,
            builder: (context) {
              return FutureBuilder(
                future: Firestore.instance
                    .collection('database')
                    .document(documentID)
                    .delete(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AlertDialog(
                      title: Text("ข้อมูล"),
                      backgroundColor: Colors.white,
                      content: Text("ลบข้อมูลสำเร็จ"),
                      actions: [
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          onPressed: () {
                            Navigator.of(context).maybePop();
                          },
                          child: Text("เสร็จสิ้น"),
                          color: Colors.purple,
                          textColor: Colors.white,
                        )
                      ],
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.cyanAccent,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ); //หมุนๆๆๆๆๆๆๆ
                },
              );
            },
          );

          // MaterialPageRoute materialPageRoute =
          //     MaterialPageRoute(builder: (BuildContext context) => Admin2());
          // Navigator.of(context).push(materialPageRoute);
        });
  }
}

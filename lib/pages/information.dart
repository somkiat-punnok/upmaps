import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_up/home.dart';
import 'package:maps_up/pages/appstate.dart';
import 'package:maps_up/search.dart';
import 'package:provider/provider.dart';


import 'map.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _formKeytwo = GlobalKey<FormState>();
  final _formKeythree = GlobalKey<FormState>();
  final _formKeyfour = GlobalKey<FormState>();
  final _formKeyfive = GlobalKey<FormState>();
  final _formKeysix = GlobalKey<FormState>();
  final _formKeyseven = GlobalKey<FormState>();
  String build_name;
  String room_name;
  String aj_name;
  String num_room;
  String lat;
  String long;
  String url;
  

  Widget saveButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text(
        'เพิ่มข้อมูล',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        createData();
      },
    );
  }

  Widget logoutButton() {
    return RaisedButton(
      color: Colors.red,
      child: Text(
        'LogOut',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return HomePage2();
          }),
        );
        print('click Logout');
        context.read<AppState>().typeUser = null;
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        saveButton(),
        SizedBox(
          width: 100.0,
        ),
        logoutButton(),
      ],
    );
  }

  // Method
  Widget mapsButton() {
    return IconButton(
        icon: Icon(Icons.map),
        onPressed: () {
          print('click maps');

          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage());
          Navigator.of(context).push(materialPageRoute);
        });
  }

  Widget information() {
    return IconButton(
        icon: Icon(Icons.featured_play_list),
        onPressed: () {
          print('click information');

          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => SearchData());
          Navigator.of(context).push(materialPageRoute);
        });
  }

  Widget nameBuildingText() {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        icon: Icon(
          Icons.business,
          color: Colors.purple,
          size: 48.0,
        ),
        labelText: 'ชื่อตึก/ชื่ออาคาร : ',
        labelStyle: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'กรอกชื่อตึก/ชื่ออาคาร',
        helperStyle:
            TextStyle(color: Colors.purple, fontStyle: FontStyle.italic),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่ชื่ออาคาร / Ex." - "';
        }
        return null;
      },
      onSaved: (value) => build_name = value,
    );
  }

  Widget nameRoomText() {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        icon: Icon(
          Icons.room,
          color: Colors.purple,
          size: 48.0,
        ),
        labelText: 'ชื่อห้อง : ',
        labelStyle: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'กรอกชื่อห้อง',
        helperStyle:
            TextStyle(color: Colors.purple, fontStyle: FontStyle.italic),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่ชื่อห้อง / Ex." - "';
        }
        return null;
      },
      onSaved: (value) => room_name = value,
    );
  }

  Widget nameTeacherText() {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        icon: Icon(
          Icons.text_fields,
          color: Colors.purple,
          size: 48.0,
        ),
        labelText: 'ชื่ออาจารย์ : ',
        labelStyle: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'กรอกชื่ออาจารย์',
        helperStyle:
            TextStyle(color: Colors.purple, fontStyle: FontStyle.italic),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่ชื่ออาจารย์ / Ex." - "';
        }
        return null;
      },
      onSaved: (value) => aj_name = value,
    );
  }

  Widget roomnumberText() {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        icon: Icon(
          Icons.format_list_numbered,
          color: Colors.purple,
          size: 48.0,
        ),
        labelText: 'เลขห้อง : ',
        labelStyle: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'กรอกเลขห้อง',
        helperStyle:
            TextStyle(color: Colors.purple, fontStyle: FontStyle.italic),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่เลขห้อง / " - "';
        }
        return null;
      },
      onSaved: (value) => num_room = value,
    );
  }

  Widget locationlatText() {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        icon: Icon(
          Icons.local_library,
          color: Colors.purple,
          size: 48.0,
        ),
        labelText: 'ละติจูด : ',
        labelStyle: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'กรอกละติจูด',
        helperStyle:
            TextStyle(color: Colors.purple, fontStyle: FontStyle.italic),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่ละติจูด';
        }
        return null;
      },
      onSaved: (value) => lat = value,
    );
  }

  Widget locationlongText() {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        icon: Icon(
          Icons.local_library,
          color: Colors.purple,
          size: 48.0,
        ),
        labelText: 'ลองติจูด : ',
        labelStyle: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'กรอกลองติจูด',
        helperStyle:
            TextStyle(color: Colors.purple, fontStyle: FontStyle.italic),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่ลองติจูด';
        }
        return null;
      },
      onSaved: (value) => long = value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('ผู้ดูแล'),
        actions: <Widget>[
          mapsButton(),
          information(),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          Form(
            key: _formKey,
            child: nameBuildingText(),
          ),
          Form(
            key: _formKeytwo,
            child: nameRoomText(),
          ),
          Form(
            key: _formKeythree,
            child: nameTeacherText(),
          ),
          Form(
            key: _formKeyfour,
            child: roomnumberText(),
          ),
          Form(
            key: _formKeyfive,
            child: locationlatText(),
          ),
          Form(
            key: _formKeysix,
            child: locationlongText(),
          ),
          SizedBox(
            width: 100.0,
          ),
          showButton(),
        ],
      ),
    );
  }

  void createData() async {
    // var number =
    // int.parse(saleVal);

    if (_formKey.currentState.validate() &&
        _formKeytwo.currentState.validate() &&
        _formKeythree.currentState.validate() &&
        _formKeyfour.currentState.validate() &&
        _formKeyfive.currentState.validate() &&
        _formKeysix.currentState.validate()) {
      _formKey.currentState.save();
      _formKeytwo.currentState.save();
      _formKeythree.currentState.save();
      _formKeyfour.currentState.save();
      _formKeyfive.currentState.save();
      _formKeysix.currentState.save();

      // DocumentReference ref = await db.collection('sales').add({
      //   // 'saleVal': '$number ',
      //   'saleVal': '$saleVal ',
      //   'saleYear': '$saleYear',
      // });
      // setState(() => id = ref.documentID);
      // print(ref.documentID);
      await showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder(
            future:
                Firestore.instance.collection('database').document().setData({
              'building name': build_name,
              'room name': room_name,
              'AJ name': aj_name,
              'Number of room': num_room,
              'lat': double.parse(lat),
              'long': double.parse(long),
            }),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AlertDialog(
                  title: Text("ข้อมูล"),
                  backgroundColor: Colors.white,
                  content: Text("เพิ่มข้อมูลสำเร็จ"),
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

      _formKey.currentState.reset();
      _formKeytwo.currentState.reset();
      _formKeythree.currentState.reset();
      _formKeyfour.currentState.reset();
      _formKeyfive.currentState.reset();
      _formKeysix.currentState.reset();
    }
  }

  // Future signOut() {
  //   FirebaseAuth.instance.signOut();
  // }
}

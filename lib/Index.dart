import 'package:flutter/material.dart';
import 'home.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  // method
  Widget showLogo() {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Drive  UP',
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'Pattaya',
      ),
    );
  }

  Widget ueseButton() {
    return RaisedButton(
      color: Colors.purple,
      child: Text(
        'เริ่มต้นใช้งาน',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('click uese');

        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => HomePage2());

        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  // Widget adminButton() {
  //   return RaisedButton(
  //     color: Colors.black,
  //     child: Text(
  //       'Admin',
  //       style: TextStyle(color: Colors.white),
  //     ),
  //     onPressed: () {
  //       print('click admin');

  //       MaterialPageRoute materialPageRoute =
  //           MaterialPageRoute(builder: (BuildContext context) => Admin());
  //       Navigator.of(context).push(materialPageRoute);
  //     },
  //   );
  // }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ueseButton(),
        SizedBox(
          width: 10.0,
        ),
        //adminButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Colors.purple],
            radius: 1.0,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              showLogo(),
              showAppName(),
              SizedBox(
                height: 10.0,
              ),
              showButton(),
            ],
          ),
        ),
      )),
    );
  }
}

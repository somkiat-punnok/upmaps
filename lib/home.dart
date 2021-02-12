import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps_up/pages/admin.dart';
import 'package:maps_up/pages/map.dart';
import 'package:maps_up/search.dart';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'button_material.dart';

class HomePage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage2State();
  }
}

class _HomePage2State extends State<HomePage2> {
  final picker = ImagePicker();
  // int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Widget bottomNavbar = BottomNavigationBar(
    //   currentIndex: _currentIndex,
    //   items: [
    //     BottomNavigationBarItem(
    //       icon: Icon(
    //         Icons.camera,
    //         size: 35.0,
    //       ),
    //       title: Text('Camera'),
    //       backgroundColor: Colors.purple[300],
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(
    //         Icons.zoom_out_map,
    //         size: 35.0,
    //       ),
    //       title: Text('Search'),
    //       //backgroundColor: Colors.red[300],
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(
    //         Icons.person,
    //         size: 35.0,
    //       ),
    //       title: Text('Search'),
    //       //backgroundColor: Colors.red[300],
    //     ),
    //   ],
    //   onTap: (index) {
    //     setState(() {
    //       _currentIndex = index;
    //     });
    //   },
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('UNIVERSITY OF PHAYAO'),
      ),
      //backgroundColor: Colors.purple[100],
      // bottomNavigationBar: bottomNavbar,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            MaterialButtonShape(
              text: 'กล้อง',
              icon: Icons.camera,
              color: Colors.redAccent,
              textColor: Colors.white,
              iconColor: Colors.redAccent,
              iconSize: 40.0,
              width: 200,
              height: 70,
              onClick: () async {
                // final pickedFile =
                await picker.getImage(source: ImageSource.camera);
              },
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButtonShape(
              text: 'แผนที่',
              icon: Icons.map,
              color: Colors.green,
              textColor: Colors.white,
              iconColor: Colors.green,
              iconSize: 40.0,
              width: 200,
              height: 70,
              onClick: () {
                print("Click");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return MyHomePage();
                  }),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButtonShape(
              text: 'ค้นหา',
              icon: Icons.search,
              color: Colors.purple,
              textColor: Colors.white,
              iconColor: Colors.purple,
              iconSize: 40.0,
              width: 200,
              height: 70,
              onClick: () {
                print("Click");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SearchData();
                  }),
                );
              },
            ),
            Container(
              child: Column(
                  //children: <Widget>[Text('UNIVERCITY OF PHAPAO')],
                  ),
            ),
            Container(
              //color: Colors.purple[800],
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Center(
                  // child: Image.asset('image/Logo.png'),
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    // final pickedFile =
                    // await picker.getImage(source: ImageSource.camera);

                    if (await canLaunch('http://projectdriveup.com/')) {
                      await launch('http://projectdriveup.com/');
                    }
                  },
                  icon: Icon(
                    Icons.today,
                    color: Colors.yellow.shade800,
                  ),
                  iconSize: 50.0,
                  splashColor: Colors.indigoAccent,
                ),
                IconButton(
                  onPressed: () async {
                    if (await canLaunch(
                        'http://projectdriveup.com/%E0%B8%A0%E0%B8%B2%E0%B8%9E360%E0%B8%AD%E0%B8%87%E0%B8%A8%E0%B8%B2/')) {
                      await launch(
                          'http://projectdriveup.com/%E0%B8%A0%E0%B8%B2%E0%B8%9E360%E0%B8%AD%E0%B8%87%E0%B8%A8%E0%B8%B2/');
                    }
                  },
                  icon: Icon(
                    Icons.panorama,
                    color: Colors.blue,
                  ),
                  iconSize: 50.0,
                  splashColor: Colors.indigoAccent,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          // return notification();
                          return Admin();
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  iconSize: 50.0,
                  splashColor: Colors.indigoAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

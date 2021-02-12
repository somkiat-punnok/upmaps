import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maps_up/pages/appstate.dart';
import 'information.dart';
import 'package:provider/provider.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => new _AdminState();
}

class _AdminState extends State<Admin> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: Text('เข้าสู่ระบบ'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black),
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please type an email';
                }
                return null;
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: Colors.purple,
                    size: 48.0,
                  ),
                  labelText: 'Email : '),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              validator: (input) {
                if (input.length < 6) {
                  return 'Your password need 6 cha';
                }
                return null;
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.vpn_key,
                    color: Colors.purple,
                    size: 48.0,
                  ),
                  labelText: 'password : '),
              obscureText: true,
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text(
                'เข้าสู่ระบบ',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password)
            .then((value) async {
          print("User: ${value.user.displayName}");
          if (value.user.displayName == null) {
            UserUpdateInfo _info = UserUpdateInfo();
            if (value.user.email == "admin@gmail.com") {
              _info.displayName = "admin";
            } else {
              _info.displayName = "user";
            }
            await value.user.updateProfile(_info);
            print("${value.user.displayName}");
          }
          context.read<AppState>().typeUser = value.user.displayName;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Information()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}

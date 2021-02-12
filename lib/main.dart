import 'package:flutter/material.dart';
import 'package:maps_up/Index.dart';
import 'package:maps_up/pages/appstate.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider.value(
    value: AppState(),
    child: Myapp(),
  ));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My app',
      home: Index(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class Snity extends StatefulWidget {
  @override
  _SnityState createState() => _SnityState();
}

class _SnityState extends State<Snity> {
  UnityWidgetController _unityWidgetController;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIOverlays([
    //   SystemUiOverlay.top,
    //   SystemUiOverlay.bottom,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          UnityWidget(
            onUnityViewCreated: onUnityCreated,
            isARScene: true,
            fullscreen: true,
            onUnityMessage: onUnityMessage,
            onUnitySceneLoaded: onUnitySceneLoaded,
            onUnityUnloaded: onUnityUnloaded,
          ),
        ],
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    print('Received controller from unity: ${controller}');
    _unityWidgetController = controller;
  }

  // Callback that connects the created controller to the unity controller
  void onUnityUnloaded(controller) {
    print('Received Unloaded controller from unity: ${controller}');
    _unityWidgetController = controller;
  }

  // Communication from Unity to Flutter
  void onUnityMessage(controller, message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(
    controller, {
    int buildIndex,
    bool isLoaded,
    bool isValid,
    String name,
  }) {
    print('Received scene loaded from unity: $name');
    print('Received scene loaded from unity buildIndex: $buildIndex');
  }
}

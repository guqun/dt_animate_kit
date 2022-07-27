import 'package:dt_animate_kit/birthday_one/birthday_effect_one.dart';
import 'package:dt_animate_kit/birthday_two/birthday_effect_two.dart';
import 'package:dt_animate_kit/birthday_two/birthday_effect_two_single.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dt_animate_kit/dt_animate_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String _platformVersion = 'Unknown';
  // final _dtAnimateKitPlugin = DtAnimateKit();

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    // ScreenUtil.init(context, designSize: Size(window.physicalSize.width, window.physicalSize.height));
  }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion =
  //         await _dtAnimateKitPlugin.getPlatformVersion() ?? 'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
        builder: (context, child){
          return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: Stack(
              children: [
                BirthdayEffectOne(
                  viewHeight: window.physicalSize.height,
                  viewWidth: window.physicalSize.width,
                ),
                BirthdayEffectTwo(
                  viewHeight: window.physicalSize.height,
                  viewWidth: window.physicalSize.width,
                  startX:100.w, startY: 250.h, delaySec: 0,
                  startX1:150.w, startY1: 200.h, delaySec1: 2,
                  startX2:200.w, startY2: 150.h, delaySec2: 4,
                  durationSec: 2,
                ),
                BirthdayEffectTwoSingle(
                  viewHeight: window.physicalSize.height,
                  viewWidth: window.physicalSize.width,
                  startX:200.w, startY: 300.h, delaySec: 2,
                ),
              ],
            )
        ),
      );
    });
  }
}

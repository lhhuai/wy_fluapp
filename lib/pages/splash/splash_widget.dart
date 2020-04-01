import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wy_fluapp/pages/container_page.dart';
import 'package:wy_fluapp/utils/screen_utils.dart';
import 'package:wy_fluapp/constant/constant.dart';
import 'package:wy_fluapp/constant/wy_icons.dart';

// 打开APP首页
class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
  }

  var container = ContainerPage();

  static const platform = const MethodChannel('www.seaphy.com/battery');
  
  bool showAd = true;
  String _batteryLevel = 'Unknown battery level.';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel = '';
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    // _batteryLevel = batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });
    print(_batteryLevel);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          child: container,
          offstage: showAd,
        ),
        Offstage(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: ScreenUtils.screenW(context) / 3,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(Constant.ASSETS_IMG + 'lufei.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(WYIcons.favorites, color: Colors.red,),
                            Text(
                              '敢对我的伙伴出手，就要做好心理准备。',
                              style: TextStyle(fontSize: 15.0, color: Colors.black),
                            ),
                            Icon(WYIcons.favorites, color: Colors.red,),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 10),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //       RaisedButton(
                      //         onPressed: _getBatteryLevel,
                      //         child: Text('Get Battery Level'),
                      //       ),
                      //       Text(_batteryLevel),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 20.0),
                      //   child: Icon(WYIcons.favorites, color: Colors.red,),
                      // ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment(1.0, 0.0),
                        child: Container(
                          margin: EdgeInsets.only(right: 30.0, top: 20.0),
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                          child: CountDownWidget(
                            onCountDownFinishCallBack: (bool value) {
                              if (value) {
                                setState(() {
                                  showAd = false;
                                });
                              }
                            },
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffEDEDED),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Constant.ASSETS_IMG + 'robot.png',
                              width: 30.0,
                              height: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Hi, seaphy.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            width: ScreenUtils.screenW(context),
            height: ScreenUtils.screenH(context),
          ),
          offstage: !showAd,
        ),
      ],
    );
  }
}

class CountDownWidget extends StatefulWidget {
  final onCountDownFinishCallBack;

  CountDownWidget({Key key, @required this.onCountDownFinishCallBack}) : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  var _seconds = 6;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_seconds',
      style: TextStyle(fontSize: 17.0),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
      if (_seconds <= 1) {
        widget.onCountDownFinishCallBack(true);
        _cancelTimer();
      }
      _seconds--;
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }
}

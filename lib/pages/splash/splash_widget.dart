import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  var container = Center(
    child: Text("home"),
  );

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
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: _getBatteryLevel,
                              child: Text('Get Battery Level'),
                            ),
                            Text(_batteryLevel),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 20.0),
                      //   child: Icon(WYIcons.favorites, color: Colors.red,),
                      // ),
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

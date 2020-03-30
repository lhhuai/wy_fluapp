import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wy_fluapp/utils/screen_utils.dart';
import 'package:wy_fluapp/constant/constant.dart';

// 打开APP首页
class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  var container = Center(
    child: Text("home"),
  );
  
  bool showAd = true;

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
                        backgroundImage: AssetImage(Constant.ASSETS_IMG + 'home.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          '落花有意随流水,流水无心恋落花',
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
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

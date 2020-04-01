import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wy_fluapp/pages/splash/splash_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MaterialApp(
        theme: ThemeData(backgroundColor: Colors.white),
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: SplashWidget(),
        ),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  final Widget child;

  RestartWidget({Key key, @required this.child}) 
    : assert(child != null), super(key: key);

  static restartApp(BuildContext context) {
    final _RestartWidgetState state = context.findAncestorStateOfType();
    state.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  @override
  void initState() {
    super.initState();
    TargetPlatform tp = defaultTargetPlatform;
    print('The targetPlatform is $tp' + '');

    /// 可以指定所有平台的交互方式都跟iOS一样
    // debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    // print(defaultTargetPlatform); // 会输出TargetPlatform.iOS
  }

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('===========================seaphy=========================');
    return Container(
      key: key,
      child: widget.child,
    );
  }
}

import 'package:car_play/models/models.dart';
import 'package:car_play/util/timerUtil.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;
   
  List<String> _guideList = [
   '1','2','3'
  ];

  List<Widget> _bannerList = new List();

  int _status = 0;
  int _count = 3;

  SplashModel _splashModel;

  @override
  void initState() {
    super.initState();
    _initAsync();
    _doCountDown();
  }

  // void _loadSplashData() async {
  //   HttpUtil httpUtil = new HttpUtil();
  //   httpUtil.getSplash().then((model) async {
  //     await SpUtil.getInstance();
  //     _splashModel = SpHelper.getSplashModel();
  //     if (!ObjectUtil.isEmpty(model.imgUrl)) {
  //       if (_splashModel == null || (_splashModel.imgUrl != model.imgUrl)) {
  //         SpUtil.putString(Constant.KEY_SPLASH_MODEL, json.encode(model));
  //         setState(() {
  //           _splashModel = model;
  //         });
  //       }
  //     } else {
  //       SpUtil.putString(Constant.KEY_SPLASH_MODEL, '');
  //     }
  //   });
  // }

  void _initAsync() {
    // Observable.just(1).delay(new Duration(milliseconds: 1000)).listen((_) {
    //   if (SpUtil.getBool(Constant.KEY_GUIDE) != true &&
    //       ObjectUtil.isNotEmpty(_guideList)) {
    //     SpUtil.putBool(Constant.KEY_GUIDE, true);
    //     _initBanner();
    //   } else {
    //     _initSplash();
    //   }
    // });
  }

  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  void _initBannerData() {
    // for (int i = 0, length = _guideList.length; i < length; i++) {
    //   if (i == length - 1) {
    //     _bannerList.add(new Stack(
    //       children: <Widget>[
    //         new Image.asset(
    //           _guideList[I],
    //           fit: BoxFit.fill,
    //           width: double.infinity,
    //           height: double.infinity,
    //         ),
    //         new Align(
    //           alignment: Alignment.bottomCenter,
    //           child: new Container(
    //             margin: EdgeInsets.only(bottom: 160.0),
    //             child: new RaisedButton(
    //               textColor: Colors.white,
    //               color: Colors.indigoAccent,
    //               child: Text(
    //                 '立即体验',
    //                 style: new TextStyle(fontSize: 16.0),
    //               ),
    //               onPressed: () {
    //                 _goMain();
    //               },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ));
    //   } else {
    //     _bannerList.add(new Image.asset(
    //       _guideList[I],
    //       fit: BoxFit.fill,
    //       width: double.infinity,
    //       height: double.infinity,
    //     ));
    //   }
    // }
  }

  void _initSplash() {

    // _splashModel = SpHelper.getSplashModel();
    // if (_splashModel == null) {
    //   _goMain();
    // } else {
    //   _doCountDown();
    // }
  }

  void _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      print(tick);
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void _goMain() {
    Navigator.of(context).pushReplacementNamed('/MainPage');
  }

  Widget _buildSplashBg() {
    return new Image.asset(
      'assets/images/splash_bg.png',
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),
          new Offstage(
            offstage: !(_status == 2),
            child:Container(),
          ),
         // _buildAdWidget(),
         
          new Offstage(
            offstage: !(_status == 1),
            child: new Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  _goMain();
                },
                child: new Container(
                    padding: EdgeInsets.all(12.0),
                    child: new Text(
                      '跳过 $_count',
                      style: new TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    decoration: new BoxDecoration(
                        color: Color(0x66000000),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: new Border.all(
                            width: 0.33, color: Colors.black))),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得中dispose里面把timer cancel。
  }
}

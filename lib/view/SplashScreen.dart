import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _maxradius = 120.0;
  AnimationController _controller;
  Animation<double> _animationradius;
  double _radius = 0.0;
  AnimationController _fadeanimationcontroller;
  Animation<double> _fadeanimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _fadeanimationcontroller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animationradius = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 1.0, curve: Curves.elasticOut)));
    _fadeanimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeanimationcontroller);

    _controller.addListener(() {
      setState(() => _radius = _animationradius.value * _maxradius);
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeanimationcontroller.forward();
      }
    });
    _fadeanimationcontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {        
        Navigator.of(context).pushReplacementNamed(PageRoutes.loginroute);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeanimationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: _radius,
              child: Center(
                child: FadeTransition(
                  opacity: _fadeanimation,
                  child: Text(
                    'DS',
                    style: TextStyle(color: Colors.white, fontSize: _maxradius),
                  ),
                ),
              ),
            ),
            FadeTransition(
              opacity: _fadeanimation,
              child: Text(
                'DREAM SOFT',
                style: TextStyle(
                    fontSize: _maxradius / 3,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class _AnimateAppLogo extends StatefulWidget {
  final double maxradius;
  _AnimateAppLogo(this.maxradius);
  @override
  __AnimateAppLogoState createState() => __AnimateAppLogoState();
}

class __AnimateAppLogoState extends State<_AnimateAppLogo>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animationradius;
  double _radius = 0.0;
  AnimationController _fadeanimationcontroller;
  Animation<double> _fadeanimation;
  AnimationController _slideanimationcontroller;
  Animation<Offset> _slideanimation;
  double _titleopaity = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _fadeanimationcontroller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _slideanimationcontroller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationradius = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 1.0, curve: Curves.elasticOut)));

    _fadeanimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeanimationcontroller);
    _slideanimation =
        Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0)).animate(
            CurvedAnimation(
                parent: _slideanimationcontroller,
                curve: Interval(0.0, 1.0, curve: Curves.elasticIn)));

    _controller.addListener(() {
      setState(() => _radius = _animationradius.value * widget.maxradius);
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeanimationcontroller.forward();
      }
    });
    _fadeanimationcontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _titleopaity = 1;
        });
        _slideanimationcontroller.forward();
      }
    });
    _slideanimationcontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(
            Duration(seconds: 1),
            () => Navigator.of(context)
                .pushReplacementNamed(PageRoutes.loginroute));
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeanimationcontroller.dispose();
    _slideanimationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: _radius,
          child: Center(
            child: FadeTransition(
              opacity: _fadeanimation,
              child: Text(
                'DS',
                style:
                    TextStyle(color: Colors.white, fontSize: widget.maxradius),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: _titleopaity,
          child: SlideTransition(
            position: _slideanimation,
            child: Text(
              'DREAM SOFT',
              style: TextStyle(
                  fontSize: widget.maxradius / 3,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        )
      ],
    );
  }
}

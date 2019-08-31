import 'package:flutter/material.dart';
import 'dart:math';

class Loader extends StatefulWidget {
  final int animationduration;
  final double initialradius;
  final bool centervisible;
  final double centerradius;
  final double dotradius;
  final Color centerdotcolor;
  final Color dot1color;
  final Color dot2color;
  final Color dot3color;
  final Color dot4color;
  final Color dot5color;
  final Color dot6color;
  final Color dot7color;
  final Color dot8color;
  final double width;
  final double height;
  final Color dotunicolor;
  const Loader({
    Key key,
    @required this.animationduration,
    @required this.initialradius,
    this.dotunicolor,
    this.centervisible = false,
    this.centerradius = 15,
    this.dotradius = 5,
    this.centerdotcolor,
    this.dot1color,
    this.dot2color,
    this.dot3color,
    this.dot4color,
    this.dot5color,
    this.dot6color,
    this.dot7color,
    this.dot8color,
    this.width,
    this.height
  })  : assert(centervisible != null),
        assert(centerradius != null),
        assert(dotradius != null),
        super(key: key);
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animationrotation;
  Animation<double> _animationradiusin;
  Animation<double> _animationradiusout;
  double _radius = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.animationduration));
    _animationrotation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 1.0, curve: Curves.linear)));
    _animationradiusin = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));
    _animationradiusout = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));
    _controller.addListener(() {
      setState(() {
        if (_controller.value >= 0.75 && _controller.value <= 1.0) {
          _radius = _animationradiusin.value * widget.initialradius;
        } else if (_controller.value > -0.0 && _controller.value <= 0.25) {
          _radius = _animationradiusout.value * widget.initialradius;
        }
      });
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 100.0,
      height: widget.height ?? 100.0,
      child: Center(
        child: RotationTransition(
          turns: _animationrotation,
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(0.0, 0.0),
                child: widget.centervisible
                    ? Dot(
                        raduis: widget.centerradius,
                        color: Theme.of(context).accentColor,
                      )
                    : Container(),
              ),
              Transform.translate(
                offset: Offset(_radius * cos(pi / 4), _radius * sin(pi / 4)),
                child: Dot(
                  raduis: widget.dotradius,
                  color: widget.dot1color ?? (widget.dotunicolor ?? Theme.of(context).accentColor),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(2 * pi / 4), _radius * sin(2 * pi / 4)),
                child: Dot(
                  raduis: widget.dotradius,
                  color: widget.dot2color ?? (widget.dotunicolor ?? Theme.of(context).accentColor),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(3 * pi / 4), _radius * sin(3 * pi / 4)),
                child: Dot(
                  raduis: widget.dotradius,
                  color: widget.dot3color ?? (widget.dotunicolor ?? Theme.of(context).accentColor),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(4 * pi / 4), _radius * sin(4 * pi / 4)),
                child: Dot(
                  raduis: widget.dotradius,
                  color: widget.dot4color ?? (widget.dotunicolor ?? Theme.of(context).accentColor),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(5 * pi / 4), _radius * sin(5 * pi / 4)),
                child: Dot(
                  raduis: widget.dotradius,
                  color: widget.dot5color ?? (widget.dotunicolor ?? Theme.of(context).accentColor),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(6 * pi / 4), _radius * sin(6 * pi / 4)),
                child: Dot(
                  raduis: widget.dotradius,
                  color: widget.dot6color ?? (widget.dotunicolor ?? Theme.of(context).accentColor),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(7 * pi / 4), _radius * sin(7 * pi / 4)),
                child: Dot(
                  raduis: widget.dotradius,
                  color: widget.dot7color ?? (widget.dotunicolor ?? Theme.of(context).accentColor),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(8 * pi / 4), _radius * sin(8 * pi / 4)),
                child: Dot(
                  raduis: widget.dotradius,
                  color: widget.dot8color ?? (widget.dotunicolor ?? Theme.of(context).accentColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double raduis;
  final Color color;
  Dot({this.raduis, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: raduis,
        height: raduis,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

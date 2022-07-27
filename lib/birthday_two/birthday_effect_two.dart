import 'dart:math';

import 'package:dt_animate_kit/birthday_two/particle.dart';
import 'package:dt_animate_kit/effects_state.dart';
import 'package:dt_animate_kit/image_utils.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_screenutil/flutter_screenutil.dart';


class BirthdayEffectTwo extends StatefulWidget {
  final double viewWidth;
  final double viewHeight;
  final double startX;
  final double startY;
  final double startX1;
  final double startY1;
  final double startX2;
  final double startY2;
  final int delaySec;
  final int delaySec1;
  final int delaySec2;
  final int durationSec;

  const BirthdayEffectTwo(
      {Key? key, required this.viewWidth, required this.viewHeight,
        required this.startX, required this.startY,
        required this.startX1, required this.startY1,
        required this.startX2, required this.startY2,
        this.delaySec = 0, this.delaySec1 = 2, this.delaySec2 = 4, this.durationSec = 2
      })
      : super(key: key);

  @override
  BirthdayEffectTwoState createState() => BirthdayEffectTwoState();
}

class BirthdayEffectTwoState extends State<BirthdayEffectTwo>
    with TickerProviderStateMixin {

  final double END_VALUE = 1.4;
  final  double X = 5.w.toDouble();
  final  double Y = 20.h.toDouble();
  final  double V = 2.h.toDouble();
  final  double W = 1.w.toDouble();

  final List<ui.Image> _images = [];
  AnimationController? _controller;
  AnimationController? _controller1;
  AnimationController? _controller2;

  final List<Particle> _particles = [];
  final List<Particle> _particles1 = [];
  final List<Particle> _particles2 = [];

  RenderState _state = RenderState.stop;
  RenderState _state1 = RenderState.stop;
  RenderState _state2 = RenderState.stop;

  BirthdayEffectTwoState(){
    initData();
  }

  Future<void> initData() async {
    var image1 = await ImageUtils.getImage('packages/dt_animate_kit/assets/images/bitrhday_two_1.png');
    var image2 = await ImageUtils.getImage('packages/dt_animate_kit/assets/images/bitrhday_two_2.png');
    var image3 = await ImageUtils.getImage('packages/dt_animate_kit/assets/images/bitrhday_two_3.png');
    var image4 = await ImageUtils.getImage('packages/dt_animate_kit/assets/images/bitrhday_two_6.png');
    var image5 = await ImageUtils.getImage('packages/dt_animate_kit/assets/images/bitrhday_two_5.png');

    _images.clear();
    _images.add(image1);
    _images.add(image2);
    _images.add(image3);
    _images.add(image4);
    _images.add(image5);
    initParams(_particles, widget.startX, widget.startY);
    initParams(_particles1, widget.startX1, widget.startY1);
    initParams(_particles2, widget.startX2, widget.startY2);
  }

  Future<void> initParams(List<Particle> ps, double startX, double startY) async {
    if (widget.viewWidth != 0 && widget.viewHeight != 0 && ps.isEmpty) {
      int count = 40;
      for (int i = 0; i < count; i++) {
        ps.add(_generatePartice(Colors.red, Random(), startX, startY));
      }
    }
  }

  @override
  void didUpdateWidget(BirthdayEffectTwo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewWidth != widget.viewWidth ||
        oldWidget.viewHeight != widget.viewHeight) {
      _particles.clear();
      _particles1.clear();
      _particles2.clear();

      initParams(_particles, widget.startX, widget.startY);
      initParams(_particles1, widget.startX1, widget.startY1);
      initParams(_particles2, widget.startX2, widget.startY2);

    }
  }

  @override
  void initState() {
    _controller =
        AnimationController(lowerBound: 0.0, upperBound: 1.5, duration: Duration(seconds: widget.durationSec), vsync: this);
    _controller?.addListener(() {
      setState(() {});
      _state = RenderState.drawing;

    });
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
          _particles.clear();
          initParams(_particles, widget.startX, widget.startY);
          _controller?.repeat();
          _state = RenderState.stop;
      } else if(status == AnimationStatus.forward){
        _state = RenderState.drawing;
      }
    });


    _controller1 =
        AnimationController(lowerBound: 0.0, upperBound: 1.5, duration: Duration(seconds: widget.durationSec), vsync: this);
    _controller1?.addListener(() {
      _state1 = RenderState.drawing;
    });
    _controller1?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _particles1.clear();
        initParams(_particles1, widget.startX1, widget.startY1);
        _controller1?.repeat();
        _state1 = RenderState.stop;
      } else if(status == AnimationStatus.forward){
        _state1 = RenderState.drawing;
      }
    });



    _controller2 =
        AnimationController(lowerBound: 0.0, upperBound: 1.5, duration: Duration(seconds: widget.durationSec), vsync: this);
    _controller2?.addListener(() {
      _state2 = RenderState.drawing;
    });
    _controller2?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _particles2.clear();
        initParams(_particles2, widget.startX2, widget.startY2);
        _controller2?.repeat();
        _state2 = RenderState.stop;
      }else if(status == AnimationStatus.forward){
        _state2 = RenderState.drawing;
      }
    });

    Future.delayed(Duration(seconds: widget.delaySec), (){
      _controller?.forward();
    });
    Future.delayed(Duration(seconds: widget.delaySec1), (){
      _controller1?.forward();
    });
    Future.delayed(Duration(seconds: widget.delaySec2), (){
      _controller2?.forward();
    });
    super.initState();
  }

  Particle _generatePartice(Color color, Random random, double startX, double startY){
    Particle particle = new Particle();
    particle.color = color;
    particle.radius = V;
    if (random.nextDouble() < 0.2.toDouble()) {
      particle.baseRadius = V + ((X - V) * random.nextDouble());
    } else {
      particle.baseRadius = W + ((V - W) * random.nextDouble());
    }
    double nextFloat = random.nextDouble();
    particle.top = 300.w * ((0.18.toDouble() * random.nextDouble()) + 0.2.toDouble());
    particle.top = nextFloat < 0.2.toDouble() ? particle.top : particle.top + ((particle.top * 0.2.toDouble()) * random.nextDouble());
    particle.bottom = (300.w * (random.nextDouble() - 0.5.toDouble())) * 1.8.toDouble();
    double f = nextFloat < 0.2.toDouble() ? particle.bottom : nextFloat < 0.8.toDouble() ? particle.bottom * 0.6.toDouble() : particle.bottom * 0.3.toDouble();
    particle.bottom = f;
    particle.mag = 4.0.toDouble() * particle.top / particle.bottom * 4;
    particle.neg = (-particle.mag) / particle.bottom;
    f = startX + 10.w * Random().nextDouble();

    particle.baseCx = f;
    particle.cx = f;
    f = startY + 20.h * Random().nextDouble();

    particle.baseCy = f;
    particle.cy = f;
    particle.life = END_VALUE / 10 * random.nextDouble();
    particle.overflow = 0.4.toDouble() * random.nextDouble();
    particle.alpha = 1.toDouble();
    particle.image = _images[Random().nextInt(5)];
    return particle;
  }


  @override
  void dispose() {
    _controller?.dispose();
    _controller1?.dispose();
    _controller2?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomPaint(
          painter: EffectBirthdayTwoPainter(this),
        ),
      );
  }
}

class EffectBirthdayTwoPainter extends CustomPainter {
  final _paint = Paint();
  final BirthdayEffectTwoState _state;

  EffectBirthdayTwoPainter(this._state);

  @override
  void paint(Canvas canvas, Size size) {
      draw(canvas, size);
  }

  void draw(Canvas canvas, Size size) {
    canvas.save();
    if(_state._state == RenderState.drawing){
      for (var element in _state._particles) {
        element.advance(_state._controller!.value, _state.V, _state.END_VALUE);
        if(element.alpha > 0){
          canvas.drawImageRect(element.image,
              Rect.fromLTWH(0, 0, element.image.width.toDouble(), element.image.height.toDouble()),
              Rect.fromLTWH(element.cx - element.image.width / 4, element.cy - element.image.height / 4, element.image.width.toDouble()/2, element.image.height.toDouble()/2),
              _paint);
        }
      }
    }
    if(_state._state1 == RenderState.drawing){
      for (var element in _state._particles1) {
        element.advance(_state._controller1!.value, _state.V, _state.END_VALUE);
        if(element.alpha > 0){
          canvas.drawImageRect(element.image,
              Rect.fromLTWH(0, 0, element.image.width.toDouble(), element.image.height.toDouble()),
              Rect.fromLTWH(element.cx - element.image.width / 4, element.cy - element.image.height / 4, element.image.width.toDouble()/2, element.image.height.toDouble()/2),
              _paint);
        }
      }
    }

    if(_state._state2 == RenderState.drawing){
      for (var element in _state._particles2) {
        element.advance(_state._controller2!.value, _state.V, _state.END_VALUE);
        if(element.alpha > 0){
          canvas.drawImageRect(element.image,
              Rect.fromLTWH(0, 0, element.image.width.toDouble(), element.image.height.toDouble()),
              Rect.fromLTWH(element.cx - element.image.width / 4, element.cy - element.image.height / 4, element.image.width.toDouble()/2, element.image.height.toDouble()/2),
              _paint);
        }
      }
    }
    canvas.restore();

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


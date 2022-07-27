import 'dart:math';

import 'package:dt_animate_kit/birthday_two/particle.dart';
import 'package:dt_animate_kit/effects_state.dart';
import 'package:dt_animate_kit/image_utils.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_screenutil/flutter_screenutil.dart';


class BirthdayEffectTwoSingle extends StatefulWidget {
  final double viewWidth;
  final double viewHeight;
  final double startX;
  final double startY;
  final int delaySec;
  final int durationSec;
  // final int num;

  const BirthdayEffectTwoSingle(
      {Key? key, required this.viewWidth, required this.viewHeight,
        required this.startX, required this.startY,
        required this.delaySec, this.durationSec = 2})
      : super(key: key);

  @override
  BirthdayEffectTwoSingleState createState() => BirthdayEffectTwoSingleState();
}

class BirthdayEffectTwoSingleState extends State<BirthdayEffectTwoSingle>
    with TickerProviderStateMixin {

  final double END_VALUE = 1.4;
  final  double X = 5.w.toDouble();
  final  double Y = 20.h.toDouble();
  final  double V = 2.h.toDouble();
  final  double W = 1.w.toDouble();

  final List<ui.Image> _images = [];
  AnimationController? _controller;

  final List<Particle> _particles = [];

  int count = 0;
  RenderState _state = RenderState.stop;

  int init = 0;

  BirthdayEffectTwoSingleState(){
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
  }

  Future<void> initParams(List<Particle> ps, double startX, double startY) async {
    if (widget.viewWidth != 0 && widget.viewHeight != 0 && ps.isEmpty) {
      count = 40;
      for (int i = 0; i < count; i++) {
        ps.add(_generatePartice(Colors.red, Random(), startX, startY));

      }
    }
  }

  @override
  void didUpdateWidget(BirthdayEffectTwoSingle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewWidth != widget.viewWidth ||
        oldWidget.viewHeight != widget.viewHeight) {
      _particles.clear();

      initParams(_particles, widget.startX, widget.startY);

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

    Future.delayed(Duration(seconds: widget.delaySec), (){
      _controller?.forward();
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
    particle.mag = 4.0.toDouble() * particle.top / particle.bottom * 2;
    particle.neg = (-particle.mag) / particle.bottom;
    f = startX + 10.w * Random().nextDouble();
    // f = 200.w + (Y * (random.nextDouble() - 0.5.toDouble()));

    particle.baseCx = f;
    particle.cx = f;
    f = startY + 20.h * Random().nextDouble();
    // f = 200.h + (Y * (random.nextDouble() - 0.5.toDouble()));

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
  final BirthdayEffectTwoSingleState _state;

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
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

import 'dart:math';

import 'package:dt_animate_kit/effects_state.dart';
import 'package:dt_animate_kit/image_utils.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_screenutil/flutter_screenutil.dart';


class BirthdayEffectOne extends StatefulWidget {
  final double viewWidth;
  final double viewHeight;

  const BirthdayEffectOne(
      {Key? key, required this.viewWidth, required this.viewHeight})
      : super(key: key);

  @override
  BirthdayEffectOneState createState() => BirthdayEffectOneState();
}

class BirthdayEffectOneState extends State<BirthdayEffectOne>
    with SingleTickerProviderStateMixin {
  final List<ui.Image> _images = [];
  AnimationController? _controller;
  final List<EffectBirthdayOneParams> _particle = [];
  int count = 0;
  EffectsState? _state;

  Future<void> fetchImages() async {
    var image1 = await ImageUtils.getImage('packages/dt_animate_kit/assets/images/birthday1.png');
    var image2 = await ImageUtils.getImage('packages/dt_animate_kit/assets/images/birthday2.png');
    var image3 = await ImageUtils.getImage('packages/dt_animate_kit/assets/images/birthday3.png');
    var image4 = await ImageUtils.getImage('packages/dt_animate_kit/assets/images/birthday4.png');
    var image5 = await ImageUtils.getImage('packages/dt_animate_kit/assets/images/birthday5.png');

    _images.clear();
    _images.add(image1);
    _images.add(image2);
    _images.add(image3);
    _images.add(image4);
    _images.add(image5);
    _state = EffectsState.init;
    setState(() {});
  }

  Future<void> initParams() async {
    _state = EffectsState.loading;
    print("width is ${widget.viewWidth}, height is ${widget.viewHeight}");
    if (widget.viewWidth != 0 && widget.viewHeight != 0 && _particle.isEmpty) {
      count = 200;
      // var widthRatio = ScreenUtil.defaultSize.width / 392.0;
      // var heightRatio = ScreenUtil.defaultSize.height / 817;
      for (int i = 0; i < count; i++) {
        int imageIndex = Random().nextInt(4);
        var effectBirthdayOneParams = EffectBirthdayOneParams(
            widget.viewWidth, widget.viewHeight, _images[imageIndex]);
        effectBirthdayOneParams.init(/*widthRatio, heightRatio*/);
        _particle.add(effectBirthdayOneParams);
      }
    }
    _controller?.forward();
    _state = EffectsState.finish;
  }

  @override
  void didUpdateWidget(BirthdayEffectOne oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewWidth != widget.viewWidth ||
        oldWidget.viewHeight != widget.viewHeight) {
      _particle.clear();
      initParams();
    }
  }

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(minutes: 1), vsync: this);
    // CurvedAnimation(parent: _controller!!, curve: Curves.linear);
    _controller?.addListener(() {
      setState(() {});
    });
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller?.repeat();
      }
    });
    fetchImages();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == EffectsState.init) {
      initParams();
    } else if (_state == EffectsState.finish) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomPaint(
          painter: EffectBirthdayOnePainter(this),
        ),
      );
    }
    return Container();
  }
}

class EffectBirthdayOnePainter extends CustomPainter {
  final _paint = Paint();
  final BirthdayEffectOneState _state;

  EffectBirthdayOnePainter(this._state);

  @override
  void paint(Canvas canvas, Size size) {
      draw(canvas, size);
  }


  void move(EffectBirthdayOneParams params) {
    params.y = params.y! + params.speed!;
    double offsetX = sin(params.y! / (300 + 50 * params.alpha!)) *
        (1 + 0.5 * params.alpha!) ;
    params.x = params.x! + offsetX;

    if (params.y! > params.height!) {
      params.y = -params.height! + Random().nextInt(params.height!.toInt());
      params.reset();
    }
  }

  void draw(Canvas canvas, Size size) {
    if (_state._images.length > 1) {
      if (_state._particle.isNotEmpty) {
        canvas.save();
        Rect rect = Offset.zero & size;
        canvas.drawRect(rect, Paint());
        for (var element in _state._particle) {
          move(element);
          ui.Offset offset = ui.Offset(element.x!, element.y!);
          canvas.save();
          canvas.scale(element.scale!, element.scale);

          canvas.drawImage(element.image!, offset, _paint);
          canvas.restore();
        }
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class EffectBirthdayOneParams {

  /// 图片
  ui.Image? image;

  /// x 坐标
  double? x;

  /// y 坐标
  double? y;

  /// 下落速度
  double? speed;

  /// 绘制的缩放
  double? scale;

  /// 宽度
  double? width;

  /// 高度
  double? height;

  /// 透明度
  double? alpha;

  // double? widthRatio;
  // double? heightRatio;

  EffectBirthdayOneParams(this.width, this.height, this.image);

  void init(/*widthRatio, heightRatio*/) {
    // this.widthRatio = widthRatio;
    // this.heightRatio = max(heightRatio, 0.65);
    reset();
    y = Random().nextInt(height!.toInt()).toDouble() - height!;
  }

  /// 当雪花移出屏幕时，需要重置参数
  void reset() {
    double ratio = 1.0;
    double random = 0.4 + 0.12 * Random().nextDouble() * 5;
    scale = 1;
    speed = 8 *  Random().nextDouble();
    alpha = random;
    x = Random().nextInt(width! * 1.2 ~/ scale!).toDouble() -
        width! * 0.1 ~/ scale!;
  }
}

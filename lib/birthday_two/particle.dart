import 'dart:math';
import 'dart:ui';

class Particle{



  late double alpha;
  late Color color;
  late double cx;
  late double cy;
  late double radius;
  late double baseCx;
  late double baseCy;
  late double baseRadius;
  late double top;
  late double bottom;
  late double mag;
  late double neg;
  late double life;
  late double overflow;
  late Image image;


  void advance(double factor, double V, double endValue) {
    double f = 0.toDouble();
    double normalization = factor / endValue;
    if (normalization < life || normalization > 1.toDouble() - overflow) {
      alpha = 0.toDouble();
      return;
    }
    normalization = (normalization - life) / (1.toDouble() - life - overflow);
    double f2 = normalization * endValue;
    if (normalization >= 0.7.toDouble()) {
      f = (normalization - 0.7.toDouble()) / 0.3.toDouble();
    }
    // alpha = 1.toDouble() - f;
    alpha = 1;
    f = bottom * f2;
    cx = baseCx + f * 3;
    cy = (baseCy - neg * pow(f, 2.0)).toDouble() - f * mag;
    radius = V + (baseRadius - V) * f2;
  }

  @override
  String toString() {
    return 'Particle{alpha: $alpha, color: $color, cx: $cx, cy: $cy, radius: $radius, baseCx: $baseCx, baseCy: $baseCy, baseRadius: $baseRadius, top: $top, bottom: $bottom, mag: $mag, neg: $neg, life: $life, overflow: $overflow}';
  }
}
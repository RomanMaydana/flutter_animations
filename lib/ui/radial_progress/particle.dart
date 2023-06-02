
import 'dart:math';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/material.dart';

class Particle{
  double orbit;
  late double originalOrbit;
  late double theta;
  late double opacity;
  late Color color;
  
  Particle(this.orbit){
    originalOrbit = orbit;
    theta = vector.radians(getRandomRange(0.0, 360) );
    opacity = getRandomRange(0.3, 1);
    color = Colors.white;
  }

  void update(){
    orbit += 0.1;
    opacity -= 0.0025;
    if(opacity <= 0.0){
      orbit = originalOrbit;
      opacity = getRandomRange(0.1, 1);
    }
  }

}

final rnd = Random();

double getRandomRange(double min, double max){
  return rnd.nextDouble()*(max- min)+min;
}

Offset polarToCartesian(double r, double theta){
  final dx = r * cos(theta);
  final dy = r * sin(theta);
  return Offset(dx, dy);
}
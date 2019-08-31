import 'dart:math';

import 'package:flutter/material.dart';

class RandomColor{
  final List<Color> _colors=[
    Colors.blue,
    Colors.blue[300],
    Colors.blueGrey[300],
    Colors.yellow,
    Colors.yellow[300],
    Colors.orange,
    Colors.black,
    Colors.red,
    Colors.redAccent,
    Colors.green,
    Colors.orangeAccent,
    Colors.orange[300],
    Colors.deepOrange[300],
    Colors.red[300],
    Colors.teal[300],
    Colors.indigo[300],
    Colors.purple[300],
    Colors.deepPurple[300]
  ];
  final Random _random=Random();

  RandomColor();

  Color get randomcolor=>_colors[_random.nextInt(_colors.length)];
}
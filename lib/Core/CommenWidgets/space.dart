import 'package:aibak/Core/Utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:aibak/Core/Utils/size_utils.dart';

Widget space({double? h, double? w}) {
  return SizedBox(
    height: h ?? 20.v,
    width: w ?? 0.v,
  );
}

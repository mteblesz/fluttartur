import 'package:flutter/material.dart';

class RoundedDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;
  final EdgeInsetsGeometry padding;

  const RoundedDivider({
    super.key,
    this.color = Colors.black,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.padding = const EdgeInsets.all(5.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: indent),
        height: thickness,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(thickness / 2),
        ),
      ),
    );
  }
}

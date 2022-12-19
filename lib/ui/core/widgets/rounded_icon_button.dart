import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({super.key,
    required this.icon,
    required this.onPress,
    required this.iconSize,
    required this.fillColor,
    required this.iconColor});

  final IconData icon;
  final void Function()? onPress;
  final double iconSize;
  final Color fillColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: iconSize, height: iconSize),
      onPressed: onPress,
      padding: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(iconSize * 0.2)),
      fillColor: fillColor,
      elevation: 0,
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize * 0.6,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

class QuickAccessCard extends StatefulWidget {
  final String text ;
  final VoidCallback ontap ;
  const QuickAccessCard({super.key, required this.text, required this.ontap});

  @override
  State<QuickAccessCard> createState() => _QuickAccessCardState();
}

class _QuickAccessCardState extends State<QuickAccessCard> {

  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Transform.scale(
        scale: _scale,
        child: InkWell(
          onTap: widget.ontap,
          child: Container(
            height: 40,
            width: 170,
            decoration: BoxDecoration(
              color: AppColors.theme['offWhite'],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(widget.text)),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../Utils/ThemeData/colors.dart';

class AuthButton extends StatefulWidget {
  final Future<void> Function()? onpressed;
  final String name;
  final Color bcolor;
  final Color tcolor;
  final bool isLoading;

  AuthButton({
    Key? key,
    required this.onpressed,
    required this.name,
    required this.bcolor,
    required this.tcolor,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: widget.onpressed,
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut, // Animation curve
            height: 50,
            width: widget.isLoading ? mq.width * 0.5 : mq.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.bcolor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.isLoading)
                  Container(
                    height: 25,
                    width: 25,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: AppColors.theme['white'],
                      ),
                    ),
                  ),
                SizedBox(width: widget.isLoading ? 10 : 0),
                Center(
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: widget.tcolor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
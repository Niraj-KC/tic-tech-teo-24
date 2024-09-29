import 'package:flutter/material.dart';
import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

class HomeWorkCard extends StatefulWidget {
  final Homework homework;
  //todo : model of homework/submission
  final VoidCallback onTap ;

  const HomeWorkCard({super.key, required this.onTap, required this.homework});

  @override
  State<HomeWorkCard> createState() => _HomeWorkCardState();
}

class _HomeWorkCardState extends State<HomeWorkCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: InkWell(
        onTap: widget.onTap,
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: Card(
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/hw.png"),
              ),
              tileColor: Colors.white,
              title :Text("${widget.homework.title}",style: TextStyle(color: AppColors.theme['black'],fontWeight: FontWeight.bold,),
            ),
          ),
          )
        ),
      ),
    );
  }
}

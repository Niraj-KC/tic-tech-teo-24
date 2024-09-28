import 'package:flutter/material.dart';
import 'package:teach_assist/Utils/HelperFunctions/HelperFunction.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkCard extends StatefulWidget {
  final String text;
  final String url;
  const LinkCard({super.key, required this.text, required this.url});

  @override
  State<LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.theme['offWhite'],
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 20,),
          Image.asset("assets/images/pdf_icon.png",height: 50,width:50 ,),
          SizedBox(width: 20,),
          InkWell(
            onTap: (){
              HelperFunction.launchURL(widget.url);
            },
              child: Text(
            widget.text,
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
           )
          ),
        ],
      ),
    );
  }
}

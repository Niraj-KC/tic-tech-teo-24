import 'package:flutter/material.dart';
import 'package:teach_assist/Utils/HelperFunctions/HelperFunction.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';

class LinkCard extends StatefulWidget {
  final String text;
  final String url;

  const LinkCard({super.key, required this.text, required this.url, });

  @override
  State<LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:  5.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.theme['offWhite'].withOpacity(0.4),
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(width: 20,),
            Image.asset("assets/images/pdf_icon.png",height: 40,width:40 ),
            SizedBox(width: 20,),
            InkWell(
              onTap: (){
                HelperFunction.launchURL(widget.url);
              },
                child: Container(
                  width: MediaQuery.of(context).size.width*.6,
                  child: Text(
                              widget.text,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 18),
                             ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

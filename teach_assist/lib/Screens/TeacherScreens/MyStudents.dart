import 'package:flutter/material.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

import '../../Components/CustomTextField.dart';

class MyStudents extends StatefulWidget {
  const MyStudents({super.key});

  @override
  State<MyStudents> createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        appBar: AppBar(
          backgroundColor: AppColors.theme['green'],
          centerTitle: true,
          title: Text(
            "My Students",
            style: TextStyle(
                color: AppColors.theme['white'],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25,
                color: Colors.white,
              )),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: const CustomTextField(
                hintText: "Search Students",
                isNumber: false,
                obsecuretext: false,
                prefixicon: Icon(Icons.search_rounded),
              ),
            ),
            // Expanded(
            //
            //  // todo :add here
            // )
          ],
        ),
      ),
    );
  }
}

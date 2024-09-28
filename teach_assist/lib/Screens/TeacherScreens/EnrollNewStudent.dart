import 'package:flutter/material.dart';
import 'package:teach_assist/Components/CustomButton.dart';
import 'package:teach_assist/Components/CustomTextField.dart';

import '../../Utils/ThemeData/colors.dart';

class NewStudent extends StatefulWidget {
  const NewStudent({super.key});

  @override
  State<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _rollNoController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _semController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Image.asset(
              "assets/images/new_student.png",
              height: 200,
              width: 200,
            )),
            SizedBox(
              height: 10,
            ),
            Text(
              "Enroll new student",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                hintText: "Enter student name",
                isNumber: false,
                obsecuretext: false,
                 controller: _nameController,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                hintText: "Enter student roll no",
                isNumber: false,
                obsecuretext: false,
                prefixicon: Icon(Icons.numbers_sharp),
                controller: _rollNoController,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                hintText: "Enter student department",
                isNumber: false,
                obsecuretext: false,
                prefixicon: Icon(Icons.group),
               controller: _departmentController,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                hintText: "Current Sem(1-8)",
                isNumber: false,
                obsecuretext: false,
              prefixicon: Icon(Icons.numbers_outlined),
              controller: _semController,
            ),
            SizedBox(
              height: 20,
            ),
            AuthButton(
                onpressed: () async {

                  //todo:store info into database for sign up new student


                },
                name: _isLoading ? "Enrolling..." : "Enroll",
                bcolor: AppColors.theme['green'],
                tcolor: AppColors.theme['white'],
                isLoading: _isLoading)
          ],
        ),
      ),
    );
  }
}

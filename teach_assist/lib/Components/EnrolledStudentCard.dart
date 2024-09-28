import 'package:flutter/material.dart';
import '../Models/Student.dart';
import '../Utils/ThemeData/colors.dart';

class EnrolledStudentCard extends StatefulWidget {
  final Student st;
  final bool isEnrolled;

  const EnrolledStudentCard({super.key, required this.st, required this.isEnrolled});

  @override
  State<EnrolledStudentCard> createState() => _EnrolledStudentCardState();
}

class _EnrolledStudentCardState extends State<EnrolledStudentCard> {
  late bool _isEnrolled;
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isEnrolled = widget.isEnrolled;
    _isChecked = false;
  }

  void toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.theme['offWhite'],
      child: ListTile(
        tileColor: AppColors.theme['offWhite'],
        leading: _isEnrolled
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                        Icons.verified_user,
                        color: AppColors.theme['green'],
                      ),
            )
            : Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            toggleCheckbox();
          },
          activeColor: AppColors.theme['green'],
        ),
        title: Text(
          widget.st.name ?? "",
          style: TextStyle(
            color: AppColors.theme['black'],
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.st.rollNo ?? "",
          style: TextStyle(color: AppColors.theme['black']),
        ),
      ),
    );
  }
}

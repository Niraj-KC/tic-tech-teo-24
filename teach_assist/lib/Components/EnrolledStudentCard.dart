import 'package:flutter/material.dart';
import '../Models/Student.dart';
import '../Utils/ThemeData/colors.dart';

class EnrolledStudentCard extends StatefulWidget {
  final Student st;
  final bool isEnrolled;
  final Function(Student) addStudent;
  final Function(Student) removeStudent;

  const EnrolledStudentCard({super.key, required this.st, required this.isEnrolled, required this.addStudent, required this.removeStudent});

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
      _isChecked ? widget.addStudent(widget.st): widget.removeStudent(widget.st);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 5),
      child: Material(
        elevation: 0,
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: Card(
          elevation: 0,
          color: AppColors.theme['white'],
          child: ListTile(
            tileColor: AppColors.theme['white'],
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
        ),
      ),
    );
  }
}

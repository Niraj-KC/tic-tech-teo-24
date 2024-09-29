import 'package:flutter/material.dart';
import 'package:teach_assist/API/FireStoreAPIs/studentServices.dart';
import 'package:teach_assist/API/FireStoreAPIs/subjectServices.dart';
import 'package:teach_assist/Components/CustomTextField.dart';
import 'package:teach_assist/Models/Subject.dart';
import 'package:teach_assist/Screens/TeacherScreens/AllCourses.dart';
import 'package:teach_assist/Screens/TeacherScreens/TeacherHomeScreen.dart';
import 'package:teach_assist/Transitions/RightToLeft.dart';
import 'package:teach_assist/Utils/HelperFunctions/HelperFunction.dart';

import '../../Components/EnrolledStudentCard.dart';
import '../../Models/Student.dart';
import '../../Utils/ThemeData/colors.dart';

class EnrolledStudents extends StatefulWidget {
  final Subject subject;

  const EnrolledStudents({required this.subject, super.key});

  @override
  State<EnrolledStudents> createState() => _EnrolledStudentsState();
}

class _EnrolledStudentsState extends State<EnrolledStudents> {
  Student st = Student(
      id: "12",
      name: "Hitesh Mori",
      rollNo: "22BCE197",
      currentSem: "4",
      departmentId: "CSE",
      allocatedSubjects: []);

  List<Student> _selectedStudents = [];
  bool _isLoading = false;

  void _addStudent(Student student) {
    // setState(() {
    _selectedStudents.add(student);
    // });
  }

  void _removeStudent(Student student) {
    // setState(() {
    _selectedStudents
        .removeWhere((studentInList) => student.id == studentInList.id);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, RightToLeft(AllCourses()));
            },
              child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 28,
          )),
          centerTitle: true,
          backgroundColor: AppColors.theme['green'],
          title: Text(
            "All Students",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.theme['green'],
          onPressed: () async {
            print("#ss $_selectedStudents");
            setState(() {
              _isLoading = true;
            });
            final res = await SubjectService()
                .enrollStudents(widget.subject, _selectedStudents);

            // _selectedStudents.forEach((selStudent) {
            //   _students.removeWhere((stud) => stud.id == selStudent.id);
            //   _students.add(selStudent);
            // });

            // Navigator.pop(context);

            setState(() {
              _isLoading = false;
            });
            HelperFunction.showToast(res);
          },
          child: _isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
        ),
        backgroundColor: AppColors.theme['offWhite'],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: const CustomTextField(
                    hintText: "Search Students",
                    isNumber: false,
                    obsecuretext: false,
                    prefixicon: Icon(Icons.search_rounded),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  // todo: add here stream builder of students that are enrolled in specific course

                  children: [
                    FutureBuilder(
                      future: StudentService().getAllStudents(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Text('No subjects found');
                        }

                        List<Student> students = snapshot.data!;

                        return Column(
                          children: students
                              .map((e) => EnrolledStudentCard(
                                    st: e,
                                    isEnrolled: (e.allocatedSubjects?.any(
                                            (element) =>
                                                element.id ==
                                                widget.subject.id) ??
                                        false),
                                    addStudent: _addStudent,
                                    removeStudent: _removeStudent,
                                  ))
                              .toList(),
                        );
                      },
                    )
                  ],
                )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

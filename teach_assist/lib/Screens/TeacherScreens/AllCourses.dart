import 'package:flutter/material.dart' ;
import 'package:provider/provider.dart';
import 'package:teach_assist/API/FireStoreAPIs/teacherServices.dart';
import 'package:teach_assist/Components/CourseCard2.dart';
import 'package:teach_assist/Models/Subject.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import 'package:teach_assist/Screens/TeacherScreens/EnrolledStudents.dart';
import 'package:teach_assist/Transitions/LeftToRight.dart';

import '../../Components/CustomTextField.dart';
import '../../Utils/ThemeData/colors.dart';


class AllCourses extends StatefulWidget {
  const AllCourses({super.key});

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        body: Consumer<CurrentUserProvider>(builder: (context, userProvider, child){
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: CustomTextField(
                      hintText: "Search Courses",
                      isNumber: false,
                      obsecuretext: false,
                      prefixicon: Icon(Icons.search_rounded),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                            // todo: add here stream builder of course that are tought by current user
                            children: [

                              // card => CourseCard2(subject sb)
                              StreamBuilder(
                                stream: TeacherService().getSubjectsForTeacher(userProvider.user),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    // return CircularProgressIndicator();
                                  }

                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Text('No subjects found');
                                  }

                                  List<Subject> subjects = snapshot.data!;

                                  return Column(
                                    children: subjects.map((e) {
                                      return InkWell(
                                          onTap: (){
                                            Navigator.push(context, LeftToRight(EnrolledStudents(subject: e,)));
                                          },
                                          child: CourseCard2(sb: e)
                                      );
                                    }).toList(),
                                  );
                                },
                              )


                            ],
                          )))
                ],
              ),
            ),
          );
        },),
      ),
    );
  }
}

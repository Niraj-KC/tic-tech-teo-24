import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/API/FireStoreAPIs/teacherServices.dart';
import 'package:teach_assist/Components/CourseCard2.dart';
import 'package:teach_assist/Models/Subject.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import 'package:teach_assist/Screens/TeacherScreens/EnrolledStudents.dart';
import 'package:teach_assist/Screens/TeacherScreens/TeacherHomeScreen.dart';
import 'package:teach_assist/Transitions/LeftToRight.dart';
import 'package:teach_assist/Transitions/RightToLeft.dart';

import '../../Components/CustomTextField.dart';
import '../../Utils/ThemeData/colors.dart';

class AllCourses extends StatefulWidget {
  const AllCourses({super.key});

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  List<Subject> list = []; // Full list of subjects
  List<Subject> result = []; // Filtered list based on search
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "All Subjects",
            style: TextStyle(
                color: AppColors.theme['white'],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, RightToLeft(TeacherHomeScreen())) ;
            },
              child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25,
            color: Colors.white,
          )),
          backgroundColor: AppColors.theme['green'],
        ),
        backgroundColor: AppColors.theme['offWhite'],
        body: Consumer<CurrentUserProvider>(
          builder: (context, userProvider, child) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSearching = !isSearching;
                        });
                      },
                      child: Container(
                        height: 70,
                        color: AppColors.theme['offWhite'],
                        child: CustomTextField(
                          hintText: "Search Courses",
                          isNumber: false,
                          isEnable: isSearching,
                          obsecuretext: false,
                          prefixicon: Icon(Icons.search_rounded),
                          onChange: (val) {
                            result.clear();
                            // Ensure UI update happens for each character typed
                            if (val != null && val.isNotEmpty) {
                              for (var i in list) {
                                if (i.name!
                                        .toLowerCase()
                                        .contains(val.toLowerCase()) ||
                                    i.courseCode!
                                        .toLowerCase()
                                        .contains(val.toLowerCase())) {
                                  result.add(i);
                                }
                              }
                            }
                            setState(
                                () {}); // Update state immediately after each change
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            StreamBuilder<List<Subject>>(
                              stream: TeacherService()
                                  .getSubjectsForTeacher(userProvider.user),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // return Center(child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                      child: Text('No subjects found'));
                                }

                                list = snapshot.data!;

                                final displayedCourses =
                                    isSearching && result.isNotEmpty
                                        ? result
                                        : list;

                                return Column(
                                  children: displayedCourses.map((e) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            LeftToRight(
                                                EnrolledStudents(subject: e)));
                                      },
                                      child: CourseCard2(sb: e),
                                    );
                                  }).toList(),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

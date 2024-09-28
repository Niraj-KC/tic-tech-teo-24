import 'package:flutter/material.dart' ;

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
        body: SafeArea(
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

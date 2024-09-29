import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/API/FireStoreAPIs/teacherServices.dart';
import 'package:teach_assist/Components/CustomTextField.dart';
import 'package:teach_assist/Models/Subject.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import 'package:teach_assist/Screens/AuthScreens/LoginScreen.dart';
import 'package:teach_assist/Screens/TeacherScreens/AllCourses.dart';

import 'package:teach_assist/Transitions/LeftToRight.dart';
import 'package:teach_assist/Transitions/RightToLeft.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

import '../../API/FirebaseAPIs.dart';
import '../../Components/CourseCard.dart';
import '../../Components/QuickAccessCard.dart';
import '../../main.dart';
import 'AnnouncementScreen.dart';
import 'Attendance/GenerateLink.dart';
import 'Attendance/session_history.dart';
import 'Homework/AllCourseHomework.dart';
import 'CreateNewStudent.dart';
import 'IntroduceSubject.dart';
import 'MyStudents.dart';
import 'PostHomeWorks.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({
    super.key,
  });

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<CurrentUserProvider>(builder: (context, value, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.theme['white'],
          key: _scaffoldKey,
          drawer: Drawer(
            backgroundColor: AppColors.theme['white'],
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.theme['offWhite'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                        leading: Image.asset("assets/images/teacher.png"),
                        title: Text(
                          value.user.name ?? "Hitesh Mori",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Professor"),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await FirebaseAPIs.auth.signOut();
                            Navigator.pushReplacement(
                                context, RightToLeft(LoginScreen()));
                          },
                        )),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        "Attendance",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme['black']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, LeftToRight(GenerateAttendanceLink())) ;
                        },
                        leading: Icon(Icons.mark_chat_read_outlined),
                        title: Text(
                          "Generate Links",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, LeftToRight(SessionHistory())) ;
                        },
                        leading: Icon(Icons.mark_chat_read_outlined),
                        title: Text(
                          "Lecture History",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        leading: Icon(Icons.reviews_outlined),
                        title: Text(
                          "Scheduled Lectures",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        "Subjects",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme['black']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context, LeftToRight(Introducesubject()));
                        },
                        leading: Icon(Icons.add_box_rounded),
                        title: Text(
                          "Introduce Subject",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, LeftToRight(AllCourses()));
                        },
                        leading: Icon(Icons.group_add),
                        title: Text(
                          "All Subjects",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        "Test",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme['black']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        leading: Icon(Icons.history_edu_outlined),
                        title: Text(
                          "View Past Test",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        leading: Icon(Icons.add),
                        title: Text(
                          "Make Test",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        "Upload",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme['black']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, LeftToRight(PostHomeWorks()));
                        },
                        leading: Icon(Icons.upload_file_outlined),
                        title: Text(
                          "Post Homeworks",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, LeftToRight(AllCourseHomeWork()));
                        },
                        leading: Icon(Icons.check_circle_outline),
                        title: Text(
                          "Check Homeworks",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        "Notify",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme['black']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, LeftToRight(AnnouncementScreen())) ;
                        },
                        leading: Icon(Icons.notifications_active_outlined),
                        title: Text(
                          "Make An Announcements",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        "Students",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme['black']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, LeftToRight(NewStudent()));
                        },
                        leading: Icon(Icons.add),
                        title: Text(
                          "Enroll New Students",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context, LeftToRight(const AllCourses()));
                        },
                        leading: Icon(Icons.verified_user_rounded),
                        title: Text(
                          "Enrolled Students",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context, LeftToRight(const MyStudents()));
                        },
                        leading: Icon(Icons.group),
                        title: Text(
                          "My Students",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )
              ],
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.theme['offWhite'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: mq.width * 0.05,
                        ),
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/teacher.png"),
                            backgroundColor: AppColors.theme['white'],
                          ),
                        ),
                        Center(
                          child: Container(
                            width: mq.width * 0.7,
                            child: CustomTextField(
                              hintText: "Search Here Courses",
                              isNumber: false,
                              obsecuretext: false,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Quick Access",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      QuickAccessCard(
                        text: 'Take Attendance',
                        ontap: () {},
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      QuickAccessCard(
                        text: 'Attendance Review',
                        ontap: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "My Courses",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          StreamBuilder(
                            stream: TeacherService()
                                .getSubjectsForTeacher(value.user),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // return CircularProgressIndicator();
                              }

                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Text('No subjects found');
                              }

                              List<Subject> subjects = snapshot.data!;

                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Two columns
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: subjects.length,
                                shrinkWrap: true, // Prevents height issues
                                physics:
                                    NeverScrollableScrollPhysics(), // Disable scrolling
                                itemBuilder: (context, index) {
                                  final subject = subjects[index];
                                  return CourseCard(
                                    sub: subject,
                                    isStudent: false,
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

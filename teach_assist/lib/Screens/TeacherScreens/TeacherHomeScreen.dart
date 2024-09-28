import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:teach_assist/API/FireStoreAPIs/teacherServices.dart';
import 'package:teach_assist/Components/CustomTextField.dart';
import 'package:teach_assist/Models/Subject.dart';

import 'package:teach_assist/Screens/TeacherScreens/EnrolledStudents.dart';
import 'package:teach_assist/Transitions/LeftToRight.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

import '../../Components/CourseCard.dart';
import '../../Components/QuickAccessCard.dart';
import '../../Models/Teacher.dart';
import '../../main.dart';
import 'CreateNewStudent.dart';
import 'IntroduceSubject.dart';

class TeacherHomeScreen extends StatefulWidget {
  final Teacher teacher ;
  const TeacherHomeScreen({super.key, required this.teacher});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // // Dummy subject list
  // List<Subject> subjects = [
  //   Subject(
  //     id: '1',
  //     name: 'Intro Programming',
  //     courseCode: 'CS101',
  //     departmentId: 'CSE',
  //     coursePolicy: '',
  //     materials: ['Textbook: Programming Basics', 'Online Resources'],
  //   ),
  //   Subject(
  //     id: '2',
  //     name: 'Data Structures',
  //     courseCode: 'CS102',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Mandatory',
  //     materials: ['Textbook: Data Structures', 'Lecture Notes'],
  //   ),
  //   Subject(
  //     id: '3',
  //     name: 'DBMS',
  //     courseCode: 'CS103',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Mandatory',
  //     materials: ['Textbook: DBMS Fundamentals', 'Practice Exercises'],
  //   ),
  //   Subject(
  //     id: '4',
  //     name: 'Software Engineering',
  //     courseCode: 'CS104',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Mandatory',
  //     materials: ['Textbook: Software Engineering', 'Project Guidelines'],
  //   ),
  //   Subject(
  //     id: '5',
  //     name: 'Computer Networks',
  //     courseCode: 'CS105',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Elective',
  //     materials: ['Textbook: Networking Basics', 'Lab Manual'],
  //   ),
  //   Subject(
  //     id: '6',
  //     name: 'Web Development',
  //     courseCode: 'CS106',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Elective',
  //     materials: ['Textbook: Web Design', 'Online Tutorials'],
  //   ),
  //   Subject(
  //     id: '7',
  //     name: 'Machine Learning',
  //     courseCode: 'CS107',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Elective',
  //     materials: ['Textbook: ML Basics', 'Research Papers'],
  //   ),
  //   Subject(
  //     id: '8',
  //     name: 'Operating Systems',
  //     courseCode: 'CS108',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Mandatory',
  //     materials: ['Textbook: OS Concepts', 'Practical Assignments'],
  //   ),
  //   Subject(
  //     id: '9',
  //     name: 'Mobile Application',
  //     courseCode: 'CS109',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Elective',
  //     materials: ['Textbook: Mobile Development', 'Sample Projects'],
  //   ),
  //   Subject(
  //     id: '10',
  //     name: 'Artificial Intelligence',
  //     courseCode: 'CS110',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Elective',
  //     materials: ['Textbook: AI Fundamentals', 'Online Courses'],
  //   ),
  //   Subject(
  //     id: '11',
  //     name: 'Human-Computer Interaction',
  //     courseCode: 'CS111',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Elective',
  //     materials: ['Textbook: HCI Principles', 'Research Articles'],
  //   ),
  //   Subject(
  //     id: '12',
  //     name: 'Cyber Security',
  //     courseCode: 'CS112',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Elective',
  //     materials: ['Textbook: Cyber Security', 'Case Studies'],
  //   ),
  //   Subject(
  //     id: '13',
  //     name: 'Cloud Computing',
  //     courseCode: 'CS113',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Elective',
  //     materials: ['Textbook: Cloud Basics', 'Hands-on Labs'],
  //   ),
  //   Subject(
  //     id: '14',
  //     name: 'Digital Signal Processing',
  //     courseCode: 'CS114',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Elective',
  //     materials: ['Textbook: DSP Basics', 'Practical Assignments'],
  //   ),
  //   Subject(
  //     id: '15',
  //     name: 'Computer Graphics',
  //     courseCode: 'CS115',
  //     departmentId: 'CSE',
  //     coursePolicy: 'Elective',
  //     materials: ['Textbook: Computer Graphics', 'Project Guidelines'],
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
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
                      widget.teacher.name ?? "Hitesh Mori",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Professor"),
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
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
                        leading: Icon(Icons.mark_chat_read_outlined),
                        title: Text("Take Attendance",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 14),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        leading: Icon(Icons.reviews_outlined),
                        title: Text(
                          "Attendance Review",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                      child: Text("Subjects",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.theme['black']),),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, LeftToRight(Introducesubject())) ;
                        },
                        leading: Icon(Icons.add_box_rounded),
                        title: Text("Introduce Subject",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 14),),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                      child: Text("Test",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.theme['black']),),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        leading: Icon(Icons.history_edu_outlined),
                        title: Text("View past test",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 14),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        leading: Icon(Icons.add),
                        title: Text("Make test",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 14),),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                      child: Text("Upload",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.theme['black']),),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        leading: Icon(Icons.upload_file_outlined),
                        title: Text("Upload Homework",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 14),),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                      child: Text("Notify",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.theme['black']),),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        leading: Icon(Icons.notifications_active_outlined),
                        title: Text("Make an Announcements",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 14),),
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
                        onTap: (){
                          Navigator.push(context, LeftToRight(NewStudent())) ;
                        },
                        leading: Icon(Icons.add),
                        title: Text(
                          "Enroll new students",
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
                          Navigator.push(context, LeftToRight(Enrolledstudents())) ;
                        },
                        leading: Icon(Icons.verified_user_rounded),
                        title: Text(
                          "Enrolled students",
                          style: TextStyle(
                              color: AppColors.theme['black'].withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                  ],
                ),
              ))
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
                            hintText: "Search here Courses",
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
                            stream: TeacherService().getSubjectsForTeacher(widget.teacher),
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

                              return GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Two columns
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: subjects.length,
                                shrinkWrap: true, // Prevents height issues
                                physics: NeverScrollableScrollPhysics(), // Disable scrolling
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
  }
}

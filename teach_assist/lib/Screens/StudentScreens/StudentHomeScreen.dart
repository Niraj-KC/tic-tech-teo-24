import 'package:flutter/material.dart';

import '../../Components/CourseCard.dart';
import '../../Components/CustomTextField.dart';
import '../../Components/QuickAccessCard.dart';
import '../../Models/Student.dart';
import '../../Models/Subject.dart';
import '../../Utils/ThemeData/colors.dart';
import '../../main.dart';

class StudentHomeScreen extends StatefulWidget {
  final Student student ;
  const StudentHomeScreen({super.key, required this.student});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Dummy subject list
  List<Subject> subjects = [
    Subject(
      id: '1',
      name: 'Intro Programming',
      courseCode: 'CS101',
      departmentId: 'CSE',
      coursePolicy: 'Mandatory',
      materials: ['Textbook: Programming Basics', 'Online Resources'],
    ),
    Subject(
      id: '2',
      name: 'Data Structures',
      courseCode: 'CS102',
      departmentId: 'CSE',
      coursePolicy: 'Mandatory',
      materials: ['Textbook: Data Structures', 'Lecture Notes'],
    ),
    Subject(
      id: '3',
      name: 'DBMS',
      courseCode: 'CS103',
      departmentId: 'CSE',
      coursePolicy: 'Mandatory',
      materials: ['Textbook: DBMS Fundamentals', 'Practice Exercises'],
    ),
    Subject(
      id: '4',
      name: 'Software Engineering',
      courseCode: 'CS104',
      departmentId: 'CSE',
      coursePolicy: 'Mandatory',
      materials: ['Textbook: Software Engineering', 'Project Guidelines'],
    ),
    Subject(
      id: '5',
      name: 'Computer Networks',
      courseCode: 'CS105',
      departmentId: 'CSE',
      coursePolicy: 'Elective',
      materials: ['Textbook: Networking Basics', 'Lab Manual'],
    ),
    Subject(
      id: '6',
      name: 'Web Development',
      courseCode: 'CS106',
      departmentId: 'CSE',
      coursePolicy: 'Elective',
      materials: ['Textbook: Web Design', 'Online Tutorials'],
    ),
    Subject(
      id: '7',
      name: 'Machine Learning',
      courseCode: 'CS107',
      departmentId: 'CSE',
      coursePolicy: 'Elective',
      materials: ['Textbook: ML Basics', 'Research Papers'],
    ),
    Subject(
      id: '8',
      name: 'Operating Systems',
      courseCode: 'CS108',
      departmentId: 'CSE',
      coursePolicy: 'Mandatory',
      materials: ['Textbook: OS Concepts', 'Practical Assignments'],
    ),
    Subject(
      id: '9',
      name: 'Mobile Application',
      courseCode: 'CS109',
      departmentId: 'CSE',
      coursePolicy: 'Elective',
      materials: ['Textbook: Mobile Development', 'Sample Projects'],
    ),
    Subject(
      id: '10',
      name: 'Artificial Intelligence',
      courseCode: 'CS110',
      departmentId: 'CSE',
      coursePolicy: 'Elective',
      materials: ['Textbook: AI Fundamentals', 'Online Courses'],
    ),
    Subject(
      id: '11',
      name: 'Human-Computer Interaction',
      courseCode: 'CS111',
      departmentId: 'CSE',
      coursePolicy: 'Elective',
      materials: ['Textbook: HCI Principles', 'Research Articles'],
    ),
    Subject(
      id: '12',
      name: 'Cyber Security',
      courseCode: 'CS112',
      departmentId: 'CSE',
      coursePolicy: 'Elective',
      materials: ['Textbook: Cyber Security', 'Case Studies'],
    ),
    Subject(
      id: '13',
      name: 'Cloud Computing',
      courseCode: 'CS113',
      departmentId: 'CSE',
      coursePolicy: 'Elective',
      materials: ['Textbook: Cloud Basics', 'Hands-on Labs'],
    ),
    Subject(
      id: '14',
      name: 'Digital Signal Processing',
      courseCode: 'CS114',
      departmentId: 'CSE',
      coursePolicy: 'Elective',
      materials: ['Textbook: DSP Basics', 'Practical Assignments'],
    ),
    Subject(
      id: '15',
      name: 'Computer Graphics',
      courseCode: 'CS115',
      departmentId: 'CSE',
      coursePolicy: 'Elective',
      materials: ['Textbook: Computer Graphics', 'Project Guidelines'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
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
                    leading: Image.asset("assets/images/student.png"),
                    title: Text(
                      "Niraj Chaudhary",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Student"),
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                          child: Text("Attendance",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.theme['black']),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListTile(
                            leading: Icon(Icons.mark_chat_read_outlined),
                            title: Text("View Attendance",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6)),),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                          child: Text("Subjects",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.theme['black']),),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListTile(
                            leading: Icon(Icons.subject_outlined),
                            title: Text("Subjects",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6)),),
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
                            title: Text("View past tests",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6)),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListTile(
                            leading: Icon(Icons.add),
                            title: Text("Upcoming tests",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6)),),
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
                            title: Text("Upload Homeworks",style: TextStyle(color: AppColors.theme['black'].withOpacity(0.6)),),
                          ),
                        ),


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
                          AssetImage("assets/images/student.png"),
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
                      text: 'Upcoming Submission',
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
                        GridView.builder(
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
                            return CourseCard(sub: subject, isStudent: true,);
                          },
                        ),
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

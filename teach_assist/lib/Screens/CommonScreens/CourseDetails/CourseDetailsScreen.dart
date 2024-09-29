import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teach_assist/API/FireStoreAPIs/subjectServices.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teach_assist/Components/CustomTextField.dart';
import 'package:teach_assist/Screens/CommonScreens/CourseDetails/link_card.dart';
import 'package:teach_assist/Utils/HelperFunctions/HelperFunction.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';
import '../../../Models/Subject.dart';
import '../../../main.dart';

class CourseDetailScreen extends StatefulWidget {
  final Subject sub;
  final bool isStudent;
  const CourseDetailScreen({super.key, required this.sub, required this.isStudent});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool iscp = true; // is course policy selected
  bool ishw = false; // is homework selected
  bool isln = false; // is class notes selected
  String selectedTab = "Course Policy"; // Currently selected tab

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.theme['green'],
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  void updateTab(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.theme['white'],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    (widget.sub.courseCode ?? "") + " - " + (widget.sub.name ?? ""),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTab("Course Policy"),
                    SizedBox(width: 5),
                    _buildTab("Materials"),
                    SizedBox(width: 5),
                    _buildTab("Home Work"),
                  ],
                ),
                SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: widget.isStudent ? buildStudentTabContent() : buildTeacherTabContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStudentTabContent() {
    File? _video;
    final picker = ImagePicker();


    //for picking videos
     Future<void> _pickVideo() async {
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _video = File(pickedFile.path);
        });
      } else {
        print('No video selected.');
      }
    }

    switch (selectedTab) {
      case "Course Policy":
        return (widget.sub.coursePolicy == null || widget.sub.coursePolicy!.isEmpty)
            ? Center(
                child: Text(
                  "Not uploaded yet",
                  style: TextStyle(color: AppColors.theme['black'].withOpacity(0.5), fontWeight: FontWeight.bold),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Course Policy",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LinkCard(text: "Course Policy", url: widget.sub.coursePolicy ?? "")
                ],
              );
      case "Materials":
        return Container(
          child:Column(
            children: [
              Row(
                children: [

                ],
              )
            ],
          )
        );

      case "Home Work":
        return Container(
           // todo:fetch here all home work for perticular course
        );
      default:
        return Container();
    }
  }

  Widget buildTeacherTabContent() {

    print("#CP: ${widget.sub.coursePolicy}");
    switch (selectedTab) {
      case "Course Policy":
        return (widget.sub.coursePolicy == null || widget.sub.coursePolicy!.isEmpty)
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: mq.height * 0.3),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Upload Course Policy",
                          style: TextStyle(color: AppColors.theme['black'].withOpacity(0.5), fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          TextEditingController linkController = TextEditingController();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: AppColors.theme['offWhite'],
                                title: Text(
                                  "Upload Course Policy",
                                  style: TextStyle(color: AppColors.theme['black'], fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Please provide the Google Drive link for the course policy.",
                                      style: TextStyle(color: AppColors.theme['black'], fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 20),
                                    CustomTextField(
                                      hintText: "Google Drive Link",
                                      isNumber: false,
                                      obsecuretext: false,
                                      controller: linkController,
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      String driveLink = linkController.text;
                                      if (driveLink.isNotEmpty) {
                                        setState(() {
                                          widget.sub.coursePolicy = driveLink;
                                        });

                                        SubjectService().updateCoursePolicy(widget.sub.id!, driveLink);
                                        Navigator.of(context).pop();
                                      } else {
                                        HelperFunction.showToast("Enter valid link");
                                      }
                                    },
                                    child: Text(
                                      "Upload",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          "Upload",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Course Policy",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LinkCard(text: "Course Policy", url: widget.sub.coursePolicy ?? "")
                ],
              );
      case "Materials":
        return Container(
          child: Text(
            "Materials Content",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      case "Home Work":
        return Container(
          child: Text(
            "Home Work Content",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      default:
        return Container();
    }
  }

  Widget _buildTab(String tabName) {
    bool isSelected = selectedTab == tabName;
    return GestureDetector(
      onTap: () => updateTab(tabName),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? AppColors.theme['green'] : AppColors.theme['white'],
          border: Border.all(color: AppColors.theme['black']),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Center(
          child: Text(
            tabName,
            style: TextStyle(
              color: isSelected ? AppColors.theme['white'] : AppColors.theme['black'],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

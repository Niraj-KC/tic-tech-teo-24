import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teach_assist/API/FireStoreAPIs/subjectServices.dart';
import 'package:teach_assist/Components/CustomTextField.dart';
import 'package:teach_assist/Screens/CommonScreens/CourseDetails/link_card.dart';
import 'package:teach_assist/Utils/HelperFunctions/HelperFunction.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';
import '../../../Models/Subject.dart';
import '../../../main.dart';

class CourseDetailScreen extends StatefulWidget {
  final Subject sub;
  final bool isStudent;
  const CourseDetailScreen(
      {super.key, required this.sub, required this.isStudent});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool iscp = true; // is course policy selected
  bool ishw = false; // is homework selected
  bool isln = false; // is class notes selected
  String? _noteName;
  String selectedTab = "Course Policy";
  File? _videoFile;

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

  Future<void> _pickVideoFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null) {
        setState(() {
          _videoFile = File(result.files.single.path!);
        });
        final fileSize = _videoFile!.lengthSync();
        print("Selected video file size: ${fileSize / (1024 * 1024)} MB");

        // Show dialog to enter video name
        _showVideoNameDialog();
      } else {
        // User canceled the picker
        print('No video file selected.');
      }
    } catch (e) {
      print("Error picking video file: $e");
    }
  }

  void _showVideoNameDialog() {
    TextEditingController noteNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.theme['offWhite'],
          title: Text(
            "Enter Note Name",
            style: TextStyle(
                color: AppColors.theme['black'],
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                hintText: "Note Name",
                isNumber: false,
                obsecuretext: false,
                controller: noteNameController,
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
                String enteredName = noteNameController.text;
                if (enteredName.isNotEmpty) {
                  setState(() {
                    _noteName = enteredName;
                  });


                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                    HelperFunction.showToast("Notes generation started!");
                  });
                } else {
                  HelperFunction.showToast("Please enter a valid note name.");
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
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    (widget.sub.courseCode ?? "") +
                        " - " +
                        (widget.sub.name ?? ""),
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
                    SizedBox(width: 15),
                    _buildTab("Materials"),
                    SizedBox(width: 15),
                    _buildTab("Homework"),
                  ],
                ),
                SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: widget.isStudent
                      ? buildStudentTabContent()
                      : buildTeacherTabContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStudentTabContent() {
    switch (selectedTab) {
      case "Course Policy":
        return (widget.sub.coursePolicy == null ||
            widget.sub.coursePolicy!.isEmpty)
            ? Center(
          child: Text(
            "Not uploaded yet",
            style: TextStyle(
                color: AppColors.theme['black'].withOpacity(0.5),
                fontWeight: FontWeight.bold),
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
            LinkCard(
                text: "Course Policy", url: widget.sub.coursePolicy ?? "")
          ],
        );
      case "Materials":
        return _buildMaterialsSection();
      case "Home Work":
        return Container(
          // todo:fetch here all home work for particular course
        );
      default:
        return Container();
    }
  }

  Widget buildTeacherTabContent() {
    print("#CP: ${widget.sub.coursePolicy}");
    switch (selectedTab) {
      case "Course Policy":
        return (widget.sub.coursePolicy == null ||
            widget.sub.coursePolicy!.isEmpty)
            ? Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: mq.height * 0.3),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Upload Course Policy",
                    style: TextStyle(
                        color:
                        AppColors.theme['black'].withOpacity(0.5),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    TextEditingController linkController =
                    TextEditingController();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.theme['offWhite'],
                          title: Text(
                            "Upload Course Policy",
                            style: TextStyle(
                                color: AppColors.theme['black'],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Please provide the Google Drive link for the course policy.",
                                style: TextStyle(
                                    color: AppColors.theme['black'],
                                    fontWeight: FontWeight.bold),
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
                                String driveLink =
                                    linkController.text;
                                if (driveLink.isNotEmpty) {
                                  setState(() {
                                    widget.sub.coursePolicy =
                                        driveLink;
                                  });

                                  SubjectService().updateCoursePolicy(
                                      widget.sub.id!, driveLink);
                                  Navigator.of(context).pop();
                                } else {
                                  HelperFunction.showToast(
                                      "Enter valid link");
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
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            LinkCard(
                text: "Course Policy", url: widget.sub.coursePolicy ?? "")
          ],
        );
      case "Materials":
        return _buildMaterialsSection();
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

  Widget _buildMaterialsSection() {
    return Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container()),
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: _pickVideoFile,
                        child: Container(
                          height: 50,
                          width: 60,
                          child: Center(
                              child: Text(
                                "Video",
                                style: TextStyle(
                                    color: AppColors.theme['black'],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10).copyWith(
                                topRight: Radius.zero,
                                bottomRight: Radius.zero,
                              ),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          TextEditingController pdfController =
                          TextEditingController();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: AppColors.theme['offWhite'],
                                title: Text(
                                  "Upload Course Policy",
                                  style: TextStyle(
                                      color: AppColors.theme['black'],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Please provide the Google Drive link for the course policy.",
                                      style: TextStyle(
                                          color: AppColors.theme['black'],
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 20),
                                    CustomTextField(
                                      hintText: "Google Drive Link",
                                      isNumber: false,
                                      obsecuretext: false,
                                      controller: pdfController,
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
                                      String driveLink =
                                          pdfController.text;
                                      if (driveLink.isNotEmpty) {

                                        // todo:store this is link in material
                                        // SubjectService().updateCoursePolicy(
                                        //     widget.sub.id!, driveLink);
                                        Navigator.of(context).pop();
                                        HelperFunction.showToast("Notes Uploaded!") ;

                                      } else {
                                        HelperFunction.showToast(
                                            "Enter valid link");
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
                        child: Container(
                          height: 50,
                          width: 60,
                          child: Center(
                              child: Text(
                                "Pdf",
                                style: TextStyle(
                                    color: AppColors.theme['black'],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10).copyWith(
                                topLeft: Radius.zero,
                                bottomLeft: Radius.zero,
                              ),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_videoFile != null) ...[
              SizedBox(height: 10),
              Column(
                children: [
                  //todo ; store all materail and fetch below
                  // card ;  LinkCard(text: "Video File", url: "Video",),
                ],
              )
            ]
          ],
        ));
  }

  Widget _buildTab(String tabTitle) {
    return InkWell(
      onTap: () {
        updateTab(tabTitle);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: selectedTab == tabTitle
              ? AppColors.theme['green']
              : AppColors.theme['offWhite'],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          tabTitle,
          style: TextStyle(
            color: selectedTab == tabTitle
                ? AppColors.theme['white']
                : AppColors.theme['black'],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

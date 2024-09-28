import 'package:flutter/material.dart';
import 'package:teach_assist/Components/CustomTextField.dart';
import 'package:teach_assist/Screens/TeacherScreens/TeacherHomeScreen.dart';
import 'package:teach_assist/Transitions/RightToLeft.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';
import 'package:intl/intl.dart';
import '../CommonScreens/CourseDetails/link_card.dart';

class PostHomeWorks extends StatefulWidget {
  const PostHomeWorks({super.key});

  @override
  State<PostHomeWorks> createState() => _PostHomeWorksState();
}
class _PostHomeWorksState extends State<PostHomeWorks> {

  List<Map<String, dynamic>> _links = [];

  //todo:fetch below courseids with course table or values
  List<String> _courseIds = ['Course ID 1', 'Course ID 2', 'Course ID 3'];

  TextEditingController _linkController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String? _selectedCourseId;

  void _addLink(String link, String name, String courseId) {
    if (link.isEmpty || name.isEmpty || courseId == null) {
      print("Link, Name, or Course ID cannot be empty.");
      return;
    }

    setState(() {
      _links.add({
        'link': link,
        'name': name,
        'timestamp': DateTime.now(),
        'courseId': courseId,
      });

      printHomeworkDetails(name, link, courseId);
    });
  }

  // todo:  get info about evry  added homework
  void printHomeworkDetails(String name, String link, String courseId) {
    print('Homework Added:');
    print('Title: $name');
    print('Google Drive Link: $link');
    print('Course ID: $courseId');
    print('Timestamp: ${DateTime.now()}');
  }

  Future<void> _showAddLinkDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.theme['offWhite'],
          title: Text(
            'Add Google Drive PDF Link',
            style: TextStyle(
              color: AppColors.theme['black'],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Container(
            height: 200, // Increased height to accommodate dropdown
            width: 500,
            child: Column(
              children: [
                CustomTextField(
                  hintText: "Enter name of pdf",
                  isNumber: false,
                  obsecuretext: false,
                  controller: _nameController,
                ),
                SizedBox(height: 5),
                CustomTextField(
                  hintText: "Enter GDrive Link Here",
                  isNumber: false,
                  obsecuretext: false,
                  controller: _linkController,
                ),
                SizedBox(height: 10),
                Container(
                  width: 250,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select Course ID',
                      labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)), // Label text color
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)), // Hint text color
                      filled: true,
                      fillColor: Colors.white, // Background color for the dropdown
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.theme['green']), // Focused border color
                        borderRadius: BorderRadius.circular(10), // Border radius
                      ),
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                    value: _selectedCourseId,
                    items: _courseIds.map((String courseId) {
                      return DropdownMenuItem<String>(
                        value: courseId,
                        child: Text(courseId),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCourseId = newValue;
                      });
                    },
                  ),
                ),

              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_linkController.text.isNotEmpty &&
                    _nameController.text.isNotEmpty &&
                    _selectedCourseId != null) {
                  _addLink(_linkController.text, _nameController.text, _selectedCourseId!);
                  _linkController.clear();
                  _nameController.clear();
                  setState(() {
                    _selectedCourseId = null; // Reset selected course ID
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDateHeading(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return DateFormat.EEEE().format(date);
    } else {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }

  Map<String, List<Map<String, dynamic>>> _groupLinksByDate(List<Map<String, dynamic>> links) {
    Map<String, List<Map<String, dynamic>>> groupedLinks = {};

    for (var linkData in links) {
      String formattedDate = _formatDateHeading(linkData['timestamp']);
      if (groupedLinks[formattedDate] == null) {
        groupedLinks[formattedDate] = [];
      }
      groupedLinks[formattedDate]!.add(linkData);
    }

    return groupedLinks;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, RightToLeft(TeacherHomeScreen()));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 28, color: Colors.white),
          ),
          backgroundColor: AppColors.theme['green'],
          title: Text(
            "Home Works",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.theme['green'],
          onPressed: _showAddLinkDialog,
          child: Icon(Icons.add_box_rounded, color: Colors.white),
        ),
        backgroundColor: AppColors.theme['offWhite'],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _links.isEmpty
                  ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "No homeworks posted yet.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
                  : Column(
                children: _groupLinksByDate(_links).entries.map((entry) {
                  String dateHeading = entry.key;
                  List<Map<String, dynamic>> linksOnDate = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Center(
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColors.theme['green'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              dateHeading,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: linksOnDate.map((linkData) {
                          String linkName = linkData['name'] ?? 'Unnamed Link';
                          String linkUrl = linkData['link'] ?? '#';
                          String courseId = linkData['courseId'] ?? 'No Course ID'; // Added Course ID

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: LinkCard(
                              text: "$linkName - $courseId", // Displaying Course ID
                              url: linkUrl,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

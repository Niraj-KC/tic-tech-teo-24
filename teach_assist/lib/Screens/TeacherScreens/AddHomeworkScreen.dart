import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/API/FireStoreAPIs/subjectServices.dart';
import 'package:teach_assist/Components/CustomTextField.dart';
import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/API/FireStoreAPIs/homeworkService.dart';
import 'package:teach_assist/Models/Subject.dart';
import 'package:teach_assist/Models/Teacher.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';
import 'package:intl/intl.dart';

import '../../Providers/CurrentUserProvider.dart';

class AddHomeworkScreen extends StatefulWidget {
  const AddHomeworkScreen({Key? key}) : super(key: key);

  @override
  _AddHomeworkScreenState createState() => _AddHomeworkScreenState();
}

class _AddHomeworkScreenState extends State<AddHomeworkScreen> {
  TextEditingController _linkController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _referenceLinkController = TextEditingController();
  String? _selectedCourseId;
  DateTime? _selectedDueDate;
  List<Map<String, String>> _subjects = []; // List to store subject IDs and names

  @override
  void initState() {
    super.initState();
  }

  Future<List<Map<String, String>>> _fetchSubjects() async {
    var teacher = Provider.of<CurrentUserProvider>(context, listen: false).user as Teacher;
    // Fetch subjects from Firebase based on teacher's subjects IDs
    // Assuming `fetchSubjectsByIds` is a method that retrieves subjects based on IDs
    List<Map<String, String>> subjects = await fetchSubjectsByIds(teacher.subjects ?? []);
    return subjects;
  }

  Future<List<Map<String, String>>> fetchSubjectsByIds(List<String> subjectIds) async {
    List<Map<String, String>> subs = [];
    for(int i=0; i<subjectIds.length; i++){
      Subject? sub = await SubjectService().getSubjectById(subjectIds[i]);
      if(sub!=null) subs.add({"id":sub.id??"", "name":sub.name??''});
    }
    return subs;
  }

  Homework? _addHomework() {
    if (_linkController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _selectedCourseId == null ||
        _referenceLinkController.text.isEmpty ||
        _selectedDueDate == null) {
      print("Please fill out all fields.");
      return null;
    }

    Homework homework = Homework(
      title: _nameController.text,
      courseId: _selectedCourseId,
      courseName: _subjects.firstWhere((subject) => subject['id'] == _selectedCourseId!)['name'] ?? '',
      gDriveQuestionUrl: _linkController.text,
      gDriveReferenceAnswerUrl: _referenceLinkController.text,
      timeStampCreated: DateTime.now().millisecondsSinceEpoch.toString(),
      timeStampDueDate: _selectedDueDate!.millisecondsSinceEpoch.toString(),
    );

    return homework;
  }

  void _clearFields() {
    _linkController.clear();
    _nameController.clear();
    _referenceLinkController.clear();
    setState(() {
      _selectedCourseId = null;
      _selectedDueDate = null;
    });
  }

  Widget _buildDueDatePicker(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _selectedDueDate == null ? 'Select Due Date' : DateFormat.yMd().format(_selectedDueDate!),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              setState(() {
                _selectedDueDate = pickedDate;
              });
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.theme['green'],
        title: const Text(
          "Add Homework",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, String>>>(
          future: _fetchSubjects(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            _subjects = snapshot.data!; // Store fetched subjects

            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Enter homework title",
                    isNumber: false,
                    obsecuretext: false,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: "Enter GDrive Link for questions",
                    isNumber: false,
                    obsecuretext: false,
                    controller: _linkController,
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: "Enter GDrive Link for reference answers",
                    isNumber: false,
                    obsecuretext: false,
                    controller: _referenceLinkController,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select Course',
                      labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.theme['green']),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: InputBorder.none,
                    ),
                    value: _selectedCourseId,
                    items: _subjects.map((Map<String, String> subject) {
                      return DropdownMenuItem<String>(
                        value: subject['id'],
                        child: Text(subject['name']!),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCourseId = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildDueDatePicker(context),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Homework? hw = _addHomework();
                      if (hw != null) {
                        await HomeworkService().postHomeworkForCourse(hw);
                        Navigator.pop(context, hw); // Pass back the homework to the previous screen
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

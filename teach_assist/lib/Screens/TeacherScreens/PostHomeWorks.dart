import 'package:flutter/material.dart';
import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/Screens/TeacherScreens/AddHomeworkScreen.dart';
import 'package:teach_assist/Screens/TeacherScreens/TeacherHomeScreen.dart';
import 'package:teach_assist/Transitions/LeftToRight.dart';
import 'package:teach_assist/Transitions/RightToLeft.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

class PostHomeWorks extends StatefulWidget {
  const PostHomeWorks({super.key});

  @override
  State<PostHomeWorks> createState() => _PostHomeWorksState();
}

class _PostHomeWorksState extends State<PostHomeWorks> {
  List<Homework> _homeworks = [];

  Future<void> _navigateToAddHomeworkScreen() async {
    final homework = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddHomeworkScreen()),
    );
    if (homework != null) {
      setState(() {
        _homeworks.add(homework);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, RightToLeft(TeacherHomeScreen())) ;
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 25,
              )),
          backgroundColor: AppColors.theme['green'],
          title: const Text(
            "Home Works",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.theme['green'],
          onPressed: _navigateToAddHomeworkScreen,
          child: const Icon(Icons.add_box_rounded, color: Colors.white),
        ),
        backgroundColor: AppColors.theme['offWhite'],
        body: SafeArea(
          child: _homeworks.isEmpty
              ? const Center(child: Text("No homeworks posted yet."))
              : ListView.builder(
                  itemCount: _homeworks.length,
                  itemBuilder: (context, index) {
                    final homework = _homeworks[index];
                    return ListTile(
                      title: Text(homework.title!),
                      subtitle: Text(homework.gDriveQuestionUrl!),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/API/FireStoreAPIs/homeworkService.dart';
import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import 'package:teach_assist/Screens/TeacherScreens/AddHomeworkScreen.dart';
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
              backgroundColor: AppColors.theme['green'],
              title: const Text(
                "Home Works",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.theme['green'],
              onPressed: _navigateToAddHomeworkScreen,
              child: const Icon(Icons.add_box_rounded, color: Colors.white),
            ),
            backgroundColor: AppColors.theme['offWhite'],
            body: Consumer<CurrentUserProvider>(
              builder: (context, currentUserProvider, child) {
                return SafeArea(
                  child: StreamBuilder<Map<String, Map<String, List<Homework>>>>(
                    stream: HomeworkService().getHomeworkListForTeacherGroupedByCourse(currentUserProvider.user),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No homework available."));
                      }

                      // Extract grouped homework
                      final groupedHomework = snapshot.data!;

                      return ListView(
                        children: groupedHomework.entries.map((entry) {
                          final courseName = entry.key; // Course name
                          final homeworkByTitle = entry.value; // Map of homework grouped by title

                          return ExpansionTile(
                            title: Text("Course: $courseName"),
                            children: homeworkByTitle.entries.map((titleEntry) {
                              final homeworkTitle = titleEntry.key; // Homework title
                              final homeworkList = titleEntry.value; // List of homeworks with this title

                              return ExpansionTile(
                                title: Text(homeworkTitle.isNotEmpty ? homeworkTitle : "No Title"),
                                children: homeworkList.map((homework) {
                                  return ListTile(
                                    title: Text(homework.title ?? "No Title"),
                                    subtitle: Text(homework.gDriveQuestionUrl ?? "No URL"),
                                  );
                                }).toList(),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      );
                    },
                  ),
                );
              },
            )));
  }
}

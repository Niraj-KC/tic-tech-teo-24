import 'package:flutter/material.dart';
import 'package:teach_assist/Models/Student.dart';

class CurrentUserProvider extends ChangeNotifier{
  dynamic user;
  late bool isStudent;

  void setCurrent(dynamic user, bool isStudent){
    this.user = user;
    this.isStudent = isStudent;
    notifyListeners();
  }

  // void addSubmission(String allocatedSubjectID, Submission submission){
  //   user.allocatedSubjects.where((allo_sub) => allo_sub.id == allocatedSubjectID).submissionList.add(submission);
  //   notifyListeners();
  // }
}
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:teach_assist/Models/Student.dart';

import '../API/FirebaseAPIs.dart';

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
  // Future initUser() async {
  //   String? uid = FirebaseAPIs.auth.currentUser?.uid;
  //   log("#authId: $uid");
  //   if(uid != null){
  //     user = AppUser.fromJson(await UserProfile.getUser(uid));
  //     await NotificationApi.getFirebaseMessagingToken(uid) ;
  //   }
  //   notifyListeners();
  //   log("#initUser complete");
  // }


}
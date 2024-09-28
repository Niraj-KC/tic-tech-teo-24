import 'dart:developer';

import 'package:flutter/material.dart';

import '../API/FirebaseAPIs.dart';

class CurrentUserProvider extends ChangeNotifier{
  dynamic user;
  late bool isStudent;

  void setCurrent(dynamic user, bool isStudent){
    this.user = user;
    this.isStudent = isStudent;
    notifyListeners();
  }

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
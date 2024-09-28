import 'package:flutter/material.dart';

class CurrentUserProvider extends ChangeNotifier{
  dynamic user;
  late bool isStudent;

  void setCurrent(dynamic user, bool isStudent){
    this.user = user;
    this.isStudent = isStudent;
    notifyListeners();
  }


}
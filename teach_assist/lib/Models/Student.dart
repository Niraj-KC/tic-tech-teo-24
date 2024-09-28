import 'package:teach_assist/Models/Quiz.dart';

/// id : "12345"
/// name : "John"
/// rollNo : "22cse209"
/// currentSem : "3"
/// departmentId : "CSE001"
/// allocatedSubjects : [{"courseCode":"DS101","quizList":[{"courseCode":"DS101","id":"QZ002","startDateTime":1633104000000,"endDateTime":1633107600000,"totalMarks":50,"marksOptained":50}]}]

class Student {
  Student({
      this.id, 
      this.name, 
      this.rollNo, 
      this.currentSem, 
      this.departmentId, 
      this.allocatedSubjects,});

  Student.fromJson(dynamic json)   {
    id = json['id'];
    name = json['name'];
    rollNo = json['rollNo'];
    currentSem = json['currentSem'];
    departmentId = json['departmentId'];
    if (json['allocatedSubjects'] != null) {
      allocatedSubjects = [];
      json['allocatedSubjects'].forEach((v) {
        allocatedSubjects?.add(AllocatedSubjects.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? rollNo;
  String? currentSem;
  String? departmentId;
  List<AllocatedSubjects>? allocatedSubjects;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['rollNo'] = rollNo;
    map['currentSem'] = currentSem;
    map['departmentId'] = departmentId;
    if (allocatedSubjects != null) {
      map['allocatedSubjects'] = allocatedSubjects?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// courseCode : "DS101"
/// quizList : [{"courseCode":"DS101","id":"QZ002","startDateTime":1633104000000,"endDateTime":1633107600000,"totalMarks":50,"marksOptained":50}]

  class AllocatedSubjects {
    AllocatedSubjects({
        this.id,
        this.quizList,});

    AllocatedSubjects.fromJson(dynamic json) {
      id = json['id'];
      if (json['quizList'] != null) {
        quizList = [];
        json['quizList'].forEach((v) {
          quizList?.add(Quiz.fromJson(v));
        });
      }
    }
    String? id;
    List<Quiz>? quizList;

    Map<String, dynamic> toJson() {
      final map = <String, dynamic>{};
      map['id'] = id;
      if (quizList != null) {
        map['quizList'] = quizList?.map((v) => v.toJson()).toList();
      }
      return map;
    }

  }


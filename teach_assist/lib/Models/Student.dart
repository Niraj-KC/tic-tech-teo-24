import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/Models/Quiz.dart';

class Student {
  Student({
      this.id, 
      this.name, 
      this.rollNo, 
      this.currentSem, 
      this.departmentId,
      this.notificationToken,
      this.allocatedSubjects,});

  // Create a Student object from JSON data
  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    rollNo = json['rollNo'] as String?;
    currentSem = json['currentSem'] as String?;
    departmentId = json['departmentId'] as String?;
    notificationToken = json['notificationToken'] as String ? ;

    // Convert the allocatedSubjects list if present
    if (json['allocatedSubjects'] != null) {
      allocatedSubjects = (json['allocatedSubjects'] as List)
          .map((v) => AllocatedSubjects.fromJson(v as Map<String, dynamic>))
          .toList();
    }
  }

  String? id;
  String? name;
  String? rollNo;
  String? currentSem;
  String? departmentId;
  List<AllocatedSubjects>? allocatedSubjects;
  String? notificationToken;

  // Convert Student object to JSON
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['rollNo'] = rollNo;
    map['currentSem'] = currentSem;
    map['departmentId'] = departmentId;
    map['notificationToken'] = notificationToken;

    // Convert allocatedSubjects list to JSON if not null
    if (allocatedSubjects != null) {
      map['allocatedSubjects'] = allocatedSubjects?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return "$name [$rollNo]";
  }
}

class AllocatedSubjects {
  AllocatedSubjects({
    this.id,
    this.quizList,
  });

  // Create an AllocatedSubjects object from JSON data
  AllocatedSubjects.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;

    // Convert the quizList if present
    if (json['quizList'] != null) {
      quizList = (json['quizList'] as List)
          .map((v) => Quiz.fromJson(v as Map<String, dynamic>))
          .toList();
    }

  }

  String? id;
  List<Quiz>? quizList;

  // Convert AllocatedSubjects object to JSON
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;

    // Convert quizList to JSON if not null
    if (quizList != null) {
      map['quizList'] = quizList?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

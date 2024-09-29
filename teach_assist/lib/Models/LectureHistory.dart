import 'package:teach_assist/Models/ClassRoom.dart';

class LectureHistory {
  LectureHistory({
    required this.date,
    required this.roomNo,
    this.presentStudents,
    this.absentStudents,
  });

  String date;
  Classroom roomNo;
  int? presentStudents;
  int? absentStudents;

  LectureHistory.fromJson(Map<String, dynamic> json)
      : date = json['date'] as String,
        roomNo = Classroom.fromJson(json['roomNo'] as Map<String, dynamic>),
        presentStudents = json['presentStudents'] as int?,
        absentStudents = json['absentStudents'] as int?;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['roomNo'] = roomNo.toJson();
    map['presentStudents'] = presentStudents;
    map['absentStudents'] = absentStudents;

    return map;
  }
}

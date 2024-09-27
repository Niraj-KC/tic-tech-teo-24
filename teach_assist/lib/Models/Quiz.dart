/// courseCode : "DS101"
/// id : "QZ002"
/// startDateTime : 1633104000000
/// endDateTime : 1633107600000
/// totalMarks : 50
/// marksObtained : 50

class Quiz {
  Quiz({
      this.courseCode, 
      this.id,
      this.studentId,
      this.startDateTime, 
      this.endDateTime, 
      this.totalMarks, 
      this.marksObtained,});

  Quiz.fromJson(dynamic json) {
    courseCode = json['courseCode'];
    id = json['id'];
    studentId = json["studentId"];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    totalMarks = json['totalMarks'];
    marksObtained = json['marksObtained'];
  }
  String? courseCode;
  String? id;
  String? studentId;
  num? startDateTime;
  num? endDateTime;
  num? totalMarks;
  num? marksObtained;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['courseCode'] = courseCode;
    map['id'] = id;
    map['startDateTime'] = startDateTime;
    map['endDateTime'] = endDateTime;
    map['totalMarks'] = totalMarks;
    map['marksObtained'] = marksObtained;
    map['studentId'] = studentId;
    return map;
  }

}
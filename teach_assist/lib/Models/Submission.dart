class Submission {
  Submission({
    this.submissionId,
    this.studentId,
    this.courseId,
    this.courseName,
    this.submissionName,
    this.submissionCloseDate,
    this.pdfDriveLink,
  });

  Submission.fromJson(dynamic json) {
    submissionId = json['submissionId'];
    studentId = json['studentId'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    submissionName = json['submissionName'];
    submissionCloseDate = json['submissionCloseDate'];
    pdfDriveLink = json['pdfDriveLink'];
  }

  String? submissionId;
  String? studentId;
  String? courseId;
  String? courseName;
  String? submissionName;
  String? submissionCloseDate;
  String? pdfDriveLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['submissionId'] = submissionId;
    map['studentId'] = studentId;
    map['courseId'] = courseId;
    map['courseName'] = courseName;
    map['submissionName'] = submissionName;
    map['submissionCloseDate'] = submissionCloseDate;
    map['pdfDriveLink'] = pdfDriveLink;
    return map;
  }
}

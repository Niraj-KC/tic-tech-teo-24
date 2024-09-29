class Homework {
  Homework({
    this.title,
    this.courseId,
    this.courseName,
    this.id,
    this.gDriveQuestionUrl,
    this.gDriveReferenceAnswerUrl,
    this.gDriveSubmissionUrl,
    this.timeStampCreated,
    this.timeStampDueDate,
    this.timeStampSubmissionDate,
    this.isSubmitted = false,
  });

  Homework.fromJson(dynamic json) {
    title = json['title'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    id = json['id'];
    gDriveQuestionUrl = json['gDriveQuestionUrl'];
    gDriveReferenceAnswerUrl = json['gDriveReferenceAnswerUrl'];
    gDriveSubmissionUrl = json['gDriveSubmissionUrl'];
    timeStampCreated = json['timeStampCreated'] ;
    timeStampDueDate = json['timeStampDueDate'] ;
    timeStampSubmissionDate = json["timeStampSubmissionDate"];
    isSubmitted = json["isSubmitted"];
  }

  String? id;
  String? title;
  String? courseId;
  String? courseName;
  String? gDriveQuestionUrl;
  String? gDriveReferenceAnswerUrl;
  String? gDriveSubmissionUrl;
  String? timeStampCreated ;
  String? timeStampDueDate ;
  String? timeStampSubmissionDate ;
  bool isSubmitted = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['courseId'] = courseId;
    map['courseName'] = courseName;
    map['id'] = id;
    map['gDriveQuestionUrl'] = gDriveQuestionUrl;
    map['gDriveReferenceAnswerUrl'] = gDriveReferenceAnswerUrl;
    map['gDriveSubmissionUrl'] = gDriveSubmissionUrl;
    map['timeStampCreated'] = timeStampCreated ;
    map['timeStampDueDate'] = timeStampDueDate ;
    map['timeStampSubmissionDate'] = timeStampSubmissionDate ;
    map["isSubmitted"] = isSubmitted;
    return map;
  }

}

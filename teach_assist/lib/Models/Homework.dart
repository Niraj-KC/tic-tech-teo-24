class Homework {
  String? id;
  String? title;
  String? courseId;
  String? courseName;
  String? studentId;
  String? studentName;
  String? gDriveQuestionUrl;
  String? gDriveReferenceAnswerUrl;
  String? gDriveSubmissionUrl;
  String? timeStampCreated;
  String? timeStampDueDate;
  String? timeStampSubmissionDate;
  bool isSubmitted;
  double? mark; // New field for assessment mark

  Homework({
    this.id,
    this.title,
    this.courseId,
    this.courseName,
    this.studentId,
    this.studentName,
    this.gDriveQuestionUrl,
    this.gDriveReferenceAnswerUrl,
    this.gDriveSubmissionUrl,
    this.timeStampCreated,
    this.timeStampDueDate,
    this.timeStampSubmissionDate,
    this.isSubmitted = false,
    this.mark, // Initialize the mark field
  });

  // Convert an AssessmentModel from a Firebase document snapshot
  factory Homework.fromJson(Map<String, dynamic> data, String documentId) {
    return Homework(
      id: documentId,
      title: data['title'],
      courseId: data['courseId'],
      courseName: data['courseName'],
      studentId: data['studentId'],
      studentName: data['studentName'],
      gDriveQuestionUrl: data['gDriveQuestionUrl'],
      gDriveReferenceAnswerUrl: data['gDriveReferenceAnswerUrl'],
      gDriveSubmissionUrl: data['gDriveSubmissionUrl'],
      timeStampCreated: data['timeStampCreated'],
      timeStampDueDate: data['timeStampDueDate'],
      timeStampSubmissionDate: data['timeStampSubmissionDate'],
      isSubmitted: data['isSubmitted'] ?? false,
      mark: data['mark'] != null ? (data['mark'] as num).toDouble() : null, // Mark field
    );
  }

  // Convert an AssessmentModel to a map for Firebase
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'courseId': courseId,
      'courseName': courseName,
      'studentId': studentId,
      'studentName': studentName,
      'gDriveQuestionUrl': gDriveQuestionUrl,
      'gDriveReferenceAnswerUrl': gDriveReferenceAnswerUrl,
      'gDriveSubmissionUrl': gDriveSubmissionUrl,
      'timeStampCreated': timeStampCreated,
      'timeStampDueDate': timeStampDueDate,
      'timeStampSubmissionDate': timeStampSubmissionDate,
      'isSubmitted': isSubmitted,
      'mark': mark, // Mark field for Firebase
    };
  }
}

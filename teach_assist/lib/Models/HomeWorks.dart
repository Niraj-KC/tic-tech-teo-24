class Homework {
  Homework({
    this.title,
    this.courseId,
    this.gDriveUrl,
    this.timeStamp,
  });

  Homework.fromJson(dynamic json) {
    title = json['title'];
    courseId = json['courseId'];
    gDriveUrl = json['gDriveUrl'];
    timeStamp = json['timeStamp'] ;
  }

  String? title;
  String? courseId;
  String? gDriveUrl;
  String?timeStamp ;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['courseId'] = courseId;
    map['gDriveUrl'] = gDriveUrl;
    map['timeStamp'] =timeStamp ;
    return map;
  }
}

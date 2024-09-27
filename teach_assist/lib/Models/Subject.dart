/// id : "SUBJ101"
/// name : "Data Structures"
/// courseCode : "DS101"
/// departmentId : "CSE001"
/// coursePolicy : "https://drive.google.com/drive/u/0/xyz67890"
/// materials : ["https://linktomaterial1.com","https://linktomaterial2.com"]

class Subject {
  Subject({
      this.id, 
      this.name, 
      this.courseCode, 
      this.departmentId, 
      this.coursePolicy, 
      this.materials,});

  Subject.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    courseCode = json['courseCode'];
    departmentId = json['departmentId'];
    coursePolicy = json['coursePolicy'];
    materials = json['materials'] != null ? json['materials'].cast<String>() : [];
  }
  String? id;
  String? name;
  String? courseCode;
  String? departmentId;
  String? coursePolicy;
  List<String>? materials;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['courseCode'] = courseCode;
    map['departmentId'] = departmentId;
    map['coursePolicy'] = coursePolicy;
    map['materials'] = materials;
    return map;
  }

}
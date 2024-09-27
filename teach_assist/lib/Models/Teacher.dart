/// id : "TCH001"
/// name : "John T"
/// departmentId : "CSE001"
/// subjects : ["Sub-1","Sub-2"]

class Teacher {
  Teacher({
      this.id, 
      this.name, 
      this.departmentId, 
      this.subjects,});

  Teacher.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    departmentId = json['departmentId'];
    subjects = json['subjects'] != null ? json['subjects'].cast<String>() : [];
  }
  String? id;
  String? name;
  String? departmentId;
  List<String>? subjects;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['departmentId'] = departmentId;
    map['subjects'] = subjects;
    return map;
  }

}
class Classroom {
  Classroom({
    this.roomNumber,
    this.longitude,
    this.latitude,
  });

  Classroom.fromJson(dynamic json) {
    roomNumber = json['roomNumber'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  String? roomNumber;
  double? longitude;
  double? latitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roomNumber'] = roomNumber;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    return map;
  }
}

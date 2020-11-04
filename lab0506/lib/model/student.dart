class Student {
  Student({this.sid, this.grade});

  int id;
  String sid;
  String grade;

  Student.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.sid = map['sid'];
    this.grade = map['grade'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'sid': this.sid,
      'grade': this.grade,
    };
  }

  String toString() {
    return 'Todo{id: $id, sid: $sid, item: $grade}';
  }
}

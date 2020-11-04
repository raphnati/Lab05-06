import 'package:flutter/material.dart';

import 'model/student.dart';

class GradeForm extends StatefulWidget {
  final String title;

  GradeForm({Key key, this.title}) : super(key: key);

  @override
  _GradeFormState createState() => _GradeFormState();
}

class _GradeFormState extends State<GradeForm> {
  String _sid;
  String _grade;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 50, child: Text("SID: ")),
                Expanded(
                  child: TextField(onChanged: (value) {
                    _sid = value;
                  }),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 50, child: Text("Grade: ")),
                Expanded(
                  child: TextField(onChanged: (value) {
                    _grade = value;
                  }),
                )
              ],
            ),
          ],
        ),
        alignment: Alignment.topCenter,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //return grade and sid
          print("Save");
          if (_sid != null && _grade != null) {
            Navigator.of(context).pop(Student(sid: _sid, grade: _grade));
          } else {
            Navigator.of(context).pop();
          }
        },
        tooltip: 'Save Grade',
        child: Icon(Icons.save),
      ),
    );
  }
}

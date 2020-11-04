import 'package:flutter/material.dart';
import 'gradeform.dart';
import 'dart:async';

import 'model/student.dart';
import 'model/student_model.dart';

void main() {
  runApp(MyApp());
}

class Grade {
  String sid;
  String grade;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Lab 05 and 06'),
      routes: <String, WidgetBuilder>{
        '/addGrade': (BuildContext context) => GradeForm(title: 'Add Grade'),
        '/editGrade': (BuildContext context) => GradeForm(title: 'Edit Grade')
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _model = StudentModel();
  bool loading; //loading variable
  List<Student> listStudents;

  //load grades
  void initState() {
    super.initState();
    loading = true;
    _readGrades();
  }

  //current student selected
  int _selectedIndex = -1;
  int _selectedID = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        //Edit button
        IconButton(
            icon: Icon(Icons.edit_rounded, color: Colors.white),
            onPressed: _editGrade),
        //Delete button
        IconButton(
            icon: Icon(Icons.delete_rounded, color: Colors.white),
            onPressed: _deleteGrade),
      ]),
      //if loading show loading bar, otherwise show listview page
      body: !loading
          ? new ListView.builder(
              //build list out of grades list
              itemCount: listStudents.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedIndex == index) {
                          _selectedIndex = -1;
                          _selectedID = -1;
                        } else {
                          _selectedIndex = index;
                          _selectedID = listStudents[index].id;
                        }
                        print("$_selectedID: $_selectedIndex");
                      });
                    },
                    //build tiles
                    child: ListTile(
                      selected: index == _selectedIndex,
                      title: Text(listStudents[index].sid,
                          style: TextStyle(color: Colors.black)),
                      subtitle: Text(listStudents[index].grade,
                          style: TextStyle(color: Colors.black)),
                      selectedTileColor: Colors.blue,
                    ));
              })
          //loading bar
          : CircularProgressIndicator(),
      //add grade button
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGrade,
        tooltip: 'Add Grade',
        child: Icon(Icons.add),
      ),
    );
  }

  //show page and save edited grade
  Future<void> _showAddGrade() async {
    var event = await Navigator.pushNamed(context, '/addGrade');
    if (event != null) {
      await _model.insertStudent(event);
    }
    setState(() {
      loading = true;
      _readGrades();
    });
  }

  //edit selected grade
  Future<void> _editGrade() async {
    var event = await Navigator.pushNamed(context, '/editGrade');
    if (event != null) {
      Student student = event;
      student.id = _selectedID;

      _model.updateStudent(student);
    }
    setState(() {
      loading = true;
      _readGrades();
    });
  }

  //read grades into list
  Future<void> _readGrades() async {
    List<Student> students = await _model.getAllStudents();
    setState(() {
      listStudents = students;
      loading = false;
    });
  }

  //delete grade by id
  void _deleteGrade() {
    if (_selectedID != -1) {
      _model.deleteStudentById(_selectedID);
      print("deleted $_selectedID");
      setState(() {
        loading = true;
        _readGrades();
      });
    }
  }
}

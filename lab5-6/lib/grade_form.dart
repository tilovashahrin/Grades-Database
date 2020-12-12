import 'package:flutter/material.dart';
import 'grade.dart';

class GradeForm extends StatefulWidget{
  final String title;
  final Grade grade;
  GradeForm({Key key, this.title, this.grade}) : super(key: key);
  @override
  _GradeFormState createState() => _GradeFormState();
}

class _GradeFormState extends State<GradeForm>{
  int _id;
  String _sid;
  String _grade;

  @override
  Widget build(BuildContext context){
    if(widget.grade != null){
      _id = widget.grade.id;
      _sid = widget.grade.sid;
      _grade = widget.grade.grade;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Text('SID:'),
              title: TextField(
                controller: TextEditingController(text: _sid),
                onChanged: (value){ _sid = value;}
              ),
            ),
            ListTile(
              leading: Text('Grade'),
              title: TextField(
                  controller: TextEditingController(text: _grade),
                  onChanged: (value){ _grade = value;}
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(Grade(id: _id, sid: _sid, grade: _grade));
          _id++;
        },
        tooltip: 'Save Grade',
        child: Icon(Icons.save),
      ),
    );
  }
}
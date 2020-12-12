import 'package:flutter/material.dart';
import 'grade_form.dart';
import 'grade.dart';
import 'grades_model.dart';

class ListGrades extends StatefulWidget{
  ListGrades({Key key, this.title}): super(key : key);

  final String title;
  @override
  _ListGradesState createState( ) => _ListGradesState();
}

class _ListGradesState extends State<ListGrades>{
  List<int> _ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  List<String> _sids = [
    '100000001',
    '100000002',
    '100000003',
    '100000004',
    '100000005',
    '100000006',
    '100000007',
    '100000008',
    '100000009',
    '100000010',
    '100000011'];
  List<String> _grades = [
    'B-',
    'A',
    'C',
    'C+',
    'B',
    'A-',
    'D',
    'C+',
    'C-',
    'B+',
    'A'];
  int _selectedIndex;
  GradeModel _gradesModel = GradeModel();
  List<Grade> _gradeItems;

  @override
  void initState(){
    super.initState();
    reload();
  }

  void reload(){
    _gradesModel.init().then((_){
      _gradesModel.getAllGrades().then((grades){
        setState((){
          _gradeItems = grades;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _editGrade(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              _deleteGrade(_ids[_selectedIndex]);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _gradeItems != null ? _gradeItems.length : 0,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: index == _selectedIndex ? Colors.blue : Colors.white,
                ),
                child: ListTile(
                  title: Text(_gradeItems[index].sid ?? 'default'),
                  subtitle: Text(_gradeItems[index].grade ?? 'default'),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addGrade(context);
        },
        tooltip: 'Add New Grade',
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> _editGrade(BuildContext context) async {
    Grade grade = Grade(
      id: _gradeItems[_selectedIndex].id,
      sid: _gradeItems[_selectedIndex].sid,
      grade: _gradeItems[_selectedIndex].grade,
    );
    grade = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => GradeForm(title: 'Edit Grade', grade: grade))
    );
    await _gradesModel.updateGrade(grade);
    reload();
  }

  Future<void> _addGrade(BuildContext context) async{
    var grade = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => GradeForm(title: 'Add Grade'))
    );
    await _gradesModel.insertGrade(grade); //problem
    reload();
  }

  Future<void> _deleteGrade(int id) async {
    await _gradesModel.deleteGradeById(id);
    reload();
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _todoList = [];

  final _toDoContoller = TextEditingController();

  void _addTodo(){

    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title']= _toDoContoller.text;
      newToDo['ok']=false;
      _toDoContoller.text='';
      _todoList.add(newToDo);
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: <Widget>[
              Expanded(
                child: TextField(
                controller: _toDoContoller,
                decoration: InputDecoration(
                  labelText: 'Nova tarefa',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent
                  ),
                ),
              ),
              ),
              RaisedButton(
                  color: Colors.blueAccent,
                  child: Text('Add'),
                  textColor: Colors.white,
                  onPressed: _addTodo,
              ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: _todoList.length,
              itemBuilder: (context, index){
                return CheckboxListTile(
                  title: Text(_todoList[index]['title']),
                  value: _todoList[index]['ok'],
                  secondary: CircleAvatar(
                    child: Icon(_todoList[index]['ok'] ? 
                  Icons.check : Icons.error,)
                  ,),
                  onChanged: (b){},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  Future<File> _saveData() async {

    String data = json.encode(_todoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async{
    try{
      final file = await _getFile();
      return file.readAsString();
    }catch (e){
      null;
    }
  }

}


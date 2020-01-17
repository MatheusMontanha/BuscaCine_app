
import 'package:flutter/material.dart';

import 'Models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  
  var items = new List<Item>();

  HomePage(){
    items = [];
    items.add(Item(title: "Maça", done: false));
    items.add(Item(title: "Abacaxi", done: true));
    items.add(Item(title: "Pessego", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  void add(){
    if(newTaskCtrl.text.isEmpty){
      return;
    }else{
    setState(() {
      widget.items.add(Item(title: newTaskCtrl.text, done: false),);
      newTaskCtrl.text = "";
    });
    }
  } 

  void remove(int index){
    setState(() {
      widget.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    //newTaskCtrl.clear();
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white, fontSize: 18,),
          decoration: InputDecoration(
            labelText: "Nova Tarefa",
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
        actions: <Widget>[
          Icon(Icons.plus_one),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxt, int index){
          final item = widget.items[index];
          return Dismissible(
            child: CheckboxListTile(
            title: Text(item.title),
            value: item.done,
            onChanged: (value){
              setState(() {
                item.done = value;
              });
            },
          ),
          key: Key(item.title),
          background: Container(
            color: Colors.red.withOpacity(0.2),
          ),
          onDismissed: (direction){
            remove(index);
          },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
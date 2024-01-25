// ignore_for_file: unnecessary_new, library_private_types_in_public_api, non_constant_identifier_names, unused_element, no_logic_in_create_state, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/models/item.dart';

void main() => runApp(const App());


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(133, 50, 1, 246)),
        useMaterial3: true,
      ),
      home : HomePage(),
    );
  }
}

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  var items = new List<Item>.empty();

  HomePage({super.key}) {
    items = [];
    // items.add(Item(title: "Banana", done: false));
    // items.add(Item(title: "Açúcar", done: true));
    // items.add(Item(title: "Feijão", done: false));
  }
    
  @override   
  _HomePageState createState() => _HomePageState();
}
  
class _HomePageState extends State<HomePage> {
 var newTaskCtrl = TextEditingController();  

  void add(){
    if(newTaskCtrl.text.isEmpty) return;

    setState(() {
      widget.items.add(
      Item(
        title: newTaskCtrl.text, 
        done: false,
        ),
      );
      newTaskCtrl.text = "";
      save();
    });
  }  
  void remove(int index){
    setState(() {
      widget.items.removeAt(index);
    });
  }
  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState((){
        widget.items = result;    
    });
    }
  }
  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

_HomePageState(){
  load();
}

  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: Color.fromARGB(255, 3, 3, 130), 
           fontSize : 22,
           ), 
          decoration:const InputDecoration(
            labelText: "Nova Tarefa",
            labelStyle: TextStyle(color: Color.fromARGB(255, 3, 78, 239)
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, int index) {
          final item = widget.items[index];
          return Dismissible(
            child: CheckboxListTile(
            title: Text(item.title),
            value: item.done,
            onChanged: (value) {
              setState(() {
                item.done = value!;
              });
            },
            ),
            key: Key(item.title),
            background: Container(
              color: Colors.red.withOpacity(0.2),
            ),
            onDismissed: (direction) {
              print(direction);
              //remove(index);
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 6, 2, 254),
      
      ),
    );
  }
}
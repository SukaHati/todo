import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/widgets/detail.dart';
import 'package:todo/widgets/detail2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Map<String, dynamic>>
  List<dynamic> _todoItems = [
    {
      "name":"Learn ListView",
      "place":"Zoom Link",
      "desc":"Learn Listview, Listtile and Card",
      "completed": true
    },
    {
      "name":"Learn Advance Navigation",
      "place":"Zoom Link",
      "desc":"Pass data forward and pass data backward",
      "completed": true
    },
    {
      "name":"Learn Shared Preference",
      "place":"Zoom Link",
      "desc":"jsonEncode/Decode, set and getItem",
      "completed": false
    },
    {
      "name":"Kemas rumah",
      "place":"home",
      "desc":"sapu, mop, vacuum and laundry",
      "completed": false
    }
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //When the page is loading, we call the function loadData()
    loadData();
  }
  //When the page is loading, do the following
  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var todoString = prefs.getString("todos");
    if(todoString != null) {
      setState(() {
        //Since we retrieved data in String, we use jsonDecode() to transform String into List or Map
        _todoItems = jsonDecode(todoString);
      });
    }
  }

  void saveData() async {
    //get the file manager
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Shared preferences only save String int double or boolean or List of String
    //We use jsonEncode to transform List or Map into String and use that setString to saving
    //Name file is "todos"
    prefs.setString("todos", jsonEncode(_todoItems));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(onPressed: () async {
            //step 1: Wait for the page to finished and retrieved the passed item and stored it in new item
            //When there is await, need to add async to do nearest {} function
            var newItem = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
            //Step 3: Process the retrieved item
            if(newItem != null) {
              _todoItems.add(newItem);
              saveData();
              setState(() {
                _todoItems;
              });
            }
          }, icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          //Item count maksudnya how many rows are there
          //Number of row depends on the number of items in the _todoItems List
          itemCount: _todoItems.length,
          //What to show on every row
          //Contohnya: For each row, show a container of height 50px, colors amber, center with text, the "name" of _todoItems items in each row
          //The row is represented by key word index
          itemBuilder: (BuildContext context, int index) {
            //return Container(
            //  height: 50,
            //  color: Colors.amber,
            //  child: Center(child: Text(_todoItems[index]["name"]!)),
            //);
            return Card(
              child: ListTile(
                leading: _todoItems[index]["completed"] ? Icon(Icons.check) : SizedBox(),
                title: Text(_todoItems[index]["name"]!),
                subtitle: Text(_todoItems[index]["place"]!),
                trailing: Icon(Icons.chevron_right),
                onTap: () async {
                  //Pass forward data
                  var action;
                  String completionText = "";
                  if(_todoItems[index]["completed"]) {
                    completionText = "Unmarked as completed";
                  }
                  else {
                    completionText = "Marked as completed";
                  }
                  //if(_todoItems[index]["completed"] == false) {
                    action = await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(todoItem: _todoItems[index], index: index, completionText: completionText)));
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));
                  //}
                  //else {
                  //  action = await Navigator.push(context, MaterialPageRoute(builder: (context) => AltDetailPage(todoItem: _todoItems[index], index: index)));
                  //}
                  if(action != null) {
                    if(action["action"] == "delete") {
                      _todoItems.removeAt(action["index"]);
                      saveData();
                      setState(() {
                        _todoItems;
                      });
                    }
                    //else if(action["action"] == "unmarked") {
                    //  _todoItems[index]["completed"] = false;
                    //  saveData();
                    //  setState(() {
                    //    _todoItems;
                    //  });
                    //}
                    else {
                      _todoItems[index]["completed"] = !_todoItems[index]["completed"];
                      saveData();
                      setState(() {
                        _todoItems;
                      });
                    }
                  }
                },
              ),
            );
          }
      ),
    );
  }
}
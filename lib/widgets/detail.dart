import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  //1. Variable to store the item
  Map<String, dynamic> todoItem ;
  int index;
  String completionText;
  //2. Constructor of the page ({required this.})
  DetailPage({required this.todoItem, required this.index, required this.completionText});
  //3. Di penghantar. Hantar dari Constructor(Home.dart)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(todoItem["name"]!),
            SizedBox(height: 8,),
            Text(todoItem["place"]!),
            SizedBox(height: 8,),
            Text(todoItem["desc"]!),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  var item = {
                    "index": index,
                    "action": "marked"
                  };
                  if(todoItem["completed"]) {
                    item["action"] = "unmarked";
                  }
                  Navigator.pop(context, item);
                }, child: Text(completionText)),
                ElevatedButton(onPressed: (){
                  print("delete for $index");
                  var item = {
                    "index": index,
                    "action": "delete"
                  };
                  Navigator.pop(context, item);
                }, child: Text("Delete the item"))
              ],)
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  var nameEditingController = TextEditingController();
  var descriptionEditingController = TextEditingController();
  var placeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Please fill in your information"),
            TextField(decoration: InputDecoration(hintText: "Enter item name"), controller: nameEditingController,),
            TextField(decoration: InputDecoration(hintText: "Enter item description"), controller: descriptionEditingController,),
            TextField(decoration: InputDecoration(hintText: "Enter item place"), controller: placeEditingController,),
            TextButton(onPressed: (){
              print(nameEditingController.text);
              print(descriptionEditingController.text);
              print(placeEditingController.text);
              Navigator.pop(context);
            }, child: Text("Add new item"))
          ],
        ),
      ),
    );
  }
}

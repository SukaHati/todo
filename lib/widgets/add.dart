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
              if(nameEditingController.text != "" && descriptionEditingController.text != "" && placeEditingController.text != "") {
                print(nameEditingController.text);
                print(descriptionEditingController.text);
                print(placeEditingController.text);

                var newItem = {
                  "name": nameEditingController.text,
                  "desc": descriptionEditingController.text,
                  "place": placeEditingController.text,
                  "completed": false
                };

                //Step 2. passed the item as the 2nd argument of Navigator.pop()
                //Return to Home page
                Navigator.pop(context, newItem);
              }
              else {
                print("Later put toast/alert dialog to remind user to put all their info in there");
              }
            }, child: Text("Add new item"))
          ],
        ),
      ),
    );
  }
}

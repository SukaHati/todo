import 'package:flutter/material.dart';
import 'package:todo/widgets/detail.dart';
import 'add.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
          }, icon: Icon(Icons.add))
        ],
      ),
      body: Text("Home Page"),
    );
  }
}

import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.only(top: 350),
                child: Text("Loading............",style: TextStyle(color: Colors.black26),),
              ))
            ],
          ),
        ),
      ),
    );

  }
}

import 'package:flutter/material.dart';

class TrendAnalysis extends StatefulWidget {
  const TrendAnalysis({super.key});

  @override
  State<TrendAnalysis> createState() => _TrendAnalysisState();
}

class _TrendAnalysisState extends State<TrendAnalysis> {
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

import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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

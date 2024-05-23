import 'package:flutter/material.dart';
import 'bottomsheet/bankdetails.dart';
import 'bottomsheet/showmodel_bottomsheet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'navigationbar/news.dart';
import 'navigationbar/ratealert.dart';
import 'navigationbar/spotrate.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    SpotRate(),
    RateAlert(),
    News(),
    BankDetails(),
  ];

  void _onNavigationBarTap(int index) {
    if (index == 3) {
      // Show modal bottom sheet when the last icon is tapped
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Bottomsheet();
        },
      );
    } else {
      // Otherwise, change the current page
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9CF57),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:Color(0xFFEDEDED),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        buttonBackgroundColor: Colors.black,
        height: 70,
        index: _currentIndex,
        color: Colors.white54,
        onTap: _onNavigationBarTap,
        items: <Widget>[
          Icon(Icons.bar_chart_outlined, size: 17, color:Color(0xFFD3AF37)),
          Icon(Icons.notifications_on, size: 17, color: Color(0xFFD3AF37)),
          Icon(Icons.newspaper, size: 17, color:Color(0xFFD3AF37)),
          Icon(Icons.more, size: 17, color:Color(0xFFD3AF37)),
        ],
      ),
    );
  }
}




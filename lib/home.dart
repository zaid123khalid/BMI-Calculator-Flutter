import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'bmiCalc.dart';
import 'bmiChart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  PageController pageController = PageController();
  bool clrFlds = false;

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        titleSpacing: 7,
        actions: selectedIndex == 0
            ? [
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      if (clrFlds == false) {
                        clrFlds = true;
                      }
                    });
                  },
                ),
              ]
            : null,
      ),
      body: PageView(
        controller: pageController,
        children: [
          PageStorage(
            bucket: _bucket,
            child: BMICalculator(
              clrFlds: clrFlds,
            ),
          ),
          const BMIChart()
        ],
        onPageChanged: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 500),
        buttonBackgroundColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        items: const [
          CurvedNavigationBarItem(
              child: Icon(Icons.calculate), label: ("BMI Calculator")),
          CurvedNavigationBarItem(
              child: Icon(Icons.table_chart), label: ("BMI Chart"))
        ],
        index: selectedIndex,
        onTap: changeIndex,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

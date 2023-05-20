import 'package:flutter/material.dart';

void main() {
  runApp(const ActivityPage());
}

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<String> tabs = [
    "Trip History",
    "Carpool History",
    "Points Earned",
  ];
  int current = 0;

  // double changePositionedOfLine() {
  //   switch (current) {
  //     case 0:
  //       return 0;
  //     case 1:
  //       return 78;
  //     case 2:
  //       return 192;
  //     case 3:
  //       return 263;
  //     default:
  //       return 0;
  //   }
  // }
  //
  // double changeContainerWidth() {
  //   switch (current) {
  //     case 0:
  //       return 50;
  //     case 1:
  //       return 80;
  //     case 2:
  //       return 50;
  //     case 3:
  //       return 50;
  //     default:
  //       return 0;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        toolbarHeight: 65,
        title: Center(
          child: Text(
            'Activity',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              width: size.width,
              height: size.height * 0.05,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: size.width,
                      height: size.height * 0.04,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: tabs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    current = index;
                                  });
                                },
                                child: Container(
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: current == index
                                          ? Colors.green[800]
                                          : Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      tabs[index],
                                      style: TextStyle(
                                        color: current == index
                                            ? Colors.white
                                            : Colors.green[900],
                                        fontSize: current == index ? 16 : 14,
                                        fontWeight: current == index
                                            ? FontWeight.bold
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  // AnimatedPositioned(
                  //   curve: Curves.fastLinearToSlowEaseIn,
                  //   bottom: 0,
                  //   left: changePositionedOfLine(),
                  //   duration: const Duration(milliseconds: 500),
                  //   child: AnimatedContainer(
                  //     margin: const EdgeInsets.only(left: 10),
                  //     width: changeContainerWidth(),
                  //     height: size.height * 0.008,
                  //     decoration: BoxDecoration(
                  //       color: Colors.deepPurpleAccent,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     duration: const Duration(milliseconds: 1000),
                  //     curve: Curves.fastLinearToSlowEaseIn,
                  //   ),
                  // )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.3),
              child: Text(
                "${tabs[current]} Tab Content",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

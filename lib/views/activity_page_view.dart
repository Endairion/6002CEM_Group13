import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/viewmodels/activity_page_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

void main() {
  runApp(ActivityPage());
}

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late final ActivityPageViewModel _model;
  late final BuildContext _context;

  List<String> tabs = [
    "Trip History",
    "Carpool History",
    "Points Earned",
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BaseView<ActivityPageViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady();
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Scaffold(
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
          height: double.infinity,
          color: Colors.grey[200],
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: size.width,
                  height: 45,
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
                                            fontSize:
                                                current == index ? 16 : 14,
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: _model.getHistoryList(current),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

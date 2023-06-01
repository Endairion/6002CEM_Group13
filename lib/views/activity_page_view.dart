import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/PointsEarn.dart';
import 'package:mobile_app_development_cw2/PointsEarnCard.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/TripCard.dart';
import 'package:mobile_app_development_cw2/TripHistoryCard.dart';
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

  // List<Trip> _tripsHistory = [
  //   Trip(
  //     id: "abc012",
  //     userId: "3RnDlwJmltTHpRNVAs895wp8Gyq1",
  //     startLocation: "Inti International College Penang",
  //     destination: "Queensbay",
  //     date: "25-04-2023",
  //     time: "10:00am",
  //     status: "Ongoing",
  //     stops: "",
  //     seats: 3,
  //     enablePickupNotification: true,
  //   ),
  //   Trip(
  //     id: "qwe012",
  //     userId: "3RnDlwJmltTHpRNVAs895wp8Gyq1",
  //     startLocation: "Inti International College Penang",
  //     destination: "Queensbay",
  //     date: "25-04-2023",
  //     time: "10:00am",
  //     status: "Ongoing",
  //     stops: "",
  //     seats: 3,
  //     enablePickupNotification: true,
  //   ),
  //   Trip(
  //     id: "zxc012",
  //     userId: "3RnDlwJmltTHpRNVAs895wp8Gyq1",
  //     startLocation: "Inti International College Penang",
  //     destination: "Queensbay",
  //     date: "25-04-2023",
  //     time: "10:00am",
  //     status: "Completed",
  //     stops: "",
  //     seats: 3,
  //     enablePickupNotification: true,
  //   ),
  //   Trip(
  //     id: "rty012",
  //     userId: "3RnDlwJmltTHpRNVAs895wp8Gyq1",
  //     startLocation: "Inti International College Penang",
  //     destination: "Queensbay",
  //     date: "25-04-2023",
  //     time: "10:00am",
  //     status: "Completed",
  //     stops: "",
  //     seats: 3,
  //     enablePickupNotification: true,
  //   ),
  //   Trip(
  //     id: "dfg012",
  //     userId: "3RnDlwJmltTHpRNVAs895wp8Gyq1",
  //     startLocation: "Inti International College Penang",
  //     destination: "Queensbay",
  //     date: "25-04-2023",
  //     time: "10:00am",
  //     status: "Expired",
  //     stops: "",
  //     seats: 3,
  //     enablePickupNotification: true,
  //   ),
  //   Trip(
  //     id: "vbn012",
  //     userId: "3RnDlwJmltTHpRNVAs895wp8Gyq1",
  //     startLocation: "Inti International College Penang",
  //     destination: "Queensbay",
  //     date: "25-04-2023",
  //     time: "10:00am",
  //     status: "Expired",
  //     stops: "",
  //     seats: 3,
  //     enablePickupNotification: true,
  //   ),
  // ];
  //
  // List<PointsEarn> _pointsEarnedList = [
  //   PointsEarn(
  //       id: "123",
  //       startLocation: "Inti International College Penang Inti International College Penang",
  //       destination: "Inti International College Penang Inti International College Penang",
  //       date: "15-03-2023",
  //       time: "3:00pm",
  //       role: "Passenger",
  //       points: 50),
  //   PointsEarn(
  //       id: "123",
  //       startLocation: "Inti International College Penang",
  //       destination: "Inti International College Penang",
  //       date: "15-03-2023",
  //       time: "3:00pm",
  //       role: "Passenger",
  //       points: 50),
  //   PointsEarn(
  //       id: "123",
  //       startLocation: "Inti International College Penang",
  //       destination: "Inti International College Penang",
  //       date: "15-03-2023",
  //       time: "3:00pm",
  //       role: "Driver",
  //       points: 150),
  //   PointsEarn(
  //       id: "123",
  //       startLocation: "Inti International College Penang",
  //       destination: "Inti International College Penang",
  //       date: "15-03-2023",
  //       time: "3:00pm",
  //       role: "Driver",
  //       points: 150),
  // ];

  // double _singleListViewHeight = 150;
  // double _listViewHeight = 400;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   if (_tripsHistory.length * _singleListViewHeight > 400) {
  //     _listViewHeight = _tripsHistory.length * _singleListViewHeight;
  //   }
  //   if (_pointsEarnedList.length * _singleListViewHeight > _listViewHeight) {
  //     _listViewHeight = _pointsEarnedList.length * _singleListViewHeight;
  //   }
  // }

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
                  // child: Text('Hey'),
                  // child: getHistoryList(current, _listViewHeight, _tripsHistory, _pointsEarnedList),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget getHistoryList(int index, double height, List<Trip> tripList, List<PointsEarn> pointsList) {
//   if (index == 0) {
//     return SizedBox(
//       height: height,
//       child: tripList.length > 0
//           ? ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: tripList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return TripHistoryCard(context, tripList, index);
//               },
//             )
//           : const Center(
//               child: Text(
//                 'There are no trips history available.',
//                 style: TextStyle(
//                   fontStyle: FontStyle.italic,
//                   color: Colors.red,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//     );
//   } else if (index == 1) {
//     return SizedBox(
//       height: height,
//       child: tripList.length > 0
//           ? ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: tripList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return TripHistoryCard(context, tripList, index);
//               },
//             )
//           : const Center(
//               child: Text(
//                 'There are no carpool history available.',
//                 style: TextStyle(
//                   fontStyle: FontStyle.italic,
//                   color: Colors.red,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//     );
//   } else {
//     return SizedBox(
//       height: height,
//       child: pointsList.length > 0
//           ? ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: pointsList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return PointsEarnCard(pointsList, index);
//         },
//       )
//           : const Center(
//         child: Text(
//           'There are no points earned history available.',
//           style: TextStyle(
//             fontStyle: FontStyle.italic,
//             color: Colors.red,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/views/create_custom_trip_view.dart';
import 'package:mobile_app_development_cw2/viewmodels/search_available_trips_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

class SearchAvailableTrips extends StatefulWidget {
  const SearchAvailableTrips({Key? key}) : super(key: key);

  @override
  State<SearchAvailableTrips> createState() => _SearchAvailableTripsState();
}

class _SearchAvailableTripsState extends State<SearchAvailableTrips> {
  late final SearchAvailableTripsViewModel _model;
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchAvailableTripsViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady();
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.lightGreen,
          title: Text(
            'Back to Home',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/vector_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 240,
                                    child: TextField(
                                      onTap: () {},
                                      controller:
                                          _model.startLocationController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.lightGreen,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 16),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          border: OutlineInputBorder(),
                                          hintText:
                                              'Enter your starting location',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.my_location,
                                              color: Colors.grey[400],
                                            ),
                                            onPressed: () {
                                              print('Pressed my location');
                                            },
                                          )),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      minLines: 1,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 240,
                                    child: TextField(
                                      controller: _model.destinationController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.lightGreen,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 16),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Enter your destination location',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      minLines: 1,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _model.getSearchResultTripsList(
                                      _model.startLocationController,
                                      _model.destinationController);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.limeAccent[700],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      size: 50,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Search',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateCustomTripView()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.green.shade900,
                                Colors.lightGreen.shade700
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Request for trips',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Create a custom request',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.lightGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.navigate_next,
                                size: 45,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              'Available Trips',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.black54,
                                elevation: 0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.filter_alt,
                                    size: 30,
                                  ),
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      _model.getAvailableTripListSizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

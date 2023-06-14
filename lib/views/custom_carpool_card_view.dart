import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/custom_request_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/custom_carpool_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/navigation_menu_view.dart';

class CustomCarpoolCardView extends StatefulWidget {
  CustomRequest customRequest;
  CustomCarpoolCardView({Key? key, required CustomRequest this.customRequest})
      : super(key: key);

  @override
  State<CustomCarpoolCardView> createState() => _CustomCarpoolCardViewState();
}

class _CustomCarpoolCardViewState extends State<CustomCarpoolCardView> {
  late final CustomCarpoolViewmodel _model;

  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BaseView<CustomCarpoolViewmodel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady();
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(0), // Border radius
                          child: ClipOval(
                              child: Image.asset('assets/anonym_avatar.png')),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          "New Custom Carpool Request",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(30.0),
                            color: Colors.limeAccent[700],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'S',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          widget.customRequest.startLocation,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(30.0),
                            color: Colors.green[900],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'D',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          widget.customRequest.destination,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Remarks: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 350,
                    child: Text(widget.customRequest.remarks,
                        overflow: TextOverflow.clip),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 125,
                      child: ElevatedButton(
                          onPressed: () {
                            _model.acceptCustomRequest(widget.customRequest);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NavigationMenu()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_car,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                width: 63,
                                child: Center(
                                  child: Text(
                                    "Pickup",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

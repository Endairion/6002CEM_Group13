import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/custom_request_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/custom_carpool_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

class CustomCarpoolCardView extends StatelessWidget {
  CustomRequest customRequest;
  CustomCarpoolCardView({Key? key, required CustomRequest this.customRequest}) : super(key: key);

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
                      Container(
                        width: 235,
                        child: Text(
                          customRequest.startLocation,
                          overflow: TextOverflow.ellipsis,
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
                      Container(
                        width: 235,
                        child: Text(
                          customRequest.destination,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Text("Remarks: ", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(customRequest.remarks, maxLines: null,),
                  SizedBox(height: 24,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                      ),
                      onPressed: () {_model.acceptCustomRequest(customRequest.id);},
                      child: Text("Pickup"),

                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

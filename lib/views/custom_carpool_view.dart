import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/custom_request_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/custom_carpool_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/custom_carpool_card_view.dart';

class CustomCarpoolView extends StatefulWidget {
  CustomCarpoolView({Key? key}) : super(key: key);

  @override
  State<CustomCarpoolView> createState() => _CustomCarpoolViewState();
}

class _CustomCarpoolViewState extends State<CustomCarpoolView> {
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
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.lightGreen,
          title: Text(
            'Notification Center',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/vector_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: ListView.builder(
            itemCount: _model.customRequestList.length,
            itemBuilder: (BuildContext context, int index) {
              var customRequest = _model.customRequestList[index];
              return CustomCarpoolCardView(customRequest : customRequest);
            },
          ),
        ),
      ),
    );
  }
}

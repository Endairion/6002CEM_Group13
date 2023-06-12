import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/custom_request_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/custom_carpool_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/custom_carpool_card_view.dart';

class CustomCarpoolView extends StatelessWidget {
  CustomCarpoolView({Key? key}) : super(key: key);

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
            'Back to Home',
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

            // children: [
            //   Padding(
            //     padding: EdgeInsets.all(12.0),
            //     child: Card(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       elevation: 16,
            //       child: Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: ListTile(
            //           title: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(right: 8),
            //                     child: Container(
            //                       width: 20,
            //                       height: 20,
            //                       decoration: BoxDecoration(
            //                         borderRadius: new BorderRadius.circular(30.0),
            //                         color: Colors.limeAccent[700],
            //                       ),
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           Text(
            //                             'S',
            //                             style: TextStyle(
            //                               fontSize: 12,
            //                               fontWeight: FontWeight.bold,
            //                               color: Colors.white,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     width: 235,
            //                     child: Text(
            //                       "adjfalkd alkdjafkljda akljdakld",
            //                       overflow: TextOverflow.ellipsis,
            //                       style: TextStyle(
            //                         fontSize: 16,
            //                         color: Colors.black87,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 16,
            //               ),
            //               Row(
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(right: 8),
            //                     child: Container(
            //                       width: 20,
            //                       height: 20,
            //                       decoration: BoxDecoration(
            //                         borderRadius: new BorderRadius.circular(30.0),
            //                         color: Colors.green[900],
            //                       ),
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           Text(
            //                             'D',
            //                             style: TextStyle(
            //                               fontSize: 12,
            //                               fontWeight: FontWeight.bold,
            //                               color: Colors.white,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     width: 235,
            //                     child: Text(
            //                       "adjfalkd alkdjafkljda akljdakld adsafasdfda adasfad asdfasdf",
            //                       overflow: TextOverflow.ellipsis,
            //                       style: TextStyle(
            //                         fontSize: 16,
            //                         color: Colors.black87,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(height: 16,),
            //               Text("Remarks: ", style: TextStyle(fontWeight: FontWeight.bold),),
            //               Text("Test abcdedfgeagdgaed pick me at lobby", maxLines: null,),
            //               SizedBox(height: 24,),
            //               Align(
            //                 alignment: Alignment.bottomRight,
            //                 child: ElevatedButton(
            //                   style: ElevatedButton.styleFrom(
            //                     backgroundColor: Colors.lightGreen,
            //                   ),
            //                   onPressed: () {  },
            //                   child: Text("Pickup"),
            //
            //                 ),
            //               )
            //
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ],
          ),
        ),
      ),
    );
  }
}

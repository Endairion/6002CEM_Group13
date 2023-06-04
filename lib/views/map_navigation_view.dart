import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:geocoding/geocoding.dart' as geo;
import 'package:mobile_app_development_cw2/viewmodels/map_navigation_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

class MapNavigation extends StatefulWidget {
  String tripId;
  MapNavigation({Key? key, required this.tripId}) : super(key: key);

  @override
  State<MapNavigation> createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> {
  late final MapNavigationViewModel _model;
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BaseView<MapNavigationViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady(widget.tripId);
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(_model.currentLocation.toString()),
        ),
        body: _model.currentLocation == null
            ? const Center(child: Text("Loading"))
            :GoogleMap(
          initialCameraPosition: CameraPosition(
            // target: _model.sourceLocation,
            target: LatLng(_model.currentLocation!.latitude!, _model.currentLocation!.longitude!),
            zoom: 13.5,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("currentLocation"),
              // icon: currentLocationIcon,
              position: LatLng(_model.currentLocation!.latitude!, _model.currentLocation!.longitude!),
            ),
            Marker(
              markerId: MarkerId("source"),
              // icon: sourceIcon,
              position: _model.sourceLocation,
            ),
            Marker(
              markerId: MarkerId("destination"),
              // icon: destinationIcon,
              position: _model.destination,
            ),
          },
          onMapCreated: (GoogleMapController controller) {
            _model.controller.complete(controller);
          },
          polylines: {
            Polyline(
              polylineId: const PolylineId("route"),
              points: _model.polylineCoordinates,
              color: const Color(0xFF48742c),
              width: 6,
            ),
          },
        ),
      ),
    );
  }
}

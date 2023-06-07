class CarpoolRequest {
  final String id;
  final String requesterId;
  final String tripId;
  final String driverId;
  final String pickupLocation;
  final String remarks;
  final String status;

  CarpoolRequest(
      {required this.id,
      required this.requesterId,
      required this.tripId,
      required this.driverId,
      required this.pickupLocation,
      required this.remarks,
      required this.status});
}

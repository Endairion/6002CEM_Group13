class CustomRequest {
  final String id;
  final String userId;
  final String startLocation;
  final String destination;
  final String date;
  final String time;
  final int status;
  final String remarks;

  CustomRequest(
      {required this.id,
      required this.userId,
      required this.startLocation,
      required this.destination,
      required this.date,
      required this.time,
      required this.status,
      required this.remarks});
}

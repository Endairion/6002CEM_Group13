class Trip {
  final String id;
  final String startLocation;
  final String destination;
  final String date;
  final String time;
  final String status;
  final int seats;
  final bool enablePickupNotification;

  Trip(
      {required this.id,
      required this.startLocation,
      required this.destination,
      required this.date,
      required this.time,
      required this.status,
      required this.seats,
      required this.enablePickupNotification});
}

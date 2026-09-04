class Booking {
  final int? id;
  final String bookingId;
  final String vehicleType;
  final String pickup;
  final String drop;
  final String packageDescription;
  final double fare;
  final String status;
  final String driverName;
  final String vehicleNumber;
  final String arrivalTime;
  final String dateTime;

  Booking({
    this.id,
    required this.bookingId,
    required this.vehicleType,
    required this.pickup,
    required this.drop,
    required this.packageDescription,
    required this.fare,
    required this.status,
    required this.driverName,
    required this.vehicleNumber,
    required this.arrivalTime,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookingId': bookingId,
      'vehicleType': vehicleType,
      'pickup': pickup,
      'dropLocation': drop,
      'packageDescription': packageDescription,
      'fare': fare,
      'status': status,
      'driverName': driverName,
      'vehicleNumber': vehicleNumber,
      'arrivalTime': arrivalTime,
      'dateTime': dateTime,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      bookingId: map['bookingId'],
      vehicleType: map['vehicleType'],
      pickup: map['pickup'],
      drop: map['dropLocation'],
      packageDescription: map['packageDescription'],
      fare: map['fare'],
      status: map['status'],
      driverName: map['driverName'],
      vehicleNumber: map['vehicleNumber'],
      arrivalTime: map['arrivalTime'],
      dateTime: map['dateTime'],
    );
  }
}

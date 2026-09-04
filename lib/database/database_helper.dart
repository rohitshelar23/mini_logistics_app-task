import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/booking.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      'logistics.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            bookingId TEXT,
            vehicleType TEXT,
            pickup TEXT,
            dropLocation TEXT,
            packageDescription TEXT,
            fare REAL,
            status TEXT,
            driverName TEXT,
            vehicleNumber TEXT,
            arrivalTime TEXT,
            dateTime TEXT
          )
        ''');
      },
    );
  }

  // Insert a new booking
  Future<int> insertBooking(Booking booking) async {
    final db = await database;

    return await db.insert(
      'bookings',
      booking.toMap(),
    );
  }

  // Get all bookings
  Future<List<Booking>> getBookings() async {
    final db = await database;

    final result = await db.query(
      'bookings',
      orderBy: 'id DESC',
    );

    return result.map(
      (map) {
        return Booking.fromMap(map);
      },
    ).toList();
  }

  // Update only booking status
  Future<void> updateBookingStatus(
    String bookingId,
    String status,
  ) async {
    final db = await database;

    await db.update(
      'bookings',
      {
        'status': status,
      },
      where: 'bookingId = ?',
      whereArgs: [bookingId],
    );
  }

  // Save assigned driver information
  Future<void> assignDriver({
    required String bookingId,
    required String driverName,
    required String vehicleNumber,
    required String arrivalTime,
  }) async {
    final db = await database;

    await db.update(
      'bookings',
      {
        'status': 'Driver Assigned',
        'driverName': driverName,
        'vehicleNumber': vehicleNumber,
        'arrivalTime': arrivalTime,
      },
      where: 'bookingId = ?',
      whereArgs: [bookingId],
    );
  }
}
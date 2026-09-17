import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> createBooking({
    required String pickupLocation,
    required String dropLocation,
    required String vehicleType,
    required double price,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    final bookingRef = await _firestore.collection('bookings').add({
      'userId': user.uid,
      'pickupLocation': pickupLocation.trim(),
      'dropLocation': dropLocation.trim(),
      'vehicleType': vehicleType,
      'price': price,
      'status': 'Pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return bookingRef.id;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserBookings() {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: user.uid)
        .snapshots();
  }

  Future<void> updateBookingStatus({
    required String bookingId,
    required String status,
  }) async {
    await _firestore
        .collection('bookings')
        .doc(bookingId)
        .update({
      'status': status,
    });
  }
}
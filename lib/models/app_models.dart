enum VehicleType { twoWheeler, threeWheeler, miniTruck, pickup8ft }

class VehicleOption {
  final VehicleType type;
  final String title;
  final String capacity;
  final String dimensions;
  final int basePrice;
  final int etaMinutes;
  final String tag;
  final bool isRecommended;

  const VehicleOption({
    required this.type,
    required this.title,
    required this.capacity,
    required this.dimensions,
    required this.basePrice,
    required this.etaMinutes,
    this.tag = 'Courier',
    this.isRecommended = false,
  });
}

const List<VehicleOption> kAvailableVehicles = [
  VehicleOption(
    type: VehicleType.twoWheeler,
    title: 'Two-Wheeler',
    capacity: 'Max 20 kg',
    dimensions: '40x40x40 cm',
    basePrice: 49,
    etaMinutes: 4,
    tag: 'Courier',
  ),
  VehicleOption(
    type: VehicleType.threeWheeler,
    title: '3-Wheeler Electric',
    capacity: 'Max 500 kg',
    dimensions: '5.5x3.5 ft',
    basePrice: 199,
    etaMinutes: 8,
    tag: 'Eco Mini',
  ),
  VehicleOption(
    type: VehicleType.miniTruck,
    title: 'Tata Ace / Mini Truck',
    capacity: 'Max 750 kg',
    dimensions: '7x4x5 ft',
    basePrice: 299,
    etaMinutes: 12,
    tag: '1 Ton',
    isRecommended: true,
  ),
  VehicleOption(
    type: VehicleType.pickup8ft,
    title: 'Pickup 8ft Truck',
    capacity: 'Max 1200 kg',
    dimensions: '8x4.5x5.5 ft',
    basePrice: 449,
    etaMinutes: 15,
    tag: 'Heavy',
  ),
];

class BookingItem {
  final String id;
  final String title;
  final String vehicleName;
  final String vehicleNumber;
  final String pickupAddress;
  final String dropAddress;
  final String itemsDescription;
  final int amount;
  final String dateTime;
  final String status; // 'Active', 'Delivered', 'Cancelled'
  final String? eta;

  const BookingItem({
    required this.id,
    required this.title,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.pickupAddress,
    required this.dropAddress,
    required this.itemsDescription,
    required this.amount,
    required this.dateTime,
    required this.status,
    this.eta,
  });
}

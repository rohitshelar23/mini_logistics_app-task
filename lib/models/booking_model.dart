enum VehicleType {
  twoWheeler,
  threeWheeler,
  miniTruck,
  pickup8ft,
}

class VehicleOption {
  final VehicleType type;
  final String title;
  final String capacity;
  final String dimensions;
  final double basePrice;
  final int etaMinutes;

  const VehicleOption({
    required this.type,
    required this.title,
    required this.capacity,
    required this.dimensions,
    required this.basePrice,
    required this.etaMinutes,
  });
}

const List<VehicleOption> kAvailableVehicles = [
  VehicleOption(
    type: VehicleType.twoWheeler,
    title: 'Two-Wheeler',
    capacity: 'Up to 20 kg',
    dimensions: 'Small parcels',
    basePrice: 49,
    etaMinutes: 15,
  ),
  VehicleOption(
    type: VehicleType.threeWheeler,
    title: '3-Wheeler',
    capacity: 'Up to 500 kg',
    dimensions: '6 x 4 x 4 ft',
    basePrice: 199,
    etaMinutes: 20,
  ),
  VehicleOption(
    type: VehicleType.miniTruck,
    title: 'Tata Ace',
    capacity: 'Up to 750 kg',
    dimensions: '7 x 5 x 5 ft',
    basePrice: 299,
    etaMinutes: 25,
  ),
  VehicleOption(
    type: VehicleType.pickup8ft,
    title: 'Pickup 8ft',
    capacity: 'Up to 1,200 kg',
    dimensions: '8 x 5.5 x 5 ft',
    basePrice: 449,
    etaMinutes: 30,
  ),
];

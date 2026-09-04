class DeliveryService {
  final String name;
  final String description;
  final double baseFare;
  final double perKm;
  final String icon;

  DeliveryService({
    required this.name,
    required this.description,
    required this.baseFare,
    required this.perKm,
    required this.icon,
  });
}

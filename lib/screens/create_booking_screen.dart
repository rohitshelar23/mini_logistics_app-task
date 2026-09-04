import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/api_service.dart';
import '../viewmodels/booking_view_model.dart';
import 'booking_summary_screen.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({super.key});

  @override
  State<CreateBookingScreen> createState() =>
      _CreateBookingScreenState();
}

class _CreateBookingScreenState
    extends State<CreateBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final pickupController = TextEditingController();
  final dropController = TextEditingController();
  final packageController = TextEditingController();

  final ApiService _apiService = ApiService();

  double? estimatedDistance;
  bool isEstimatingDistance = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final vm = context.read<BookingViewModel>();

      if (vm.services.isEmpty) {
        vm.loadServices();
      }
    });
  }

  @override
  void dispose() {
    pickupController.dispose();
    dropController.dispose();
    packageController.dispose();
    super.dispose();
  }

  Future<void> reviewBooking() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isEstimatingDistance = true;
    });

    try {
      final distance = await _apiService.estimateDistance(
        pickupController.text.trim(),
        dropController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        estimatedDistance = distance;
        isEstimatingDistance = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BookingSummaryScreen(
            pickup: pickupController.text.trim(),
            drop: dropController.text.trim(),
            packageDescription:
                packageController.text.trim(),
            distance: distance,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isEstimatingDistance = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to estimate distance. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Booking'),
      ),
      body: Consumer<BookingViewModel>(
        builder: (context, vm, child) {
          if (vm.services.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: pickupController,
                  decoration: const InputDecoration(
                    labelText: 'Pickup Location',
                    hintText: 'Enter pickup address',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Enter pickup location';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: dropController,
                  decoration: const InputDecoration(
                    labelText: 'Drop Location',
                    hintText: 'Enter drop address',
                    prefixIcon:
                        Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Enter drop location';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField(
                  initialValue: vm.selectedService,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Type',
                    border: OutlineInputBorder(),
                  ),
                  items: vm.services.map((service) {
                    return DropdownMenuItem(
                      value: service,
                      child: Text(service.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      vm.selectService(value);
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Select vehicle type';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: packageController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Package / Item Description',
                    hintText: 'Example: 2 boxes of clothes',
                    prefixIcon:
                        Icon(Icons.inventory_2),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Enter package description';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.route,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Distance',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              estimatedDistance == null
                                  ? 'Will be estimated automatically'
                                  : '${estimatedDistance!.toStringAsFixed(1)} km estimated',
                              style: TextStyle(
                                color: Colors
                                    .grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.auto_awesome,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                if (estimatedDistance != null &&
                    vm.selectedService != null)
                  Text(
                    'Estimated Fare: ₹${vm.calculateFare(estimatedDistance!).toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                const SizedBox(height: 25),

                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isEstimatingDistance
                        ? null
                        : reviewBooking,
                    child: isEstimatingDistance
                        ? const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Estimating Distance...',
                              ),
                            ],
                          )
                        : const Text(
                            'Review Booking',
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

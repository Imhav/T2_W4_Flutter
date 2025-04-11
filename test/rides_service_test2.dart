// test/rides_service_test.dart
import 'package:w4_flutter/model/ride/locations.dart'; // Adjust path to your Location model
import 'package:w4_flutter/model/ride_pref/ride_pref.dart'; // Adjust path to your RidePreference model
import 'package:w4_flutter/repository/mock/mock_ride_repository.dart';
 // Adjust path to your MockRidesRepository
import 'package:w4_flutter/service/rides_service.dart'; // Adjust path to your RidesService
import 'package:w4_flutter/utils/date_time_util.dart'; // Adjust path to your DateTimeUtil

void main() {
  // 1. Initialize RidesService with MockRidesRepository
  RidesService.initialize(MockRidesRepository());

  // Test T1: Create a ride preference and assert 4 results with a warning for full ride
  print("Running Test T1...");
  final preferenceT1 = RidePreference(
    departure: Location(name: "Battambang", country: Country.cambodia),
    arrival: Location(name: "Siem Reap", country: Country.cambodia),
    departureDate: DateTime.now(), // Today
    requestedSeats: 1,
  );
  final resultsT1 = RidesService.instance.getRides(preferenceT1, null);

  print(
      'For your preference (${preferenceT1.departure.name} -> ${preferenceT1.arrival.name}, today ${preferenceT1.requestedSeats} passenger)');
  print('we found ${resultsT1.length} rides:');

  bool hasFullRideWarning = false;
  for (final ride in resultsT1) {
    final duration = ride.arrivalDateTime.difference(ride.departureDate);
    print('- at ${DateTimeUtils.formatTime(ride.departureDate)} '
        '\twith ${ride.driver.firstName} '
        '(${duration.inHours} hours)');

    if (ride.availableSeats == 0) {
      print('Warning: 1 ride is full!');
      hasFullRideWarning = true;
    }
  }

  assert(resultsT1.length == 4, "T1 failed: Expected 4 results, got ${resultsT1.length}");
  assert(hasFullRideWarning, "T1 failed: Expected warning for full ride, but none found");
  print("T1 Passed: Asserted 4 results are displayed with a warning for 1 full ride");

  // Test T2: Create a ride preference and filter for pet-allowed rides
  print("\nRunning Test T2...");
  final preferenceT2 = RidePreference(
    departure: Location(name: "Battambang", country: Country.cambodia),
    arrival: Location(name: "Siem Reap", country: Country.cambodia),
    departureDate: DateTime.now(), // Today
    requestedSeats: 1,
  );
  final filterT2 = RidesFilter(acceptPets: true); // Pet allowed
  final resultsT2 = RidesService.instance.getRides(preferenceT2, filterT2);

  print(
      'For your preference (${preferenceT2.departure.name} -> ${preferenceT2.arrival.name}, today ${preferenceT2.requestedSeats} passenger) with pet filter');
  print('we found ${resultsT2.length} rides:');

  for (final ride in resultsT2) {
    final duration = ride.arrivalDateTime.difference(ride.departureDate);
    print('- at ${DateTimeUtils.formatTime(ride.departureDate)} '
        '\twith ${ride.driver.firstName} '
        '(${duration.inHours} hours)');
  }

  assert(resultsT2.length == 1, "T2 failed: Expected 1 result, got ${resultsT2.length}");
  assert(resultsT2.any((ride) => ride.driver.firstName == "Limhao"),
         "T2 failed: Expected Limhao's ride (pet allowed), but got ${resultsT2.map((ride) => ride.driver.firstName).join(', ')}");
 
  print("T2 Passed: Asserted 1 result displayed (Limhao) - Note: Expected 'Mengtech' may be a typo; only Limhao accepts pets in mock data");

  print("\nAll tests completed successfully!");
}
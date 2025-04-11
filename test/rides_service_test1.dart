import 'package:w4_flutter/model/ride/locations.dart';
import 'package:w4_flutter/model/ride_pref/ride_pref.dart';
import 'package:w4_flutter/repository/mock/mock_ride_repository.dart';
import 'package:w4_flutter/service/rides_service.dart';

void main() {
  // 1. Initialize RidesService with MockRidesRepository
  RidesService.initialize(MockRidesRepository());

  final preferenceT1 = RidePreference(
    departure: Location(name: "Battambang", country: Country.cambodia),
    arrival: Location(name: "Siem Reap", country: Country.cambodia),
    departureDate: DateTime.now(), // Today
    requestedSeats: 0,
  );
  final resultsT1 = RidesService.instance.getRides(preferenceT1, null);

  // Count results and check for full ride
  int resultCount = resultsT1.length;
  bool hasFullRide = resultsT1.any((ride) => ride.availableSeats == 0);

  // Assert T1 results
  assert(resultCount == 4, "T1 failed: Expected 4 results, got $resultCount");
  assert(
    hasFullRide,
    "T1 failed: Expected warning for full ride, but none found",
  );
  print(
    "T1 Passed: Asserted 4 results are displayed with a warning for 1 full ride",
  );
}

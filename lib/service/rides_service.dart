import '../model/ride/ride.dart';
import '../model/ride_pref/ride_pref.dart';
import '../repository/ride_repository.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  // Static private instance for singleton pattern
  static RidesService? _instance;

  // Repository
  final RidesRepository repository;

  // Access to the rides repository via dependency injection (handled by RidesRepository singleton)
  RidesService._internal(this.repository);

  ///
  /// Initialize the service (no repository needed, as RidesRepository is a singleton)
  ///
  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized");
    }
  }

  ///
  /// Singleton accessor
  ///
  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
        "RidesService is not initialized. Call initialize() first.",
      );
    }
    return _instance!;
  }

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  List<Ride> getRides(RidePreference preferences, RidesFilter? filter) {
    return repository.getRides(preferences, filter);
  }
}

class RidesFilter {
  final bool? acceptPets;

  const RidesFilter({this.acceptPets});
}

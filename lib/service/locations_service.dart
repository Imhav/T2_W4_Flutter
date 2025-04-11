
import '../model/ride/locations.dart';
import '../repository/location_repository.dart'; 


///
/// This service handles:
/// - The list of available locations
///
class LocationsService {
  // Static private instance for singleton pattern
  static LocationsService? _instance;

  // Access to the location repository via dependency injection
  final LocationsRepository repository;

  ///
  /// Private constructor
  ///
  LocationsService._internal(this.repository);

  ///
  /// Initialize the service with a specific repository
  ///
  static void initialize(LocationsRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    } else {
      throw Exception("LocationsService is already initialized.");
    }
  }

  ///
  /// Singleton accessor
  ///
  static LocationsService get instance {
    if (_instance == null) {
      throw Exception("LocationsService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  ///
  /// Get the list of available locations from the repository
  ///
  List<Location> getLocations() {
    return repository.getLocations();
  }
}
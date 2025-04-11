import 'package:w4_flutter/model/ride/locations.dart';
import 'package:w4_flutter/model/user/user.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../ride_repository.dart';
import '../../service/rides_service.dart';

///
/// Mock implementation of RidesRepository for testing purposes.
/// Provides a hardcoded list of rides from Battambang to Siem Reap with various attributes.
///
class MockRidesRepository extends RidesRepository {
  final List<Ride> _rides = [
    Ride(
      departureLocation: Location(
        name: "Battambang",
        country: Country.cambodia,
      ),
      departureDate: DateTime.now().add(const Duration(hours: 5, minutes: 30)),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(
        const Duration(hours: 7, minutes: 30),
      ),
      driver: User(
        firstName: "ou",
        lastName: "venhav",
        email: "venhavou@gmail.com",
        phone: "012 331 245",
        profilePicture: "",
        verifiedProfile: true,
      ),
      availableSeats: 2,
      pricePerSeat: 15,
      acceptPets: false,
    ),
    Ride(
      departureLocation: Location(
        name: "Battambang",
        country: Country.cambodia,
      ),
      departureDate: DateTime.now().add(const Duration(hours: 17)),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(const Duration(hours: 20)),
      driver: User(
        firstName: "pech",
        lastName: "ravong",
        email: "ravongpech@gmail.com",
        phone: "012 212 123",
        profilePicture: "",
        verifiedProfile: true,
      ),
      availableSeats: 0,
      pricePerSeat: 15,
      acceptPets: false,
    ),

    Ride(
      departureLocation: Location(
        name: "Battambang",
        country: Country.cambodia,
      ),
      departureDate: DateTime.now().add(
        const Duration(hours: 17),
      ), // Today at 5:00 PM
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(
        const Duration(hours: 20),
      ), // 3 hours later
      driver: User(
        firstName: "sokheng",
        lastName: "sok",
        email: "sokhengsok@gmail.com",
        phone: "023 123 523",
        profilePicture: "",
        verifiedProfile: true,
      ),
      availableSeats: 1,
      pricePerSeat: 15,
      acceptPets: false,
    ),

    Ride(
      departureLocation: Location(
        name: "Battambang",
        country: Country.cambodia,
      ),
      departureDate: DateTime.now().add(
        const Duration(hours: 17),
      ), // Today at 5:00 PM
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(
        const Duration(hours: 20),
      ), // 3 hours later
      driver: User(
        firstName: "Visal",
        lastName: "Sem",
        email: "Visalsem@gmail.com",
        phone: "012 854 165",
        profilePicture: "",
        verifiedProfile: true,
      ),
      availableSeats: 2,
      pricePerSeat: 15,
      acceptPets: true,
    ),

    Ride(
      departureLocation: Location(
        name: "Battambang",
        country: Country.cambodia,
      ),
      departureDate: DateTime.now().add(
        const Duration(hours: 17),
      ), // Today at 5:00 PM
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(
        const Duration(hours: 20),
      ), // 3 hours later
      driver: User(
        firstName: "Hong",
        lastName: "Heng",
        email: "HengHong@gmail.com",
        phone: "093 213 1267",
        profilePicture: "",
        verifiedProfile: true,
      ),
      availableSeats: 1,
      pricePerSeat: 15,
      acceptPets: false,
    ),
  ];

  @override
  List<Ride> getRides(RidePreference preferences, RidesFilter? filter) {
    /// Filters the mock rides based on user preferences, date, pet filter, and seat availability.
    return _rides.where((ride) {
      /// Check if the ride matches the departure and arrival locations.
      final bool matchesPreference =
          ride.departureLocation == preferences.departure &&
          ride.arrivalLocation == preferences.arrival;

      /// Check if the ride departs today (simplified date comparison).
      final bool dateMatch =
          ride.departureDate.day == preferences.departureDate.day &&
          ride.departureDate.month == preferences.departureDate.month &&
          ride.departureDate.year == preferences.departureDate.year;

      /// Apply pet filter if provided, otherwise accept all rides.
      final bool petMatch =
          filter?.acceptPets == null
              ? true
              : ride.acceptPets == filter!.acceptPets;

      /// Ensure the ride has enough available seats for the requested number.
      final bool seatMatch = ride.availableSeats >= preferences.requestedSeats;

      /// Return true only if all conditions are met.
      return matchesPreference && dateMatch && petMatch && seatMatch;
    }).toList();
  }

  @override
  void addRides(Ride ride) {
    _rides.add(ride);
  }
}

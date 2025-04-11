import 'package:flutter/material.dart';
import 'package:w4_flutter/model/ride/ride.dart';
import 'package:w4_flutter/model/ride_pref/ride_pref.dart';
import 'package:w4_flutter/service/ride_prefs_service.dart';
import 'package:w4_flutter/service/rides_service.dart';
import 'package:w4_flutter/theme/theme.dart';
import 'package:w4_flutter/utils/animations_util.dart';
import '../../model/ride/locations.dart';
import 'widgets/ride_pref_bar.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late RidePreference currentPreference;

  @override
  void initState() {
    super.initState();
    currentPreference =
        RidePrefService.instance.currentPreference ??
        RidePreference(
          departure: Location(name: "", country: Country.cambodia),
          arrival: Location(name: "", country: Country.cambodia),
          departureDate: DateTime.now(),
          requestedSeats: 1,
        );
  }

  List<Ride> get matchingRides =>
      RidesService.instance.repository.getRides(currentPreference, null);

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  void onPreferencePressed() async {
    RidePreference? newPref = await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createTopSheetRoute(
        RidePrefModal(currentPreference: currentPreference),
      ),
    );

    if (newPref != null) {
      RidePrefService.instance.setCurrentPreference(newPref);
      setState(() {
        currentPreference = newPref;
      });
    }
  }

  void onFilterPressed() {
    // TODO: Implement filter logic (e.g., pet filter) if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: BlaSpacings.m,
            right: BlaSpacings.m,
            top: BlaSpacings.s,
          ),
          child: Column(
            children: [
              RidePrefBar(
                ridePreference: currentPreference,
                onBackPressed: onBackPressed,
                onPreferencePressed: onPreferencePressed,
                onFilterPressed: onFilterPressed,
              ),
              ListView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // Prevent nested scrolling
                shrinkWrap: true, // Fit content within SingleChildScrollView
                itemCount: matchingRides.length,
                itemBuilder:
                    (ctx, index) =>
                        RideTile(ride: matchingRides[index], onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import '../../model/ride/ride.dart';

// import '../../model/ride_pref/ride_pref.dart';
// import '../../service/ride_prefs_service.dart';
// import '../../service/rides_service.dart';
// import '../../theme/theme.dart';
// import '../../utils/animations_util.dart';
// import 'widgets/ride_pref_bar.dart';
// import 'widgets/ride_pref_modal.dart';
// import 'widgets/rides_tile.dart';

// ///
// ///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
// ///  The screen also allow user to re-define the ride preferences and to activate some filters.
// ///
// class RidesScreen extends StatefulWidget {
//   const RidesScreen({super.key});

//   @override
//   State<RidesScreen> createState() => _RidesScreenState();
// }

// class _RidesScreenState extends State<RidesScreen> {
//   RidePreference get currentPreference =>
//       RidePrefService.instance.currentPreference!;

//   RidesFilter currentFilter = RidesFilter();

//   List<Ride> get matchingRides =>
//       RidesService.instance.getRides(currentPreference, currentFilter);

//   void onBackPressed() {
//     // 1 - Back to the previous view
//     Navigator.of(context).pop();
//   }

//   onRidePrefSelected(RidePreference newPreference) async {}

//   void onPreferencePressed() async {
//     // Open a modal to edit the ride preferences
//     RidePreference? newPreference = await Navigator.of(
//       context,
//     ).push<RidePreference>(
//       AnimationUtils.createTopToBottomRoute(
//         RidePrefModal(initialPreference: currentPreference),
//       ),
//     );

//     if (newPreference != null) {
//       // 1 - Update the current preference
//       RidePrefService.instance.setCurrentPreference(newPreference);

//       // 2 -   Update the state   -- TODO MAKE IT WITH STATE MANAGEMENT
//       setState(() {});
//     }
//   }

//   void onFilterPressed() {}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(
//           left: BlaSpacings.m,
//           right: BlaSpacings.m,
//           top: BlaSpacings.s,
//         ),
//         child: Column(
//           children: [
//             // Top search Search bar
//             RidePrefBar(
//               ridePreference: currentPreference,
//               onBackPressed: onBackPressed,
//               onPreferencePressed: onPreferencePressed,
//               onFilterPressed: onFilterPressed,
//             ),

//             Expanded(
//               child: ListView.builder(
//                 itemCount: matchingRides.length,
//                 itemBuilder:
//                     (ctx, index) =>
//                         RideTile(ride: matchingRides[index], onPressed: () {}),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

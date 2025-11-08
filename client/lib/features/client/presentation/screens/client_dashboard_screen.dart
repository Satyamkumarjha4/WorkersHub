import 'package:client/core/constants/colors.dart';
import 'package:client/features/client/presentation/widgets/dashboard_header.dart';
import 'package:client/features/client/presentation/widgets/list_of_workers.dart';
import 'package:client/providers/dio_client_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class ClientDashboardScreen extends ConsumerStatefulWidget {
  const ClientDashboardScreen({super.key});

  @override
  ConsumerState<ClientDashboardScreen> createState() =>
      _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends ConsumerState<ClientDashboardScreen> {
  late final Response<dynamic> response;
  @override
  void initState() {
    super.initState();
    print("on client dashboard");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _determinePosition();
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ✅ Must be awaited after initialization
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    print("User position: $position");
    final dioClient = ref.read(dioClientProvider);
    response = await dioClient.post(
      "/worker/getWorkerByRange",
      data: {
        "latitude": position.latitude,
        "longitude": position.longitude,
        "range": 2,
      },
    );
    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,

      // bottomNavigationBar: SafeArea(
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(vertical: 10.0),
      //     child: BottomAppBar(
      //       color: AppColors.secondaryBackgroundColor,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           BottomNavBarItem(name: "Home", icon: Icons.home, onTap: () {}),
      //           BottomNavBarItem(
      //             name: "Post",
      //             icon: Icons.post_add,
      //             onTap: () {},
      //           ),
      //           BottomNavBarItem(name: "Jobs", icon: Icons.work, onTap: () {}),
      //           BottomNavBarItem(
      //             name: "Profile",
      //             icon: Icons.person,
      //             onTap: () {},
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        title: Text(
          "WorkersHub",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.secondaryTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(),
            const SizedBox(height: 16),
            Text(
              "Workers around you",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.secondaryTextColor,
              ),
            ),

            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: ListOfWorkers(workers: response.data["workers"]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

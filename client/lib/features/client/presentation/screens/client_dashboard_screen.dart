import 'package:client/core/constants/colors.dart';
import 'package:client/features/client/presentation/providers.dart';
import 'package:client/features/client/presentation/screens/jobs_screen.dart';
import 'package:client/features/client/presentation/screens/post_screen.dart';
import 'package:client/features/client/presentation/screens/profile_screen.dart';
import 'package:client/features/client/presentation/widgets/dashboard_header.dart';
import 'package:client/features/client/presentation/widgets/list_of_workers.dart';
import 'package:client/providers/dio_client_provider.dart';
import 'package:client/providers/nav_bar_index.dart';
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
  int _selectedIndex = 0;

  // Screens for each tab
  final List<Widget> _pages = const [
    Center(child: Text("Home Screen")),
    Center(child: Text("Post Screen")),
    Center(child: Text("Jobs Screen")),
    Center(child: Text("Profile Screen")),
  ];

  final List<Widget> _links = [
    ClientDashboardScreen(),
    PostScreen(),
    JobsScreen(),
    ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    ref.read(selectedIndex.notifier).update((id) => index);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _links[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workersAsync = ref.watch(workersProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: ref.read(selectedIndex),
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primaryTextColor,
        unselectedItemColor: AppColors.secondaryTextColor,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            activeIcon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "WorkersHub",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: AppColors.primaryBackgroundColor,
      ),
      body: workersAsync.when(
        data: (response) {
          final data = response.data;
          print(data);
          return data["total"] == 0
              ? Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DashboardHeader(),
                      const SizedBox(height: 30),
                      Text(
                        "Workers around you",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.secondaryTextColor),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: Center(
                          child: Text(
                            "No workers found!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: AppColors.secondaryTextColor),
        ),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}

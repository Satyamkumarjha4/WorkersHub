import 'package:client/core/constants/colors.dart';
import 'package:client/features/client/presentation/screens/client_dashboard_screen.dart';
import 'package:client/features/client/presentation/screens/post_screen.dart';
import 'package:client/features/client/presentation/screens/profile_screen.dart';
import 'package:client/providers/nav_bar_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({super.key});

  @override
  ConsumerState<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
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
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "WorkersHub",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: AppColors.primaryBackgroundColor,
      ),
      body: Center(child: Text("Job screen")),
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
    );
  }
}

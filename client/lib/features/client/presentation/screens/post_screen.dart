import 'package:client/core/constants/colors.dart';
import 'package:client/core/widgets/custom_text_field.dart';
import 'package:client/core/widgets/primary_button.dart';
import 'package:client/features/client/presentation/screens/client_dashboard_screen.dart';
import 'package:client/features/client/presentation/screens/profile_screen.dart';
import 'package:client/providers/dio_client_provider.dart';
import 'package:client/providers/nav_bar_index.dart';
import 'package:client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  int _selectedIndex = 1;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();
  final _categoryController = TextEditingController();
  DateTime? _deadline;

  final _pages = const [
    ClientDashboardScreen(),
    PostScreen(),
    Center(child: Text("Jobs Screen")),
    ProfileScreen(),
  ];

  /// ✅ Pick Date (new Material 3 API)
  Future<void> openDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _deadline = pickedDate;
      });
    }
  }

  /// ✅ Submit Job
  Future<void> postJob() async {
    final dioClient = ref.read(dioClientProvider);
    final userId = ref.read(userNotifierProvider).id;

    if (_deadline == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a deadline")));
      return;
    }

    final response = await dioClient.post(
      "/post/create",
      data: {
        "title": _titleController.text,
        "description": _descriptionController.text,
        "budget": double.tryParse(_budgetController.text) ?? 0,
        "category": _categoryController.text,
        "deadline": _deadline!.toIso8601String(),
        "authorId": userId,
        "mediaUrls": [],
      },
    );

    print(response.data);
    if (response.statusCode == 201 && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Post created successfully",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      );
    }
  }

  /// ✅ Handle bottom nav tap
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // no duplicate nav
    ref.read(selectedIndex.notifier).state = index;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => _pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        title: Text(
          "WorkersHub",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: AppColors.primaryBackgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Post a job", style: Theme.of(context).textTheme.titleLarge),
            Text(
              "Get reliable help in minutes",
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontSize: 15),
            ),
            const SizedBox(height: 30),

            CustomTextField(
              controller: _titleController,
              label: "Title",
              placeholder: "Enter the title",
              type: TextInputType.text,
            ),
            const SizedBox(height: 20),

            CustomTextField(
              controller: _descriptionController,
              label: "Description",
              placeholder: "Enter the description",
              type: TextInputType.multiline,
            ),
            const SizedBox(height: 20),

            CustomTextField(
              controller: _budgetController,
              label: "Budget",
              placeholder: "Enter the budget",
              type: TextInputType.number,
            ),
            const SizedBox(height: 20),

            CustomTextField(
              controller: _categoryController,
              label: "Category",
              placeholder: "Enter the category",
              type: TextInputType.text,
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: openDatePicker,
              child: Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.secondaryTextColor),
                ),
                child: Text(
                  _deadline == null
                      ? "Select Deadline"
                      : "${_deadline!.day}/${_deadline!.month}/${_deadline!.year}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),

            const SizedBox(height: 40),
            PrimaryButton(onTap: postJob, text: "Post Job"),
          ],
        ),
      ),

      /// ✅ Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primaryTextColor,
        unselectedItemColor: AppColors.secondaryTextColor,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Post",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: "Jobs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

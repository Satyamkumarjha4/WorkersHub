import 'package:client/core/constants/colors.dart';
import 'package:client/features/client/data/models/worker_model.dart';
import 'package:flutter/material.dart';

class WorkerCard extends StatelessWidget {
  final WorkerModel info;
  const WorkerCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(info.avatar),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(width: 15.0),
          Text(
            info.name,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(width: 135.0),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_on, color: AppColors.secondaryTextColor),
          ),
          const SizedBox(width: 5.0),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.message, color: AppColors.secondaryTextColor),
          ),
        ],
      ),
    );
  }
}

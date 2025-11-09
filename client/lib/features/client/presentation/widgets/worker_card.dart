import 'package:client/core/constants/colors.dart';
import 'package:client/features/client/data/models/worker_model.dart';
import 'package:client/features/client/presentation/screens/chat_screen.dart';
import 'package:client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkerCard extends ConsumerStatefulWidget {
  final dynamic info;
  const WorkerCard({super.key, required this.info});

  @override
  ConsumerState<WorkerCard> createState() => _WorkerCardState();
}

class _WorkerCardState extends ConsumerState<WorkerCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.info);
    final userId = ref.read(userNotifierProvider).id;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  widget.info["avatar"] ??
                      "https://lh3.googleusercontent.com/a/ACg8ocIz71RnCAqe6YgcS4f1s6iqgFT_raioMWF3m6ooaL28DEDWag=s96-c",
                ),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 15.0),
              Text(
                widget.info["name"],
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.location_on,
                  color: AppColors.secondaryTextColor,
                ),
              ),
              const SizedBox(width: 5.0),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        senderId: userId!,
                        receiverId: widget.info["idForChat"],
                        receiverName: widget.info["name"],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.message, color: AppColors.secondaryTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

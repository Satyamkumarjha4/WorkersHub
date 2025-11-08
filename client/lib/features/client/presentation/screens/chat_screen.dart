import 'package:client/core/constants/colors.dart';
import 'package:client/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.primaryTextColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Jatin", style: Theme.of(context).textTheme.labelMedium),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(spacing: 10.0, children: [Text("Message")]),
          ),
          Row(
            spacing: 5.0,
            children: [
              CustomTextField(
                type: TextInputType.text,
                label: "Message",
                placeholder: "Type something...",
                controller: _controller,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.secondaryTextColor,
                  foregroundColor: AppColors.secondaryBackgroundColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:client/core/constants/colors.dart';
import 'package:client/core/widgets/custom_text_field.dart';
import 'package:client/models/user_model.dart';
import 'package:client/providers/dio_client_provider.dart';
import 'package:client/providers/socket_provider.dart';
import 'package:client/providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String senderId;
  final String receiverId;
  final String receiverName;

  const ChatScreen({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late final Dio dioClient;
  late final socket;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dioClient = ref.read(dioClientProvider);
      socket = ref.read(socketProvider);
      socket.connect();
      getMessages();
    });
  }

  @override
  void dispose() {
    socket.off("receive_message");
    _controller.dispose();
    super.dispose();
  }

  void getMessages() async {
    print(widget.senderId);
    print(widget.receiverId);
    final response = await dioClient.get(
      "/conversation/getmessage",
      data: {"myId": widget.senderId, "otherId": widget.receiverId},
    );
    print("get message status code: ${response.statusCode}");
    print(response.data["messages"]);
    setState(() {
      ref
          .read(userNotifierProvider.notifier)
          .update(
            (prev) => UserModel(
              id: prev.id,
              name: prev.name,
              avatar: prev.avatar,
              role: prev.role,
              email: prev.email,
              messages: response.data["messages"],
            ),
          );
    });
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final text = _controller.text.trim();
    _controller.clear();

    try {
      final response = await dioClient.post(
        "/conversation/sendmessage/${widget.receiverId}",
        data: {"senderId": widget.senderId, "message": text},
      );

      if (response.data["success"]) {
        ref.read(userNotifierProvider.notifier).update((prev) {
          final updatedMessages = [
            ...?prev.messages,
            {"text": text, "senderId": response.data["data"]["senderId"]},
          ];
          return UserModel(
            id: prev.id,
            name: prev.name,
            avatar: prev.avatar,
            role: prev.role,
            email: prev.email,
            messages: updatedMessages,
          );
        });
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primaryTextColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.receiverName,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Messages area
            Expanded(
              child: user.messages != null
                  ? SingleChildScrollView(
                      reverse: user.messages != null,
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(user.messages!.length, (index) {
                          final isMe =
                              user.messages?[index]["senderId"] == user.id;
                          final messageText =
                              user.messages?[index]["text"] ?? "";

                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              constraints: BoxConstraints(
                                // keeps bubbles from being too wide
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? AppColors.secondaryTextColor
                                    : AppColors.secondaryBackgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(12),
                                  topRight: const Radius.circular(12),
                                  bottomLeft: isMe
                                      ? const Radius.circular(12)
                                      : const Radius.circular(0),
                                  bottomRight: isMe
                                      ? const Radius.circular(0)
                                      : const Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                messageText,
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(
                                      color: isMe
                                          ? AppColors.secondaryBackgroundColor
                                          : AppColors.secondaryTextColor,
                                    ),
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  : Center(
                      child: Text(
                        "No messages found!",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
            ),

            // Message input area
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackgroundColor,
                border: Border(
                  top: BorderSide(color: AppColors.secondaryTextColor),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      type: TextInputType.text,
                      label: "Message",
                      placeholder: "Type a message...",
                      controller: _controller,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryTextColor,
                      foregroundColor: AppColors.primaryBackgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

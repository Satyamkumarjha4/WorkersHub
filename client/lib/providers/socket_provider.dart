import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:client/providers/user_provider.dart';

final socketProvider = Provider<io.Socket>((ref) {
  final user = ref.read(userNotifierProvider);
  print("user id in socket provider is ${user.id}");
  final socket = io.io(
    'http://192.168.0.140:5000',
    io.OptionBuilder()
        .setTransports(['websocket'])
        .setQuery({'userId': user.id})
        .enableAutoConnect()
        .build(),
  );

  socket.onConnect((_) {
    print("✅ Socket connected to server!");
  });

  socket.on("newMessage", (_) {});

  socket.onConnectError((err) {
    print("❌ Connect error: $err");
  });

  socket.onError((err) {
    print("⚠️ Socket error: $err");
  });

  socket.onDisconnect((_) {
    print("🛑 Socket disconnected");
  });

  return socket;
});

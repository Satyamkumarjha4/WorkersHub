import "package:client/core/constants/secrets.dart";
import "package:client/providers/user_provider.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:socket_io_client/socket_io_client.dart" as io;

final socketProvider = Provider<io.Socket>((ref) {
  final user = ref.read(userNotifierProvider);
  io.Socket socket = io.io(Secrets.serverUrl, {
    "query": {"userId": user.id},
  });

  socket.onConnect((_) {
    print("socket server connected!");
    socket.emit("connect", "connected");
  });

  return socket;
});

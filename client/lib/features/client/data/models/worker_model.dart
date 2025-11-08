class WorkerModel {
  final String id;
  final String name;
  final String avatar;
  final String workingAddress;
  final String idForChat;
  final int age;
  final String description;

  const WorkerModel({
    required this.name,
    required this.avatar,
    required this.workingAddress,
    required this.id,
    required this.idForChat,
    required this.age,
    required this.description,
  });
}

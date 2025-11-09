import 'package:client/features/client/data/models/worker_model.dart';
import 'package:client/features/client/presentation/widgets/worker_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListOfWorkers extends ConsumerWidget {
  final List<dynamic> workers;
  const ListOfWorkers({super.key, required this.workers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 10.0,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(workers.length, (index) {
        return WorkerCard(info: workers[index]);
      }),
    );
  }
}

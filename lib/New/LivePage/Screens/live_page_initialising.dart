import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Repository/live_repository.dart';
import 'live_page.dart';

// final liveRateNotifier = ref.read(liveRateProvider.notifier);
final liveRateInitializationProvider = FutureProvider<void>((ref) async {
  final notifier = ref.read(liveRateProvider.notifier);
  await notifier.fetchServerLink().then(
    (value) {
      notifier.initializeSocketConnection(link: value);
    },
  );
});

class LiveRatesWidget extends ConsumerWidget {
  const LiveRatesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialization = ref.watch(liveRateInitializationProvider);

    return initialization.when(
      data: (_) => const LivePage(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

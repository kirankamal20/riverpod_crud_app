import 'package:flutter_riverpod/flutter_riverpod.dart';

final offlineModePod = StateProvider.autoDispose<bool>((ref) {
  return false;
});
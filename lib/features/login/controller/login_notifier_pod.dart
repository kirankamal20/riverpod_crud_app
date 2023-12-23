import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/features/login/controller/notifier/login_notifier.dart';
import 'package:riverpod_crud_app/features/login/view/ui_state/login_state.dart';

final loginAsyncNotifierPod =
    AutoDisposeAsyncNotifierProvider<LoginNotifier, LoginState>(
        LoginNotifier.new);

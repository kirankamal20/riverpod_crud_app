import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/features/login/controller/notifier/login_notifier.dart';
import 'package:riverpod_crud_app/features/login/view/ui_state/login_state.dart';
import 'package:riverpod_crud_app/features/register/controller/notifier/register_notifier.dart';
import 'package:riverpod_crud_app/features/register/view/ui_state/register_state.dart';

final registerAsyncNotifierPod =
    AutoDisposeAsyncNotifierProvider<RegisterNotifier, RegisterState>(
        RegisterNotifier.new);

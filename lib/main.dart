import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_state_notifier/hydrated_state_notifier.dart';
import 'package:riverpod_crud_app/app/my_app.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_pod.dart';
import 'package:talker/talker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_state_notifier_hive/hydrated_state_notifier_hive.dart';
import 'package:path/path.dart' as path;

final talker = Talker();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var temporaryDirectory = await getTemporaryDirectory();
  HydratedStorage.storage = await HiveHydratedStorage.build(
    storageDirectoryPath: kIsWeb ? '' : temporaryDirectory.path,
  );
  final collection = await Hive.openBox("user");
  runApp(
    ProviderScope(
      overrides: [userBox.overrideWithValue(collection)],
      child: const MyApp(),
    ),
  );
}

/// Flutter code sample for [Draggable].

// void main() => runApp(const DraggableExampleApp());

// class DraggableExampleApp extends StatelessWidget {
//   const DraggableExampleApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Draggable Sample')),
//         body: const DraggableExample(),
//       ),
//     );
//   }
// }

class DraggableExample extends StatefulWidget {
  const DraggableExample({super.key});

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  int acceptedData = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Draggable<int>(
          data: 10,
          feedback: Container(
            color: Colors.deepOrange,
            height: 100,
            width: 100,
            child: const Icon(Icons.directions_run),
          ),
          childWhenDragging: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.pinkAccent,
            child: const Center(
              child: Text('Child When Dragging'),
            ),
          ),
          child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.lightGreenAccent,
            child: const Center(
              child: Text('Draggable'),
            ),
          ),
        ),
        DragTarget<int>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
              height: 100.0,
              width: 100.0,
              color: Colors.cyan,
              child: Center(
                child: Text('Value is updated to: $acceptedData'),
              ),
            );
          },
          onAccept: (int data) {
            setState(() {
              acceptedData += data;
            });
          },
        ),
      ],
    );
  }
}

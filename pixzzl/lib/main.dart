import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pixzzl/api/controller.dart';
import 'package:pixzzl/screens/home.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Pixzzl());
}

final dataController = DataController();

class Pixzzl extends StatelessWidget {
  const Pixzzl({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixzzle',
      home: HomePage(),
    );
  }
}

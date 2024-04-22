//holds restaurant menu contents

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class menu extends StatefulWidget {
  final String restaurant;
  const menu({super.key, required this.restaurant});

  @override
  State<menu> createState() => _menuState(restaurant);
}

class _menuState extends State<menu> {
  String restaurant;
  _menuState(this.restaurant);

  Widget build(BuildContext context) {
    return Scaffold();
  }
}

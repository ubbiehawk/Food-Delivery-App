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
  final String title;
  const menu({super.key, required this.restaurant, required this.title});

  @override
  State<menu> createState() => _menuState(restaurant, title);
}

class _menuState extends State<menu> {
  String restaurant;
  String title;
  _menuState(this.restaurant, this.title);

  late final CollectionReference _menuAppetizers = FirebaseFirestore.instance
      .collection(restaurant)
      .doc('appetizers')
      .collection('items');

  late final CollectionReference _menuEntrees = FirebaseFirestore.instance
      .collection(restaurant)
      .doc('entrees')
      .collection('items');

  late final CollectionReference _menusides = FirebaseFirestore.instance
      .collection(restaurant)
      .doc('sides')
      .collection('items');

  List<String> order = [];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$title menu'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(
              height: 30,
              thickness: 5,
              color: Colors.black,
            ),
            const Text('Appetizers', style: TextStyle(fontSize: 30)),
            Expanded(
              child: StreamBuilder(
                  stream: _menuAppetizers.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(
                                    documentSnapshot['name'] +
                                        '  --  \$${documentSnapshot['price']}',
                                    style: const TextStyle(fontSize: 14)),
                                trailing: IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {},
                                ),
                              ));
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
            const Divider(
              height: 30,
              thickness: 5,
              color: Colors.black,
            ),
            const Text('Entrees', style: TextStyle(fontSize: 30)),
            Expanded(
              child: StreamBuilder(
                  stream: _menuEntrees.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(
                                  documentSnapshot['name'] +
                                      '  --  \$${documentSnapshot['price']}',
                                  style: const TextStyle(fontSize: 14)),
                              trailing: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {},
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        ));
  }
}

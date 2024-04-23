//holds restaurant menu contents

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:food_delivery_app/checkout.dart';

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

class MenuItemList extends StatelessWidget {
  final Stream<QuerySnapshot> menuStream;

  MenuItemList({required this.menuStream, super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: menuStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _firestore.collection('order').add({
                        'name': documentSnapshot['name'],
                        'price': documentSnapshot['price'],
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Item Added To Cart'),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _menuState extends State<menu> {
  String restaurant;
  String title;
  _menuState(this.restaurant, this.title);

  late final CollectionReference _menuAppetizers = FirebaseFirestore.instance
      .collection(restaurant)
      .doc('appetizers')
      .collection('items');
  late final CollectionReference _menuMain = FirebaseFirestore.instance
      .collection(restaurant)
      .doc('main')
      .collection('items');

  late final CollectionReference _menuEntrees = FirebaseFirestore.instance
      .collection(restaurant)
      .doc('entrees')
      .collection('items');

  late final CollectionReference _menusides = FirebaseFirestore.instance
      .collection(restaurant)
      .doc('sides')
      .collection('items');

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> order = [];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('$title menu'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                color: Colors.grey)
          ],
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
              child: MenuItemList(menuStream: _menuAppetizers.snapshots()),
            ),
            const Divider(
              height: 30,
              thickness: 5,
              color: Colors.black,
            ),
            const Text('Main Course', style: TextStyle(fontSize: 30)),
            Expanded(
              child: MenuItemList(menuStream: _menuMain.snapshots()),
            ),
            const Divider(
              height: 30,
              thickness: 5,
              color: Colors.black,
            ),
            const Text('Entrees', style: TextStyle(fontSize: 30)),
            Expanded(
              child: MenuItemList(menuStream: _menuEntrees.snapshots()),
            ),
          ],
        ));
  }
}

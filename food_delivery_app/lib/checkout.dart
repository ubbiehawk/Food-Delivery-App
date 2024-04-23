
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'firebase_options.dart';
import 'package:food_delivery_app/main.dart';
import 'package:food_delivery_app/receipt.dart';

late final CollectionReference _orders = FirebaseFirestore.instance.collection('order');

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double total = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Checkout'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Divider(
            height: 30,
            thickness: 5,
            color: Colors.black,
          ),
          const Text('Current Order', style: TextStyle(fontSize: 30)),
          Expanded(
            child: StreamBuilder(
              stream: _orders.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  // Calculate total price
                  // total = streamSnapshot.data!.docs.fold<double>(
                  //   0,
                  //   (previousValue, doc) => previousValue + doc['price'],
                  // );

                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            documentSnapshot['name'] + '  --  \$${documentSnapshot['price']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _orders.doc(documentSnapshot.id).delete();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Deleted From Cart')));
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
            ),
          ),
          const Divider(
            height: 30,
            thickness: 5,
            color: Colors.black,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Total Price:', style: TextStyle(fontSize: 30)),
                Text(
                  '\$$total',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {
             // _clearCurrentOrder();
             Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmationScreen()));
            },
            child: Text('Check Out', style: TextStyle(fontSize: 25)),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 50),
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 10, 10, 10),
            ),
          ),
          SizedBox(height: 130),
        ],
      ),
    );
  }

  void _clearCurrentOrder() {
    // Clear current order data
    _orders.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}

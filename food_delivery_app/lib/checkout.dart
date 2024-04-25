import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/receipt.dart';

final CollectionReference _orders =
    FirebaseFirestore.instance.collection('order');

class Cart extends StatefulWidget {
  @override
  CartScreen createState() => CartScreen();
}

class CartScreen extends State<Cart> {
  double total = 0;

  Future<void> calculateTotal() async {
    total = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('order').get();

    querySnapshot.docs.forEach((doc) {
      total += (doc['price'] ?? "0") ?? 0;
    });

    setState(() {
      total;
    });
  }

  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title:
            const Text('Cart Checkout', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Divider(
            height: 30,
            thickness: 4,
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
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      setState() {
                        total = documentSnapshot['price'];
                      }

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            documentSnapshot['name'] +
                                '  --  \$${documentSnapshot['price']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _orders.doc(documentSnapshot.id).delete();
                              calculateTotal();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Item Deleted From Cart')));
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
            thickness: 4,
            color: Colors.black,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Total Price:', style: TextStyle(fontSize: 30)),
                Text(
                  '\$$total',
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {
              // _clearCurrentOrder();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmationScreen()));
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 50),
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 10, 10, 10),
            ),
            child: const Text('Check Out', style: TextStyle(fontSize: 25)),
          ),
          const SizedBox(height: 130),
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

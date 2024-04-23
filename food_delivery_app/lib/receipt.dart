//shows user receipt, driver details, and order tracking

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

late final CollectionReference _orders = FirebaseFirestore.instance.collection('order');

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}
class _ConfirmationScreenState extends State<ConfirmationScreen> {
  late Timer _timer;
  late int _timerDuration =120;

  @override
  void initState() {
    super.initState();
    // Generate a random duration of either 1 or 4 minutes
    final random = Random();
    
    // Start the timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--;
        } 
      
        else {
        
          _timer.cancel(); 
        
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Divider(
            height: 30,
            thickness: 5,
            color: Colors.black,
          ),
          const Text('Order Confirmation', style: TextStyle(fontSize: 30)),
          Expanded(
            child: StreamBuilder(
              stream: _orders.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
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
          const Text('Estimated Delivery Time:', style: TextStyle(fontSize: 20)),
          Text(
            '${(_timerDuration / 60).floor()}:${(_timerDuration % 60).toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: _timerDuration > 0 ? (1 - _timerDuration / 120) : 1,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 40,)
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
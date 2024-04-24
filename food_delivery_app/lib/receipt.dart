import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

late final CollectionReference _orders =
    FirebaseFirestore.instance.collection('order');

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  int randomDriver = 0;
  final List<String> _drivernames = <String>['Marcus', 'Angela', 'Peter'];
  final List<String> _cardetails = <String>[
    'Black Toyota Camry',
    'White Chevy Camaro',
    'Red Honda Civic',
  ];
  final List<String> _drivercars = <String>[
    'toyotacamry.png',
    'chevycamaro.png',
    'hondacivic.png'
  ];

  late Timer _timer;
  late int _timerDuration = 120;

  @override
  void initState() {
    super.initState();
    // Generate a random duration of either 1 or 4 minutes
    final random = Random();
    randomDriver = Random().nextInt(3);

    // Start the timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--;
        } else {
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
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          title:
              const Text('Confirmation', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: const Text('Go back to homepage',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop()
                  ..pop();
              },
            )
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Divider(
            height: 30,
            thickness: 4,
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
          Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Image(
                    image: AssetImage('assets/${_drivercars[randomDriver]}')),
                title: Text('Your driver: ${_drivernames[randomDriver]}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Driving a ${_cardetails[randomDriver]}'),
              )),
          const Text('Estimated Delivery Time:',
              style: TextStyle(fontSize: 20)),
          Text(
            '${(_timerDuration / 60).floor()}:${(_timerDuration % 60).toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: _timerDuration > 0 ? (1 - _timerDuration / 120) : 1,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(
            height: 40,
          ),
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

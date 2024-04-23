import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'firebase_options.dart';
import 'package:food_delivery_app/main.dart';


late final CollectionReference _orders = FirebaseFirestore.instance.collection('order');
class CartScreen extends StatelessWidget{

Widget build(BuildContext context) {
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
            Center(       
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const Text('Total Price: Total Here', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
          
        ],
      ),    
              
            ),
        SizedBox(height: 60,),
           ElevatedButton(onPressed: (){
            _clearCurrentOrder();
           }, 
           child: Text('Check Out', style: TextStyle(fontSize:25),),
             style: ElevatedButton.styleFrom(
    minimumSize: Size(200, 50),
    foregroundColor: Colors.white,
    backgroundColor: Color.fromARGB(255, 10, 10, 10), // Change the width and height here
  ), ),
   SizedBox(height: 130,),
           
          ],
        ));
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


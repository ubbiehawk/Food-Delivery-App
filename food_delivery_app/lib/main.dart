import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Food Delivery App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _Homepage();
}

class _Homepage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const menu(
                                    restaurant: 'tacomac', title: 'Taco Mac')));
                      },
                      child: const Card(
                        child: ListTile(
                          leading: Image(
                              image:
                                  AssetImage('assets/tacomac/tacomaclogo.png')),
                          title: Text('Taco Mac',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Text('Sports bar & grill'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const menu(
                                    restaurant: 'hattiebs',
                                    title: 'Hattie B\'s')));
                      },
                      child: const Card(
                        child: ListTile(
                          leading: Image(
                              image: AssetImage(
                                  'assets/hattiebs/hattiebslogo.png')),
                          title: Text('Hattie B\'s',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Text('Nashville hot chicken'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const menu(
                                    restaurant: 'hungryaf',
                                    title: 'Hungry AF')));
                      },
                      child: const Card(
                        child: ListTile(
                          leading: Image(
                              image: AssetImage(
                                  'assets/hungryaf/hungryaflogo.png')),
                          title: Text('Hungry AF',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Text('American cuisine'),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}

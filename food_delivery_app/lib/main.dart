import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    //Clickable cards
                    //3 restaurants: Taco Mac, Hattie B's, and Hungry AF
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Menu(
                                    restaurant: 'tacomac', title: 'Taco Mac')));
                      },
                      child: const Card(
                        child: ListTile(
                          leading: Image(
                              image: AssetImage('assets/tacomaclogo.png')),
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
                                builder: (context) => const Menu(
                                    restaurant: 'hattiebs',
                                    title: 'Hattie B\'s')));
                      },
                      child: const Card(
                        child: ListTile(
                          leading: Image(
                              image: AssetImage('assets/hattiebslogo.png')),
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
                                builder: (context) => const Menu(
                                    restaurant: 'hungryaf',
                                    title: 'Hungry AF')));
                      },
                      child: const Card(
                        child: ListTile(
                          leading: Image(
                              image: AssetImage('assets/hungryaflogo.png')),
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

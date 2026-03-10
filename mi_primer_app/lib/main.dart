import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi primer App',
      theme: ThemeData(
      
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 209, 28, 215)),
      ),
      home: const MyHomePage(title: 'Mi Primer App', email:'izzobee@gmail.com'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final String email;
  const MyHomePage({super.key, required this.title, this.email=''});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 100;

  void _incrementCounter() {
    setState(() {
     
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app_outlined),
           
            
          ),
        ],
      ),
      body: Center(
        
        child: Column(
         
          mainAxisAlignment: .center,
          children: [
            const Text('Contador de clicks:'),
            const Text('Bienvenido:'),

            Row(
              mainAxisAlignment: .center,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.remove)),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(onPressed: (){_incrementCounter();}, icon: Icon(Icons.add)),]
            )
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

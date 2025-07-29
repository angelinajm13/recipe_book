import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MyApp());

// MyApp widget
// This widget is the root of the application.
// It sets up the MaterialApp with a title and the home widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hola mundo',
      home: const RecipeBook(),
    );
  }
}

// RecipeBook widget
// This widget represents a simple recipe book application.
// It contains an AppBar with a title and a background color.
class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          // AppBar widget es la barra superior de la aplicación.
          backgroundColor: Colors.orange,
          title: Text('Recipe Book', style: TextStyle(color: Colors.white)),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [Tab(icon: Icon(Icons.home), text: 'Home')],
          ),
        ),
        body: TabBarView(children: [HomeScreen()]),
      ),
    );
  }
}

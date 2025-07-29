import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // área principal de la aplicación.
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          // cajita con bordes y sombra
          child: Row(
            children: <Widget>[
              Container(
                // este container es una caja que contiene un widget.
                height: 125,
                width: 100,
                child: ClipRRect(
                  // da bordes redondeados a un widget.
                  borderRadius: BorderRadius.circular(10),
                  child: Container(),
                ),
              ),
              SizedBox(width: 26),
              Column(
                //apila widgets verticalmente.
                children: <Widget>[
                  Text('Lasagna'),
                  Text('Alison J'),
                  Container(height: 2, width: 75, color: Colors.orange),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
